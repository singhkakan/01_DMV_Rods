#!/bin/bash
# =============================================================================
# Verify all downloaded PRJNA558977 HiC_Retina_NRLGFPpositive FASTQs against ENA's
# reported MD5 checksums.
#
# Run this on a Sherlock LOGIN node for the metadata fetch (lightweight),
# then submit the checksum verification itself as a batch job (see
# verify_downloads.sbatch below) since checksumming ~1TB takes real I/O time.
# =============================================================================
set -euo pipefail

SAMPLE="SAMN12505194"   # HiC_Retina_NRLGFPpositive
DEST="${SCRATCH}/PRJNA558977/fastq/NRL_GFP_Pos"
REPORT="ena_md5_report.tsv"
CHECKFILE="expected_checksums.md5"

# -----------------------------------------------------------------------------
# Step 1: pull run_accession, fastq_ftp, and fastq_md5 together - order of
# entries within fastq_ftp and fastq_md5 always corresponds 1:1 per ENA's API.
# -----------------------------------------------------------------------------
curl -s "https://www.ebi.ac.uk/ena/portal/api/filereport?accession=${SAMPLE}&result=read_run&fields=run_accession,fastq_ftp,fastq_md5&format=tsv" \
  -o "${REPORT}"

echo "Fetched metadata for $(($(wc -l < "${REPORT}") - 1)) runs."

# -----------------------------------------------------------------------------
# Step 2: build a standard md5sum-compatible checksum file:
#   <md5>  <filename>
# referencing files by their basename as they exist in $DEST after download.
# -----------------------------------------------------------------------------
> "${CHECKFILE}"

tail -n +2 "${REPORT}" | while IFS=$'\t' read -r run_acc ftp_field md5_field; do
  IFS=';' read -ra FILES <<< "${ftp_field}"
  IFS=';' read -ra MD5S  <<< "${md5_field}"

  for i in "${!FILES[@]}"; do
    fname=$(basename "${FILES[$i]}")
    echo "${MD5S[$i]}  ${DEST}/${fname}" >> "${CHECKFILE}"
  done
done

N=$(wc -l < "${CHECKFILE}")
echo "Wrote ${N} expected checksums to ${CHECKFILE}"
echo ""
echo "Next: submit the verification job:"
echo "  sbatch verify_downloads.sbatch"