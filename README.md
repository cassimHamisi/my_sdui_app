# SDUI Starter Kit

A Lean Server-Driven UI (SDUI) Starter Kit built with Flutter, Clean Architecture, BLoC/Cubit, and GoRouter for navigation.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three main layers:

### Domain Layer
- **Entities**: Core business models (`ScreenConfig`, `ComponentConfig`)
- **Repositories**: Abstract repository interfaces
- **Use Cases**: Business logic (`GetScreenConfig`)

### Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Remote data sources for API calls
- **Repository Implementations**: Concrete implementations of domain repositories

### Presentation Layer
- **BLoC/Cubit**: State management using flutter_bloc
- **Pages**: UI screens
- **Widgets**: Reusable UI components

## 🚀 Features

- ✅ **Server-Driven UI**: Dynamic UI rendering based on server responses
- ✅ **Clean Architecture**: Separation of concerns with clear layer boundaries
- ✅ **BLoC Pattern**: Predictable state management
- ✅ **GoRouter**: Declarative routing with deep linking support
- ✅ **Dependency Injection**: Using GetIt for DI
- ✅ **Error Handling**: Comprehensive error handling with Either type
- ✅ **Type Safety**: Strong typing with Dart 3.0+

## 📁 Project Structure

```
lib/
├── core/
│   ├── di/              # Dependency injection setup
│   ├── error/           # Error handling (failures, exceptions)
│   ├── router/          # GoRouter configuration
│   └── usecases/        # Base use case class
├── features/
│   └── sdui/
│       ├── data/
│       │   ├── datasources/    # Remote data sources
│       │   ├── models/         # Data models with JSON serialization
│       │   └── repositories/   # Repository implementations
│       ├── domain/
│       │   ├── entities/       # Business entities
│       │   ├── repositories/   # Repository interfaces
│       │   └── usecases/       # Business logic use cases
│       └── presentation/
│           ├── bloc/           # BLoC for state management
│           ├── pages/          # UI screens
│           └── widgets/        # Reusable widgets
└── main.dart           # App entry point
```

## 🛠️ Setup

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/cassimHamisi/my_sdui_app.git
   cd my_sdui_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for JSON serialization)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🎨 SDUI Component Types

The app supports the following server-driven components:

- **text**: Render text with customizable styles
- **button**: Interactive buttons with actions
- **container**: Layout container with padding/margin
- **column**: Vertical layout
- **row**: Horizontal layout
- **image**: Network images
- **card**: Material card component

### Example JSON Response

```json
{
  "id": "home",
  "title": "Home Screen",
  "components": [
    {
      "id": "welcome-text",
      "type": "text",
      "properties": {
        "text": "Welcome to SDUI!",
        "fontSize": 24,
        "fontWeight": "bold",
        "color": "#000000"
      }
    },
    {
      "id": "action-button",
      "type": "button",
      "properties": {
        "text": "Get Started",
        "onPress": "/profile"
      }
    }
  ]
}
```

## 📦 Dependencies

### Core
- `flutter_bloc`: State management
- `go_router`: Routing and navigation
- `get_it`: Dependency injection
- `dartz`: Functional programming (Either, Option)
- `equatable`: Value equality

### Network
- `dio`: HTTP client
- `retrofit`: Type-safe REST client
- `json_annotation`: JSON serialization

### Dev Dependencies
- `build_runner`: Code generation
- `json_serializable`: Generate JSON serialization code
- `mockito`: Mocking for tests
- `bloc_test`: Testing BLoC

## 🧪 Testing

Run unit tests:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 🎯 Usage

### Adding a New SDUI Screen

1. Navigate to the screen using GoRouter:
   ```dart
   context.go('/sdui/your-screen-id');
   ```

2. The app will fetch the screen configuration from the server using the screen ID.

3. The `ComponentRenderer` will dynamically render the UI based on the response.

### Customizing the API Endpoint

Update the base URL in `lib/core/di/injection.dart`:

```dart
sl.registerLazySingleton(() => Dio(
  BaseOptions(
    baseUrl: 'https://your-api.com', // Your API URL
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ),
));
```

## 🔧 Configuration

### Adding New Component Types

To add a new component type, update the `ComponentRenderer` widget in:
`lib/features/sdui/presentation/widgets/component_renderer.dart`

```dart
case 'your-component-type':
  return _buildYourComponent(config.properties);
```

## 📝 Best Practices

1. **Separation of Concerns**: Keep business logic in use cases
2. **Immutability**: Use const constructors where possible
3. **Error Handling**: Always handle errors gracefully with Either
4. **Type Safety**: Leverage Dart's strong typing
5. **Testing**: Write tests for business logic and critical paths

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the MIT License.

## 📧 Contact

For questions or feedback, please open an issue on GitHub.

---

**Built with ❤️ using Flutter**
