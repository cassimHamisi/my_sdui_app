# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-02-08

### Added
- Initial release of SDUI Starter Kit
- Clean Architecture implementation with three layers (Domain, Data, Presentation)
- BLoC pattern for state management using flutter_bloc
- GoRouter for declarative routing and navigation
- Dependency Injection using GetIt
- SDUI component renderer supporting:
  - Text components with customizable styles
  - Button components with actions
  - Container components with padding/margin
  - Column and Row layouts
  - Image components with network loading
  - Card components with elevation
- Error handling with Either type from dartz
- Comprehensive documentation:
  - README with setup instructions
  - ARCHITECTURE guide explaining clean architecture
  - SDUI_GUIDE with component specifications
  - EXAMPLES with sample JSON responses
  - CONTRIBUTING guide for contributors
- Unit tests for:
  - Domain use cases
  - BLoC state management
- Analysis options with Flutter lints
- Melos configuration for monorepo management
- Example screens:
  - Home screen with navigation
  - SDUI screen with dynamic rendering
- Network layer with Dio and error handling
- JSON serialization with json_serializable

### Architecture
- **Domain Layer**: Business entities, repository interfaces, and use cases
- **Data Layer**: Repository implementations, data sources, and models
- **Presentation Layer**: BLoC, pages, and widgets

### Dependencies
- flutter_bloc: ^8.1.3
- go_router: ^12.1.3
- get_it: ^7.6.4
- dio: ^5.4.0
- dartz: ^0.10.1
- equatable: ^2.0.5
- json_annotation: ^4.8.1

### Dev Dependencies
- build_runner: ^2.4.6
- flutter_lints: ^3.0.1
- mockito: ^5.4.4
- bloc_test: ^9.1.5

[1.0.0]: https://github.com/cassimHamisi/my_sdui_app/releases/tag/v1.0.0
