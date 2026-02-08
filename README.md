# my_sdui_app

A Flutter SDUI (Server-Driven UI) practice project demonstrating dynamic UI rendering from JSON data.

## Overview

This project implements a Server-Driven UI architecture that allows Flutter widgets to be created dynamically from JSON data. This approach enables UI updates without recompiling the app, making it ideal for rapid iteration and A/B testing.

## Architecture

### 1. Widget Registry
The `WidgetRegistry` class maps string types from JSON to actual Flutter widgets. Currently supports:
- `text` - Renders Text widgets with customizable size
- `card` - Renders Card widgets with recursive child support
- `button` - Renders ElevatedButton widgets with action handling
- `custom_row` - Demonstrates positional data access (RowData simulation)

### 2. SDUI Parser
The `SDUIParser` class converts raw JSON into Flutter widget trees. It handles:
- Type extraction from JSON
- Props/properties parsing
- Recursive rendering for nested widgets

### 3. Dynamic Screen
The `DynamicScreen` demonstrates a screen entirely driven by JSON data, showing how UIs can be updated by changing JSON rather than recompiling.

## The RowData Challenge

The `MyCustomRow` widget demonstrates positional data access similar to `rowData.data[1]` patterns used in high-performance apps:

```dart
var myData = ["Hello World", "https://image.url", "Blue"];
MyCustomRow(data: myData)
```

- `myData[0]` → Text content
- `myData[1]` → Image URL (for future use)
- `myData[2]` → Background color

This positional approach is faster than named fields because it avoids the overhead of dictionary lookups.

## Recursive Rendering

The architecture supports recursive rendering - widgets can contain other widgets infinitely deep. Notice in the card case:

```dart
case 'card':
  return Card(
    child: SDUIParser.parse(props['child']), // Recursive call!
  );
```

This enables complex nested layouts like:
```json
{
  "type": "card",
  "props": {
    "child": {
      "type": "card",
      "props": {
        "child": {
          "type": "text",
          "props": {"value": "Nested!"}
        }
      }
    }
  }
}
```

## Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart 3.0.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/cassimHamisi/my_sdui_app.git
cd my_sdui_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Running Tests

```bash
flutter test
```

## Project Structure

```
lib/
  ├── main.dart           # Entry point with demo screens
  └── sdui_engine.dart    # SDUI core: Registry, Parser, Widgets

test/
  └── sdui_engine_test.dart  # Unit and widget tests
```

## Next Steps

To add a "Remote Provider" and fetch UI from a server:

1. Add `http` package to `pubspec.yaml`
2. Create a service class to fetch JSON from an API
3. Replace `mockJsonResponse` with real API calls
4. Add loading states and error handling

Example:
```dart
class RemoteUIProvider {
  Future<Map<String, dynamic>> fetchUI(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));
    return json.decode(response.body);
  }
}
```

## Why This Matters

- **Rapid Iteration**: Change UI without app updates
- **A/B Testing**: Serve different UIs to different users
- **Personalization**: Customize UI per user/context
- **Career Skills**: Understanding recursive rendering and data-driven UIs is valuable for senior engineering roles

## Contributing

This is a practice project. Feel free to fork and experiment! 
