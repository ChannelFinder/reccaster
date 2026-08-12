# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

The versioned surface is the module. It covers the databases in `db/`,
`reccaster.dbd` and the iocsh functions it registers, the library soname, and any
headers the module installs. A backwards incompatible change to any of these is a
major release. The wire protocol is left out: it is shared with other
implementations, and this repository cannot version it alone.

> The reccaster client previously lived in the `client/` directory of the
> [recsync](https://github.com/ChannelFinder/recsync) repository, where
> releases 1.0 through 1.9.6 were tagged. See
> [reccaster#3](https://github.com/ChannelFinder/reccaster/issues/3) for how
> those tags and their commits map onto this repository's history. Versions
> up to and including 1.9.6 predate this project's adoption of Semantic
> Versioning and use the version numbering of the combined recsync
> repository, in which some releases contain no reccaster changes.

## [Unreleased]
### Added
- LICENSE file

### Changed
- Split reccaster into a standalone repository, separate from recsync (GitHub workflows, `.gitmodules`, pre-commit config, Docker-based CI)
- Removed macos-13 from CI matrix, added macos-15-intel
- Adopted Semantic Versioning for future releases

### Removed
- Unused `ioc-compose.yml` left over from the monorepo layout (`build: ../client`)
- Committed `docker/RELEASE.local` (container-only `EPICS_BASE` path)
- `Dockerfile`, `.dockerignore`, and `.github/workflows/docker.yml` (image published to `ghcr.io/channelfinder/reccaster`)

### Fixed
- `RELEASE` include paths after the repository split
- `CONFIG_SITE` include paths after the repository split

## [1.9.6] - 2026-05-29
### Changed
- Bump `ci-scripts` submodule (`717e37e`)

## [1.9.5] - 2026-05-07
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.9.4] - 2026-05-06
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.9.3] - 2026-05-04
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.9.2] - 2026-03-31
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.9.1] - 2026-03-27
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.9.0] - 2026-03-25
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.8.1] - 2026-02-19
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.8] - 2026-01-13
### Added
- `addReccasterExcludePattern` iocsh function for excluding PVs based on name or wildcard patterns
- `dbior()` driver report showing reccaster's connection state, last message, and last server address

### Changed
- Combined `addReccasterEnvVars` and `addReccasterExcludePattern` to share a common helper function
- Added return codes to the `addReccasterExcludePattern`/`addReccasterEnvVars` iocsh functions

## [1.7] - 2025-04-03
### Changed
- Consolidated Docker compose files and CI setup used for end-to-end testing against recCeiver/ChannelFinder

### Fixed
- Skipped a flaky `testWakeup` test on macOS

## [1.6] - 2024-04-03
### Fixed
- Check socket validity before destroying it (fixes a return-check bug)

## [1.5] - 2023-08-01
### Added
- `addReccasterEnvVars` iocsh function for custom environment variables
- `recordDesc` as an optional INFO tag
- pre-commit hook configuration

### Changed
- Added `RSRV_SERVER_PORT`/`PVAS_SERVER_PORT` to the default env-var list
- Improved TCP client socket handling: use `poll()` instead of blocking reads, clearer disconnect messaging, and safer socket attach/teardown (`osiSockAttach`)

### Fixed
- Windows/MSVC and RTEMS build compatibility
- `EWOULDBLOCK`/`EAGAIN` handling in the TCP client
- RTEMS `socketpair_compat()` handling for classic vs. libbsd network stacks

## [1.4] - 2021-02-23
### Changed
- Switched CI to GitHub Actions
- Updated configuration files to match the latest EPICS modules

### Fixed
- Initialized a reserved protocol field before sending data, fixing a use of uninitialized memory
- Client RIDs being reused once more than 65536 records are in use
- Missing validation check on the wakeup socket
- `testprod` linking issue

## [1.3] - 2016-11-07
### Added
- `st_test.cmd` test IOC with 1000 channels, plus scripts/README for manual testing and cleanup debug logging

### Changed
- Added `HOSTNAME` to the default env-var list

## [1.1] - 2016-06-01
No recCaster changes were included in this combined recsync release. This tag is retained to preserve the historical version numbering of the combined repository.

## [1.0] - 2016-04-11
### Added
- Initial reccaster client implementation
- Record alias support
- Automatic HOSTNAME population on connect
- `SKIPDEMO=YES` build option
- Default `RELEASE` configuration

[Unreleased]: https://github.com/ChannelFinder/reccaster/compare/1.9.6...HEAD
[1.9.6]: https://github.com/ChannelFinder/reccaster/compare/1.9.5...1.9.6
[1.9.5]: https://github.com/ChannelFinder/reccaster/compare/1.9.4...1.9.5
[1.9.4]: https://github.com/ChannelFinder/reccaster/compare/1.9.3...1.9.4
[1.9.3]: https://github.com/ChannelFinder/reccaster/compare/1.9.2...1.9.3
[1.9.2]: https://github.com/ChannelFinder/reccaster/compare/1.9.1...1.9.2
[1.9.1]: https://github.com/ChannelFinder/reccaster/compare/1.9.0...1.9.1
[1.9.0]: https://github.com/ChannelFinder/reccaster/compare/1.8.1...1.9.0
[1.8.1]: https://github.com/ChannelFinder/reccaster/compare/1.8...1.8.1
[1.8]: https://github.com/ChannelFinder/reccaster/compare/1.7...1.8
[1.7]: https://github.com/ChannelFinder/reccaster/compare/1.6...1.7
[1.6]: https://github.com/ChannelFinder/reccaster/compare/1.5...1.6
[1.5]: https://github.com/ChannelFinder/reccaster/compare/1.4...1.5
[1.4]: https://github.com/ChannelFinder/reccaster/compare/1.3...1.4
[1.3]: https://github.com/ChannelFinder/reccaster/compare/1.1...1.3
[1.1]: https://github.com/ChannelFinder/reccaster/compare/1.0...1.1
[1.0]: https://github.com/ChannelFinder/reccaster/releases/tag/1.0
