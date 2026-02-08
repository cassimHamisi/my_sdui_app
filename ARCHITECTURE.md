# Clean Architecture in SDUI Starter Kit

## Overview

This project implements Clean Architecture principles to ensure maintainability, testability, and scalability.

## Layer Responsibilities

### 1. Domain Layer (Business Logic)

**Location**: `lib/features/sdui/domain/`

The domain layer contains the business logic and is completely independent of external frameworks.

#### Entities
- **ScreenConfig**: Represents a screen configuration
- **ComponentConfig**: Represents a UI component

```dart
class ScreenConfig extends Equatable {
  final String id;
  final String title;
  final List<ComponentConfig> components;
}
```

#### Repositories (Interfaces)
- **SduiRepository**: Abstract interface for data operations

```dart
abstract class SduiRepository {
  Future<Either<Failure, ScreenConfig>> getScreenConfig(String screenId);
}
```

#### Use Cases
- **GetScreenConfig**: Fetches screen configuration

```dart
class GetScreenConfig implements UseCase<ScreenConfig, Params> {
  final SduiRepository repository;
  
  Future<Either<Failure, ScreenConfig>> call(Params params);
}
```

### 2. Data Layer (Data Management)

**Location**: `lib/features/sdui/data/`

The data layer implements domain repository interfaces and handles data sources.

#### Models
- Extend domain entities
- Include JSON serialization/deserialization
- Transform between data and domain layers

```dart
class ScreenConfigModel extends ScreenConfig {
  factory ScreenConfigModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

#### Data Sources
- **SduiRemoteDataSource**: Fetches data from API

```dart
class SduiRemoteDataSourceImpl implements SduiRemoteDataSource {
  final Dio dio;
  
  Future<ScreenConfigModel> getScreenConfig(String screenId);
}
```

#### Repository Implementations
- Implement domain repository interfaces
- Coordinate between data sources
- Handle exceptions and convert to failures

```dart
class SduiRepositoryImpl implements SduiRepository {
  final SduiRemoteDataSource remoteDataSource;
  
  Future<Either<Failure, ScreenConfig>> getScreenConfig(String screenId);
}
```

### 3. Presentation Layer (UI)

**Location**: `lib/features/sdui/presentation/`

The presentation layer handles UI and state management.

#### BLoC/Cubit
- Manages UI state
- Calls use cases
- Transforms data for UI

```dart
class SduiBloc extends Bloc<SduiEvent, SduiState> {
  final GetScreenConfig getScreenConfig;
  
  // Event handlers
  Future<void> _onLoadScreenConfig(LoadScreenConfig event, Emitter<SduiState> emit);
}
```

#### Pages
- StatelessWidgets that represent screens
- Use BlocProvider to inject BLoC
- Use BlocBuilder to react to state changes

#### Widgets
- Reusable UI components
- Component renderers for SDUI

## Dependency Rule

Dependencies flow inward:
```
Presentation → Domain ← Data
```

- **Domain** has no dependencies on other layers
- **Data** depends on Domain
- **Presentation** depends on Domain
- **Presentation** uses Data through Domain interfaces

## Error Handling

### Failures (Domain Layer)
```dart
abstract class Failure extends Equatable {
  final String message;
}

class ServerFailure extends Failure {}
class NetworkFailure extends Failure {}
```

### Exceptions (Data Layer)
```dart
class ServerException implements Exception {
  final String message;
}
```

### Conversion
Data layer catches exceptions and converts them to failures:

```dart
try {
  final data = await remoteDataSource.getScreenConfig(screenId);
  return Right(data);
} on ServerException catch (e) {
  return Left(ServerFailure(e.message));
}
```

## Dependency Injection

Using GetIt for dependency injection:

```dart
// Use cases
sl.registerLazySingleton(() => GetScreenConfig(sl()));

// Repository
sl.registerLazySingleton<SduiRepository>(
  () => SduiRepositoryImpl(remoteDataSource: sl()),
);

// Data sources
sl.registerLazySingleton<SduiRemoteDataSource>(
  () => SduiRemoteDataSourceImpl(dio: sl()),
);
```

## Testing Strategy

### Unit Tests
- Test use cases with mocked repositories
- Test repository implementations with mocked data sources
- Test BLoC with mocked use cases

### Example:
```dart
test('should get screen config from repository', () async {
  // Arrange
  when(mockRepository.getScreenConfig(any))
      .thenAnswer((_) async => Right(tScreenConfig));
  
  // Act
  final result = await usecase(Params(screenId: tScreenId));
  
  // Assert
  expect(result, Right(tScreenConfig));
});
```

## Benefits

1. **Testability**: Each layer can be tested independently
2. **Maintainability**: Changes in one layer don't affect others
3. **Flexibility**: Easy to swap implementations (e.g., change data source)
4. **Scalability**: Easy to add new features following the same pattern
5. **Independence**: Business logic is independent of frameworks

## Adding New Features

To add a new feature:

1. Create domain entities
2. Define repository interface
3. Create use case
4. Implement data models
5. Implement data source
6. Implement repository
7. Create BLoC/Cubit
8. Create UI
9. Register dependencies
10. Add tests

## Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
