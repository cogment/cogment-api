# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

## v2.1.0 - 2022-02-11

### Added

- Add `COGMENT` protocol to discovery endpoint
- Add `UNKNOWN` to all discovery enums
- The `StartTrial` has a new attribute `params`

### Changed

- The discovery service point name changed to `DiscoverySP`

### Fixed

- Discovery API `Inquire` reply not a repeated field
- Clarification of Discovery API metadata name (in comments)

## v2.0.0 - 2021-11-12

### Changed

- Complete overhaul of the API
- Change to streaming model for actors and environment
- Change of package names and service names
- Removal of "delta" observations
- Addition of Datalog to parameters

## v1.2.1 - 2021-10-21

### Fixed

- Fix naming collision in the newly introduced trial datastore service messages

### Added

- Add test to check compability for every minor version of protobuf >=3.15

## v1.2.0 - 2021-10-15

### Added

- Add Trial Datastore service

## v1.1.0 - 2021-10-01

### Added

- Add Discovery service
- Add health check service
- Add Model Registry service

### Changed

- Update copyright notice to use the legal name of AI Redefined Inc.

## v1.0.0 - 2021-05-10

- Initial public release.

## v1.0.0-beta2 - 2021-04-14

### Added

- Addition of internal trial data to datalog sample

## v1.0.0-beta1 - 2021-04-07

- Initial beta release, no more breaking changes should be introduced.

## v1.0.0-alpha7 - 2021-03-30

### Added

- Addition of `tick_id` in critical places
- Addition of functionality to `GetTrialInfo`
- Datalog use bidirectional streaming

## v1.0.0-alpha6 - 2021-02-17

## v1.0.0-alpha6 - 2021-02-17

### Changed

- Filename changed from "data.proto" to "datalog.proto" to remove confusion with default user data file
- Rename ActorEndpoint and AgentPeriodData
- Refactor Reward and Feedback structure
- New method: `WatchTrials()`, that allows to monitor trial status updates.

## v1.0.0-alpha5 - 2021-01-28

### Removed

- Remove unused `actor_name` from `EnvMessageRequest`

## v1.0.0-alpha4 - 2021-01-12

### Removed

- Remove remaining traces of the legacy SendMessage method and associated types.

## v1.0.0-alpha3 - 2021-01-08

### Added

- Add implementation name to the `EnvironmentParams`.

## 1.0.0-alpha1 - 2020-12-07

- Initial alpha release, expect some breaking changes.
