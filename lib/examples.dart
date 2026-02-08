import 'package:flutter/material.dart';
import 'sdui_engine.dart';

/// This file demonstrates various SDUI patterns and use cases
class SDUIExamples {
  
  /// Example 1: Simple Text Widget
  static Map<String, dynamic> simpleText() {
    return {
      "type": "text",
      "props": {"value": "Hello SDUI!", "size": 20}
    };
  }

  /// Example 2: Button with Action
  static Map<String, dynamic> buttonWithAction() {
    return {
      "type": "button",
      "props": {
        "label": "Submit Form",
        "action": "submit_form"
      }
    };
  }

  /// Example 3: Card with Nested Content
  static Map<String, dynamic> cardWithButton() {
    return {
      "type": "card",
      "props": {
        "child": {
          "type": "button",
          "props": {
            "label": "Click Me",
            "action": "button_clicked"
          }
        }
      }
    };
  }

  /// Example 4: RowData Pattern - Positional Access
  static Map<String, dynamic> rowDataExample() {
    return {
      "type": "custom_row",
      "props": {
        "data": ["Performance Optimized", "https://cdn.example.com/img.png", "Green"]
      }
    };
  }

  /// Example 5: Deeply Nested Recursive Structure
  static Map<String, dynamic> deeplyNested() {
    return {
      "type": "card",
      "props": {
        "child": {
          "type": "card",
          "props": {
            "child": {
              "type": "card",
              "props": {
                "child": {
                  "type": "text",
                  "props": {
                    "value": "3 Levels Deep!",
                    "size": 16
                  }
                }
              }
            }
          }
        }
      }
    };
  }

  /// Example 6: Multiple RowData Variations
  static List<Map<String, dynamic>> multipleRows() {
    return [
      {
        "type": "custom_row",
        "props": {
          "data": ["Blue Theme", "img1.png", "Blue"]
        }
      },
      {
        "type": "custom_row",
        "props": {
          "data": ["Red Theme", "img2.png", "Red"]
        }
      },
      {
        "type": "custom_row",
        "props": {
          "data": ["Green Theme", "img3.png", "Green"]
        }
      },
    ];
  }

  /// Example 7: Real-world Form Layout
  static Map<String, dynamic> formLayout() {
    return {
      "type": "card",
      "props": {
        "child": {
          "type": "button",
          "props": {
            "label": "Submit Registration",
            "action": "register_user"
          }
        }
      }
    };
  }
}

/// Demo screen showing all examples
class SDUIExamplesScreen extends StatelessWidget {
  const SDUIExamplesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SDUI Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildExample('Simple Text', SDUIExamples.simpleText()),
            _buildExample('Button with Action', SDUIExamples.buttonWithAction()),
            _buildExample('Card with Button', SDUIExamples.cardWithButton()),
            _buildExample('RowData Pattern', SDUIExamples.rowDataExample()),
            _buildExample('Deeply Nested', SDUIExamples.deeplyNested()),
            
            const SizedBox(height: 16),
            const Text(
              'Multiple Rows:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...SDUIExamples.multipleRows().map((json) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SDUIParser.parse(json),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExample(String title, Map<String, dynamic> json) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SDUIParser.parse(json),
        ],
      ),
    );
  }
}
