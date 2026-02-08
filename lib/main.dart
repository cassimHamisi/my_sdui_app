import 'package:flutter/material.dart';
import 'sdui_engine.dart';

void main() {
  runApp(const MySDUIApp());
}

class MySDUIApp extends StatelessWidget {
  const MySDUIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My SDUI App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SDUI Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Basic SDUI Demo
            const Text(
              'Basic SDUI Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DynamicScreen()),
                );
              },
              child: const Text('Open Dynamic Screen'),
            ),
            const SizedBox(height: 32),

            // Section 2: RowData Simulation
            const Text(
              'RowData Simulation Challenge',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Using positional data access like rowData.data[1]:',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),

            // Example 1: Blue background
            const Text('Example 1: data[0] = "Hello World", data[2] = "Blue"'),
            const SizedBox(height: 8),
            MyCustomRow(
              data: ["Hello World", "https://image.url", "Blue"],
            ),
            const SizedBox(height: 24),

            // Example 2: Red background
            const Text('Example 2: data[0] = "SDUI Rocks!", data[2] = "Red"'),
            const SizedBox(height: 8),
            MyCustomRow(
              data: ["SDUI Rocks!", "unused_data", "Red"],
            ),
            const SizedBox(height: 24),

            // Example 3: Green background
            const Text('Example 3: data[0] = "Career Growth", data[2] = "Green"'),
            const SizedBox(height: 8),
            MyCustomRow(
              data: ["Career Growth", "https://another.url", "Green"],
            ),
            const SizedBox(height: 24),

            // Example 4: JSON-driven custom_row
            const Text(
              'JSON-Driven RowData (via SDUI Parser):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SDUIParser.parse({
              "type": "custom_row",
              "props": {
                "data": ["Purple Row from JSON!", "image.png", "Purple"]
              }
            }),
            const SizedBox(height: 24),

            // Section 3: Recursive Rendering Demo
            const Text(
              'Recursive Rendering Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SDUIParser.parse({
              "type": "card",
              "props": {
                "child": {
                  "type": "card",
                  "props": {
                    "child": {
                      "type": "text",
                      "props": {"value": "Nested Card!", "size": 20}
                    }
                  }
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
