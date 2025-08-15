# memfuzz-lab

CI-driven fuzzing lab using AFL++ with GitHub Actions.

- Pipeline: `.github/workflows/fuzz.yml`
- Post-processing & reporting: `.github/workflows/fuzz_report.yml`

## Quick start
1) Push changes to trigger the main fuzzing pipeline.
2) The post-pipeline job downloads artifacts, counts crashes per target, and opens Issues with links and inputs (if any).
