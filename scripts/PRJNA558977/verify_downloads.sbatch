#!/bin/bash
#SBATCH --job-name=verify_md5
#SBATCH --partition=normal
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8      # md5sum is CPU-light but I/O heavy; a handful
                                # of parallel workers speeds this up a lot on
                                # a parallel filesystem like $SCRATCH
#SBATCH --mem=4G
#SBATCH --output=logs/verify_md5_%j.out
#SBATCH --error=logs/verify_md5_%j.err

set -uo pipefail   # NOTE: no -e here - we want to keep going and report all
                    # failures rather than exit on the first mismatch

mkdir -p logs

CHECKFILE="expected_checksums.md5"
RESULTS="md5_check_results.txt"

# md5sum -c reads "<hash>  <path>" lines and reports OK/FAILED per file.
# Split the checkfile into chunks and verify in parallel with xargs.
split -n l/8 "${CHECKFILE}" checksum_chunk_

for chunk in checksum_chunk_*; do
  md5sum -c "${chunk}" >> "${RESULTS}" 2>&1 &
done
wait

rm -f checksum_chunk_*

echo ""
echo "===== SUMMARY ====="
TOTAL=$(wc -l < "${RESULTS}")
FAILED=$(grep -c "FAILED" "${RESULTS}" || true)
MISSING=$(grep -c "No such file" "${RESULTS}" || true)
OK=$(grep -c ": OK" "${RESULTS}" || true)

echo "Total checked: ${TOTAL}"
echo "OK: ${OK}"
echo "FAILED (checksum mismatch): ${FAILED}"
echo "MISSING (file not found): ${MISSING}"

if [ "${FAILED}" -gt 0 ] || [ "${MISSING}" -gt 0 ]; then
  echo ""
  echo "Problem files:"
  grep -E "FAILED|No such file" "${RESULTS}"
fi