# AGENTS.md

## Cursor Cloud specific instructions

Reccaster is an EPICS module (a RecSync *client*) built with the standard EPICS
Base make system. There is no package manager; the only external dependency is
EPICS Base.

### Environment (already provisioned in the VM snapshot)
- EPICS Base **7.0.9** is prebuilt at `$HOME/epics/base`. `EPICS_HOST_ARCH` is
  `linux-x86_64`.
- `configure/RELEASE.local` (git-ignored) points the build at EPICS Base. It is
  (re)created by the startup update script, so you normally don't touch it.
- Build outputs land in the git-ignored `bin/`, `lib/`, `dbd/`, `db/`, and
  `O.*/` directories.

### Build / test / lint / run
- Build: `make` at the repo root (`make rebuild` for a clean rebuild). See the
  root `Makefile` and `configure/`.
- Test: `make runtests` runs the EPICS host test harness (240 tests, defined in
  `castApp/src/Makefile`).
- Lint: `pre-commit run --all-files` (config in `.pre-commit-config.yaml`).
  `pre-commit` is installed under `~/.local/bin`; if it is not on `PATH`, run it
  as `python3 -m pre_commit run --all-files`.
- Run the demo IOC: from `iocBoot/iocdemo`, run
  `IOCSH_NAME=IOC1 ../../bin/linux-x86_64/demo ./st.cmd`.
  The `Can't open envPaths` message at startup is benign: `envPaths` targets the
  unused `linux-x86_64-debug` arch, but the IOC still runs (this mirrors the
  `Dockerfile`, which launches the plain `linux-x86_64` binary directly).

### End-to-end behavior
Reccaster listens on **UDP port 5049** for a recceiver server announcement, then
opens a TCP connection and uploads the IOC's record list (records, aliases, and
info/env tags), after which it answers periodic server pings. Its live status is
published on the records `<IOCNAME>:State-Sts` and `<IOCNAME>:Msg-I`
(`Searching` -> `Connected` -> `Synchronized`). The actual server
(RecCeiver/ChannelFinder) is **not** in this repo; it lives in the separate
[recsync](https://github.com/ChannelFinder/recsync) project. To exercise the
full protocol locally without it, run a small mock server that announces over
UDP and accepts the TCP upload.

### CI note
The `.ci` submodule (epics-base/ci-scripts) is only used by GitHub Actions
(`python .ci/cue.py prepare|build|test`). Local development does not need it; the
build uses EPICS Base directly via `configure/RELEASE.local`.
