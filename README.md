# Reproducibility Artifact

Code and data to reproduce every number, table, and figure in the two
submitted papers (the mechanism-safety study and the verifiable-system study).
All results below were produced on the experiment runs described in the
manuscript; this package lets a reviewer re-run the code and re-check the
reported values against the archived JSON outputs in `data/`.

## Layout

```
code/
  e1/            E1 (fitting attack) + E1b (selection attack) — pure-Python synthetic, CPU
  e2/            E2/E3/E4/E5 main framework (run_e2.py, run_extra.py) + e2/ package + tests
  tier0/         Gate-1 determinism engine (run_gate1.py) — CPU
  calibration/   proving-cost calibration (run_calibration.py, prover_adapter.py) — CPU
  proof_system/  FP64 domain check (fp64_domain_check.py, static_domain_audit.py)
  hpc/           H20 deployment & run scripts (platform_run.sh, verify_env.py, slurm/)
data/
  e1/  e2/  tier0/  calibration/  proof_system/   archived measurement outputs (JSON/MD/CSV)
  cifar10_fetch.sh   downloads + md5-checks the CIFAR-10 dataset (not shipped)
requirements.txt     combined dependencies
MANIFEST_sha256.txt  sha256 of every file in this archive
```

## Quick start (CPU, no dataset, seconds)

```bash
pip install -r requirements.txt
python code/e2/run_e2.py --smoke          # synthetic smoke test, CPU only
python code/tier0/run_gate1.py --check     # Gate-1 determinism self-test
python code/e1/run_e1.py --help            # fitting-attack driver
```

## Experiment → code → archived data

| Exp | What it measures | Entry point | Archived result |
|-----|------------------|-------------|-----------------|
| E1  | Fitting-attack alignment gain | `code/e1/run_e1.py` | `data/e1/e1_summary.json`, `e1_main_table.md`, `e1_curves.csv`, `e1_alignment_recheck.json` |
| E1b | Selection-attack (blind control) | `code/e1/selection_attack.py` | `data/e1/e1b_selection.json`, `e1b_selection.md`, `e1_m_sweep.md` |
| E2  | CIFAR-10/LeNet real-model attack surface | `code/e2/run_e2.py` | `data/e2/e2_summary.json`, `e2_main_table.md`, `e2_curves.csv`, `environment_fingerprint.json` |
| E3  | Score-variance Monte-Carlo (6000-step config, CPU) | `code/e2/run_e2.py` + `code/e2/make_snippets_e3.py` | `data/e2/e3_6000/e3_variance.json`, `e3_a/`, `e3_b/` |
| E4  | Membership-inference leakage | `code/e2/run_extra.py` (+ `test_leakage_e4.py`) | `data/e2/e2_summary.json` (E4 section) |
| E5  | Aggregation robustness | `code/e2/run_extra.py` (+ `test_aggregate_e5.py`) | `data/e2/e2_summary.json` (E5 section) |
| E6  | Determinism / false-reject (CPU, closed-form check) | `code/tier0/run_gate1.py` | `data/tier0/gate1_report.json` |
| Cal | Proving cost, FP64 throughput, power-law fit | `code/calibration/run_calibration.py`, `prover_adapter.py` | `data/calibration/cost_calibration.*`, `env_fingerprint.*`, `power_law_fit.txt` |
| FP64| FP64 domain check (proof-system selection) | `code/proof_system/fp64_domain_check.py` | `data/proof_system/fp64_*.json` |

## Reproduction notes

- **Host classes.** E1/E1b and E3 are pure-Python synthetic runs on CPU; E2/E4/E5
  were executed on the H20 GPU platform (logs in the platform returns archived
  under `data/e2/conv_sweep_*.md`); E6 and the calibration run on CPU and depend
  only on numpy/torch, so their numbers are reproducible without a GPU.
- **CIFAR-10.** Run `bash data/cifar10_fetch.sh` before any E2 run that touches
  real data; the script verifies `md5 = c58f30108f718f92721af3b95e74349a`.
- **Why `code/e2/e2/attacks.py` here (not `hpc/upload`).** The snapshot under
  `hpc/upload/code/e2/e2/attacks.py` is a pre-patch version missing the
  `device=` handling; this archive ships the corrected source that actually
  produced the reported numbers. Do not substitute the upload snapshot.
- **Verification without a GPU.** Every reported value is archived as JSON in
  `data/`, so a reviewer can validate the manuscript tables against the raw
  outputs without re-running the multi-hour GPU experiments.

## Integrity

`MANIFEST_sha256.txt` lists the sha256 of every file. Verify with:

```bash
cd <archive root> && sha256sum -c MANIFEST_sha256.txt
```
