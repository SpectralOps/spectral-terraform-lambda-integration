# Change Log

All notable changes to this project will be documented in this file.

## [4.0.2] - 2024-10-14
- **Spectral Bot Update (GitLab + Github)**: Upgraded to version `2.2.1`.
  - **New Feature**: Support for self signed SSL certificate for gitlab self hosted

## [4.0.1] - 2024-09-29

### Changed

- **Spectral Bot Update (GitHub & GitLab)**: Upgraded to version `2.2.0`.
  - **New Feature**: The bot now supports handling GitHub `synchronize` events for pull requests, enabling scanning of code contributions during updates.

## [4.0.0] - 2024-09-01

### Added

- Support to Gitlab bot deployment integration

### Changed

- API gateway path

## [3.0.0] - 2024-06-25

### Added

- Support to GitHub bot 2.x deployment integration
- Enable running multiple bot instances of the same type in a single region
- Enable setting a custom pattern for all the resources created by the module
- Enable setting a path to the lambda source code (Zip file)

### Changed

- Lambdas runtime upgraded to node20.x

## [2.1.0] - 2023-08-16

### Added

- Support hardening & engines flag 

## [2.0.0] - 2023-06-18

### Changed

- GitLab's integration infrastructure is now based on multiple lambda functions to make sure the response is being sent to GitLab in less than 10 seconds

## [1.1.1] - 2023-05-31

### Added

- Option to pull the secrets required for the GitLab bot to accessed from AWS secrets manager

## [1.1.0] - 2022-12-11

### Changed

- New versions of GitLab and TFC using new Spectral severities

## [1.0.2] - 2022-10-23

### Added

- Support for Jira integration
- Support for GitLab integration

## [1.0.1] - 2022-10-05

### Changed

- Bots are now downloading the latest Spectral scanner version instead of accessing the scanner through a lambda layer

## [1.0.0] - 2022-09-11

### Added

- Added support for Terraform cloud integration
