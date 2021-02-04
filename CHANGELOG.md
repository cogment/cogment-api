# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

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
