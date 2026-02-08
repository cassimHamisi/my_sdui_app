import 'package:flutter/material.dart';

// --- THE REGISTRY ---
// This maps a "String" from your JSON to a real Flutter Widget.
class WidgetRegistry {
  static Widget build(String type, Map<String, dynamic> props) {
    switch (type) {
      case 'text':
        return Text(
          props['value'] ?? '',
          style: TextStyle(fontSize: (props['size'] ?? 14).toDouble()),
        );
      case 'card':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SDUIParser.parse(props['child']), // Recursive call!
          ),
        );
      case 'button':
        return ElevatedButton(
          onPressed: () => print("Action: ${props['action']}"),
          child: Text(props['label'] ?? 'Button'),
        );
      case 'custom_row':
        // Support for the RowData simulation challenge
        return MyCustomRow(data: props['data'] ?? []);
      default:
        return const SizedBox.shrink();
    }
  }
}

// --- THE PARSER ---
// This turns your raw JSON into something Flutter understands.
class SDUIParser {
  static Widget parse(Map<String, dynamic> json) {
    final String type = json['type'];
    final Map<String, dynamic> props = json['props'] ?? {};
    
    return WidgetRegistry.build(type, props);
  }
}

// --- THE CUSTOM ROW WIDGET ---
// This simulates the "RowData" logic from the work repo
// Takes a list of data and uses positional access like rowData.data[1]
class MyCustomRow extends StatelessWidget {
  final List<dynamic> data;

  const MyCustomRow({Key? key, required this.data}) : super(key: key);

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Positional data access: data[0] for text, data[2] for color
    String textValue = data.isNotEmpty ? data[0].toString() : 'No Data';
    Color bgColor = data.length > 2 
        ? _getColorFromString(data[2].toString()) 
        : Colors.grey;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textValue,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// --- THE SCREEN ---
class DynamicScreen extends StatelessWidget {
  // Mocking a response from a server
  final Map<String, dynamic> mockJsonResponse = {
    "type": "card",
    "props": {
      "child": {
        "type": "button",
        "props": {"label": "Dynamic Server Button", "action": "submit_form"}
      }
    }
  };

  DynamicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My SDUI Project")),
      body: Center(
        child: SDUIParser.parse(mockJsonResponse),
      ),
    );
  }
}
