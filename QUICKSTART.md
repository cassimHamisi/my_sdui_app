# SDUI Starter Kit - Quick Start Guide

## What You Get

This is a production-ready Flutter starter kit that implements:

✅ **Server-Driven UI (SDUI)** - Update UI without app releases  
✅ **Clean Architecture** - Maintainable, testable code structure  
✅ **BLoC Pattern** - Predictable state management  
✅ **GoRouter** - Type-safe navigation  
✅ **Dependency Injection** - Decoupled components  
✅ **Mock Data** - Ready for development without backend  

## Quick Start (5 Minutes)

### 1. Prerequisites Check
```bash
flutter --version  # Should be >= 3.0.0
dart --version     # Should be >= 3.0.0
```

### 2. Setup
```bash
# Install dependencies
flutter pub get

# Generate mock files (optional - already included)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### 3. Explore
- Open the app
- Click "View Home Screen (SDUI)" to see server-driven UI in action
- Click "View Profile Screen (SDUI)" to see another example
- Notice how the UI is completely driven by JSON data!

## Project Structure at a Glance

```
lib/
├── main.dart                 # Entry point
├── core/
│   ├── di/                   # Dependency injection
│   ├── error/                # Error handling
│   ├── router/               # Navigation setup
│   └── usecases/             # Base use case
└── features/sdui/
    ├── domain/               # Business logic (pure Dart)
    │   ├── entities/         # Business models
    │   ├── repositories/     # Contracts
    │   └── usecases/         # Use cases
    ├── data/                 # Data management
    │   ├── datasources/      # API + Mock data
    │   ├── models/           # Data models
    │   └── repositories/     # Implementation
    └── presentation/         # UI layer
        ├── bloc/             # State management
        ├── pages/            # Screens
        └── widgets/          # UI components
```

## How SDUI Works

### 1. Server sends JSON
```json
{
  "id": "home",
  "title": "Welcome",
  "components": [
    {
      "type": "text",
      "properties": {
        "text": "Hello World!",
        "fontSize": 24
      }
    }
  ]
}
```

### 2. App renders it dynamically
The `ComponentRenderer` widget automatically converts JSON to Flutter widgets!

### 3. Update UI instantly
Change JSON → Users see new UI (no app update needed!)

## Supported Components

| Component | Description | Example Use Case |
|-----------|-------------|------------------|
| `text` | Styled text | Headings, paragraphs |
| `button` | Clickable button | Actions, navigation |
| `container` | Layout wrapper | Spacing, backgrounds |
| `column` | Vertical layout | Lists, forms |
| `row` | Horizontal layout | Toolbars, chips |
| `image` | Network image | Photos, icons |
| `card` | Material card | Content blocks |

## Common Tasks

### Add a New Screen
```bash
# 1. Add mock data in lib/features/sdui/data/datasources/mock_sdui_data.dart
# 2. Navigate to it: context.go('/sdui/your-screen-id');
```

### Add a New Component Type
```dart
// In ComponentRenderer widget:
case 'your-component':
  return _buildYourComponent(config.properties);
```

### Connect to Real API
```dart
// In lib/core/di/injection.dart:
baseUrl: 'https://your-api.com',  // Update this

// In sdui_remote_data_source.dart:
useMockData: false,  // Change to false
```

## Development Commands

```bash
# Run app
flutter run

# Run tests
flutter test

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Analyze code
flutter analyze

# Format code
dart format .
```

## Testing

The project includes example tests:

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/features/sdui/domain/usecases/get_screen_config_test.dart

# Run with coverage
flutter test --coverage
```

## Key Files to Understand

1. **lib/main.dart** - App entry point and setup
2. **lib/core/router/app_router.dart** - Navigation configuration
3. **lib/features/sdui/presentation/widgets/component_renderer.dart** - SDUI magic happens here!
4. **lib/features/sdui/data/datasources/mock_sdui_data.dart** - Mock data for development
5. **lib/core/di/injection.dart** - Dependency injection setup

## Configuration

### Update API Base URL
```dart
// lib/core/di/injection.dart
baseUrl: 'https://your-api.com',
```

### Enable/Disable Mock Data
```dart
// lib/features/sdui/data/datasources/sdui_remote_data_source.dart
useMockData: true,  // false for real API
```

## Learn More

- **README.md** - Full project overview
- **ARCHITECTURE.md** - Deep dive into clean architecture
- **SDUI_GUIDE.md** - Complete SDUI component reference
- **EXAMPLES.md** - Sample JSON responses
- **CONTRIBUTING.md** - How to contribute

## Troubleshooting

### Build Errors?
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Import Errors?
Make sure all dependencies are installed:
```bash
flutter pub get
```

### Test Failures?
Generate mocks:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Next Steps

1. ✅ Run the app and explore the examples
2. 📝 Modify mock data to see UI changes
3. 🎨 Add your own component types
4. 🔌 Connect to your backend API
5. 🧪 Write tests for your features
6. 🚀 Deploy your app!

## Getting Help

- 📖 Check the documentation files
- 🐛 Open an issue on GitHub
- 💬 Join the discussions

## License

MIT License - See LICENSE file

---

**Happy Coding! 🚀**

Built with ❤️ using Flutter and Clean Architecture
