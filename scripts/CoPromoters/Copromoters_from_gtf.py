#!/usr/bin/env python3
"""
copromoter_from_gtf.py

Identify "co-promoter" transcript pairs directly from a genome GTF file:
pairs of GENCODE/Ensembl "basic" transcripts on opposite strands whose
transcription start sites (TSS) lie within a given distance of each other
(default: 400 bp).

Usage:
    python3 copromoter_from_gtf.py annotation.gtf [--distance 400] [--output pairs.bed]

Output (tab-separated, one row per unique co-promoter gene pair):
    chrom  start(TSS1)  end(TSS2)  strand(gene1)  geneID(gene1)  transcriptID(gene1)  geneID(gene2)  transcriptID(gene2)  copromoterID

Notes:
    * Only transcripts carrying the GTF attribute tag "basic" are considered
      by default (GENCODE's curated basic transcript set). Annotations that
      do not use this tag (e.g., RefSeq) will yield zero rows unless you pass
      --no-basic-filter.
    * Every transcript of every gene is compared against every transcript of
      every gene on the opposite strand (not just gene-level TSS). A given
      gene pair can therefore have more than one qualifying transcript
      combination; these are collapsed to a single output row per unique
      (gene1, gene2) pair, keeping the transcript combination with the
      smallest TSS-to-TSS distance as the representative row.
    * "gene1" is defined as whichever transcript has the smaller (more
      upstream) TSS coordinate, so start <= end always and the file is a
      valid BED. gene2 is, by construction, on the opposite strand from
      gene1, so its strand is not repeated as a separate column.
    * GTF coordinates are 1-based, closed. TSS is converted to a 0-based BED
      coordinate (subtract 1) so downstream BED tools interpret positions
      correctly.
    * Each row is given a copromoterID of the form copromoterX_Y, where X is
      the chromosome (its "chr" prefix stripped, if present) and Y is a
      1-based running count of co-promoters on that chromosome, ordered by
      genomic position (e.g., copromoter1_1, copromoter1_2, copromoter2_1).
"""

import sys
import argparse
from bisect import bisect_left, bisect_right

def parse_attributes(attr_field):
    """Parse a GTF attribute field into a dict of key -> list of values.

    GTF attributes look like:
        gene_id "ENSG000001"; transcript_id "ENST000001"; tag "basic"; tag "CCDS";
    A key can appear more than once (e.g., multiple "tag" entries), so every
    key maps to a list of all values seen for that key.
    """
    attrs = {}
    for field in attr_field.strip().split(';'):
        field = field.strip()
        if not field:
            continue
        parts = field.split(' ', 1)
        if len(parts) != 2:
            continue
        key, value = parts
        value = value.strip().strip('"')
        attrs.setdefault(key, []).append(value)
    return attrs

def parse_gtf(file_path, require_basic=True):
    """Read a GTF file and return a dict: chrom -> {'+': [...], '-': [...]}
    Each entry in the per-strand lists is a tuple:
        (tss, gene_id, transcript_id)
    where tss is the 0-based BED coordinate of that transcript's TSS.
    Only feature type "transcript" rows are used, and (by default) only
    those carrying the tag "basic".
    """
    transcripts = {}
    n_seen = 0
    n_basic = 0

    try:
        with open(file_path, 'r') as gtf:
            for line in gtf:
                if line.startswith('#') or not line.strip():
                    continue
                columns = line.rstrip('\n').split('\t')
                if len(columns) < 9:
                    print(f"Warning: Line skipped due to insufficient columns: {line.strip()}", file=sys.stderr)
                    continue

                chrom, source, feature, start, end, score, strand, frame, attr_field = columns[:9]
                if feature != 'transcript':
                    continue
                n_seen += 1

                attrs = parse_attributes(attr_field)
                if require_basic and 'basic' not in attrs.get('tag', []):
                    continue
                n_basic += 1
                gene_id = attrs.get('gene_id', ['NA'])[0]
                transcript_id = attrs.get('transcript_id', ['NA'])[0]
                start = int(start)
                end = int(end)

                if strand == '+':
                    tss = start - 1  # GTF is 1-based; convert to 0-based BED coordinate
                elif strand == '-':
                    tss = end - 1
                else:
                    print(f"Warning: unknown strand '{strand}' for transcript {transcript_id}; skipped.", file=sys.stderr)
                    continue

                transcripts.setdefault(chrom, {'+': [], '-': []})
                transcripts[chrom][strand].append((tss, gene_id, transcript_id))

    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"An error occurred while reading '{file_path}': {e}", file=sys.stderr)
        sys.exit(1)
    if require_basic and n_seen and n_basic == 0:
        print(
            "Warning: no transcripts with tag \"basic\" were found. "
            "This annotation may not use GENCODE's basic-tag convention; "
            "re-run with --no-basic-filter if that is expected.",
            file=sys.stderr,
        )
    return transcripts

def find_copromoter_pairs(transcripts, max_distance=400):
    """Yield co-promoter transcript pair records.
    For each chromosome, '+' strand transcript TSSs are compared against
    '-' strand transcript TSSs within max_distance bp, using sorted lists and
    binary search (bisect) to define the comparison window. This scales to
    whole-genome, transcript-level annotation sets (tens of thousands of
    entries per strand) instead of the O(n^2) nested-loop scan used when
    comparing at the gene level.
    """
    for chrom, strands in transcripts.items():
        plus_list = sorted(strands['+'], key=lambda x: x[0])
        minus_list = sorted(strands['-'], key=lambda x: x[0])
        if not plus_list or not minus_list:
            continue
        minus_positions = [t[0] for t in minus_list]

        for tss_plus, gene_plus, tx_plus in plus_list:
            lo = bisect_left(minus_positions, tss_plus - max_distance)
            hi = bisect_right(minus_positions, tss_plus + max_distance)
            for tss_minus, gene_minus, tx_minus in minus_list[lo:hi]:
                distance = abs(tss_plus - tss_minus)
                if distance > max_distance:
                    continue  # safety check; window should already guarantee this
                if tss_plus <= tss_minus:
                    start, end = tss_plus, tss_minus
                    gene1, tx1, strand1 = gene_plus, tx_plus, '+'
                    gene2, tx2 = gene_minus, tx_minus
                else:
                    start, end = tss_minus, tss_plus
                    gene1, tx1, strand1 = gene_minus, tx_minus, '-'
                    gene2, tx2 = gene_plus, tx_plus
                yield (chrom, start, end, strand1, gene1, tx1, gene2, tx2)

def dedupe_by_gene_pair(pairs):
    """Collapse transcript-level pair rows to one row per unique gene pair.
    A single (gene1, gene2) pair can have several qualifying transcript
    combinations. This keeps only one representative row per unique gene
    pair per chromosome, choosing the transcript combination with the
    smallest TSS-to-TSS distance (ties broken by transcript ID for
    determinism). Gene order (which gene is "gene1") can vary across a
    gene's transcripts, so the pair is keyed on an unordered set of the two
    gene IDs.
    """
    best = {}
    for row in pairs:
        chrom, start, end, strand1, gene1, tx1, gene2, tx2 = row
        key = (chrom, frozenset((gene1, gene2)))
        distance = end - start
        tie_breaker = (distance, tx1, tx2)
        if key not in best or tie_breaker < best[key][0]:
            best[key] = (tie_breaker, row)
    return [row for _, row in best.values()]

def assign_copromoter_ids(rows):
    """Sort rows by chromosome and position and append a copromoterID column.

    IDs follow the pattern copromoterX_Y, where X is the chromosome name
    with any leading "chr" stripped, and Y is a 1-based running count of
    co-promoters on that chromosome in genomic order.
    """
    rows = sorted(rows, key=lambda r: (r[0], r[1]))
    counts = {}
    labeled = []
    for row in rows:
        chrom = row[0]
        chrom_label = chrom[3:] if chrom.lower().startswith('chr') else chrom
        counts[chrom] = counts.get(chrom, 0) + 1
        copromoter_id = f"copromoter{chrom_label}_{counts[chrom]}"
        labeled.append(row + (copromoter_id,))
    return labeled

def main():
    parser = argparse.ArgumentParser(
        description="Find co-promoter transcript pairs (opposite-strand TSSs within a given distance) from a GTF file."
    )
    parser.add_argument('gtf_file', help="Path to the input GTF annotation file.")
    parser.add_argument('--distance', type=int, default=400, help="Maximum TSS-to-TSS distance in bp (default: 400).")
    parser.add_argument('--output', default=None, help="Output BED file path (default: stdout).")
    parser.add_argument('--no-basic-filter', action='store_true',
                         help="Do not require the GTF tag \"basic\"; use all transcripts.")
    args = parser.parse_args()

    transcripts = parse_gtf(args.gtf_file, require_basic=not args.no_basic_filter)

    pairs = list(find_copromoter_pairs(transcripts, max_distance=args.distance))
    n_transcript_pairs = len(pairs)

    unique_pairs = dedupe_by_gene_pair(pairs)
    labeled_pairs = assign_copromoter_ids(unique_pairs)

    out = open(args.output, 'w') if args.output else sys.stdout
    try:
        for row in labeled_pairs:
            out.write('\t'.join(str(x) for x in row) + '\n')
    finally:
        if args.output:
            out.close()
    print(
        f"Found {n_transcript_pairs} qualifying transcript pairs, "
        f"collapsed to {len(labeled_pairs)} unique co-promoter gene pairs "
        f"within {args.distance} bp.",
        file=sys.stderr,
    )

if __name__ == "__main__":
    main()
