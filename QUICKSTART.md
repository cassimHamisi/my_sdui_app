# Quick Start Guide

## 🚀 Get Running in 5 Minutes

### 1. Prerequisites Check
```bash
flutter --version  # Should be 3.0.0 or higher
```

If Flutter is not installed, visit: https://flutter.dev/docs/get-started/install

### 2. Setup Project
```bash
git clone https://github.com/cassimHamisi/my_sdui_app.git
cd my_sdui_app
flutter pub get
```

### 3. Run the App
```bash
flutter run
# Or for web:
flutter run -d chrome
```

### 4. Run Tests
```bash
flutter test
```

## 📱 What You'll See

The app has a home screen with three main sections:

### Section 1: Basic SDUI Demo
- Button to open a dynamically generated screen
- Screen is entirely driven by JSON data
- Shows a card with a button inside

### Section 2: RowData Simulation
- 4 examples of `MyCustomRow` widget
- Each uses positional data: `["text", "url", "color"]`
- Different colored backgrounds (Blue, Red, Green, Purple)
- Demonstrates the `rowData.data[1]` pattern

### Section 3: Recursive Rendering
- Shows nested cards
- Demonstrates unlimited nesting depth
- All rendered from a single JSON tree

## 🎯 Try These Examples

### Example 1: Change Text
In `lib/main.dart`, find:
```dart
MyCustomRow(data: ["Hello World", "https://image.url", "Blue"])
```

Change to:
```dart
MyCustomRow(data: ["Your Text Here", "https://image.url", "Red"])
```

Save and hot reload (`r` in terminal).

### Example 2: Add Another Color
In `lib/sdui_engine.dart`, add to the switch in `_getColorFromString`:
```dart
case 'pink':
  return Colors.pink;
```

Then use it:
```dart
MyCustomRow(data: ["Pink Row", "url", "Pink"])
```

### Example 3: Create Your Own JSON
Create a file `my_custom_ui.json`:
```json
{
  "type": "card",
  "props": {
    "child": {
      "type": "custom_row",
      "props": {
        "data": ["My Custom UI", "image.png", "Purple"]
      }
    }
  }
}
```

## 🧪 Test Your Changes

After any changes, run:
```bash
flutter test
```

All 12 tests should pass.

## 📚 Learn More

- **README.md** - Project overview and architecture
- **ARCHITECTURE.md** - Deep dive into system design
- **TUTORIAL.md** - Beginner-friendly walkthrough
- **IMPLEMENTATION_SUMMARY.md** - Complete feature list

## 🆘 Troubleshooting

### "Flutter not found"
Install Flutter from: https://flutter.dev/docs/get-started/install

### "Pub get failed"
```bash
flutter clean
flutter pub get
```

### "No device found"
```bash
# For web
flutter run -d chrome

# For desktop
flutter run -d macos   # or linux/windows

# List all available devices
flutter devices
```

### Tests failing
```bash
# Make sure dependencies are installed
flutter pub get

# Run tests in verbose mode
flutter test --verbose
```

## 🎨 Customize the App

### Add a New Widget Type

1. **Add to WidgetRegistry** in `lib/sdui_engine.dart`:
```dart
case 'my_widget':
  return MyWidget(props: props);
```

2. **Create the widget**:
```dart
class MyWidget extends StatelessWidget {
  final Map<String, dynamic> props;
  
  const MyWidget({Key? key, required this.props}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(props['text'] ?? 'Default');
  }
}
```

3. **Use it in JSON**:
```json
{
  "type": "my_widget",
  "props": {
    "text": "Hello from custom widget!"
  }
}
```

## 🌐 Next: Remote Provider

To fetch UI from a server:

1. **Add http package** to `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
```

2. **Create a service**:
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class UIService {
  Future<Map<String, dynamic>> fetchUI(String url) async {
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }
}
```

3. **Use it**:
```dart
final uiData = await UIService().fetchUI('https://api.example.com/ui');
final widget = SDUIParser.parse(uiData);
```

## ✅ Success Checklist

- [ ] Cloned the repository
- [ ] Ran `flutter pub get`
- [ ] Ran the app successfully
- [ ] Saw the home screen with 3 sections
- [ ] Opened the Dynamic Screen
- [ ] Opened the Examples Screen
- [ ] Ran tests (all passed)
- [ ] Read the README
- [ ] Tried modifying a color
- [ ] Understood recursive rendering

## 🤝 Contributing

This is a learning project. Feel free to:
- Add new widget types
- Improve documentation
- Add more examples
- Implement remote provider
- Add animations

## 📞 Support

- Open an issue on GitHub
- Check the documentation files
- Review the code comments

Happy coding! 🎉
