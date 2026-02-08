# Contributing to SDUI Starter Kit

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/my_sdui_app.git`
3. Create a new branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes
6. Commit your changes: `git commit -m "Add your feature"`
7. Push to your fork: `git push origin feature/your-feature-name`
8. Open a Pull Request

## Development Setup

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation Steps

```bash
# Get dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Code Style

This project follows the official Dart style guide and uses flutter_lints.

### Formatting
```bash
dart format .
```

### Linting
```bash
flutter analyze
```

## Architecture Guidelines

### Clean Architecture Layers

1. **Domain Layer** (`lib/features/*/domain/`)
   - Contains business logic
   - No dependencies on other layers
   - Define entities, repositories, and use cases

2. **Data Layer** (`lib/features/*/data/`)
   - Implements domain repositories
   - Contains data sources and models
   - Handles API calls and data transformation

3. **Presentation Layer** (`lib/features/*/presentation/`)
   - Contains UI components
   - Uses BLoC for state management
   - Depends only on domain layer

### Adding a New Feature

1. Create the feature directory structure:
```
lib/features/your_feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

2. Follow the dependency rule: Domain ← Data, Domain ← Presentation

3. Register dependencies in `lib/core/di/injection.dart`

4. Add tests for your feature

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/sdui/domain/usecases/get_screen_config_test.dart
```

### Writing Tests

- Write unit tests for business logic (use cases)
- Write widget tests for UI components
- Use mocks for external dependencies
- Follow the Arrange-Act-Assert pattern

Example:
```dart
test('should return data when call is successful', () async {
  // Arrange
  when(mockRepository.getData())
      .thenAnswer((_) async => Right(testData));
  
  // Act
  final result = await useCase(NoParams());
  
  // Assert
  expect(result, Right(testData));
  verify(mockRepository.getData());
});
```

## Commit Messages

Follow the Conventional Commits specification:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

Examples:
```
feat: add user authentication feature
fix: resolve navigation bug on profile screen
docs: update README with setup instructions
```

## Pull Request Guidelines

1. **Title**: Use a clear, descriptive title
2. **Description**: Explain what changes you made and why
3. **Testing**: Describe how you tested your changes
4. **Screenshots**: Include screenshots for UI changes
5. **Breaking Changes**: Clearly document any breaking changes

### PR Template

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How did you test your changes?

## Screenshots (if applicable)
Add screenshots here

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] I have added tests that prove my fix/feature works
- [ ] All tests pass locally
```

## Adding New SDUI Components

To add a new component type:

1. Update `ComponentRenderer` in `lib/features/sdui/presentation/widgets/component_renderer.dart`

2. Add a new case in the switch statement:
```dart
case 'your-component':
  return _buildYourComponent(config.properties);
```

3. Implement the builder method:
```dart
Widget _buildYourComponent(Map<String, dynamic> properties) {
  // Extract properties
  // Return widget
}
```

4. Document the component in `SDUI_GUIDE.md`

5. Add example JSON in `EXAMPLES.md`

6. Write tests for the component

## Code Review Process

1. All PRs require at least one approval
2. All tests must pass
3. Code must follow style guidelines
4. Documentation must be updated if needed

## Questions?

If you have questions, please:
1. Check existing issues
2. Open a new issue with the "question" label
3. Join our community discussions

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

## Thank You!

Your contributions make this project better for everyone. Thank you for taking the time to contribute!
