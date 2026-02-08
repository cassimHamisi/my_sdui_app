# SDUI Architecture Guide

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│                      JSON Data Source                        │
│  (Server API / Local File / Mock Data)                      │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        │ JSON String/Object
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                      SDUIParser                              │
│  • Extracts "type" field                                    │
│  • Extracts "props" field                                   │
│  • Calls WidgetRegistry.build(type, props)                  │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        │ type + props
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                   WidgetRegistry                             │
│  • Maps type string to Flutter Widget class                 │
│  • Handles recursive calls for nested widgets               │
│  • Supports: text, card, button, custom_row                 │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        │ Flutter Widget
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                   Flutter Widget Tree                        │
│  (Rendered on Screen)                                       │
└─────────────────────────────────────────────────────────────┘
```

## Example Flow

### Input JSON:
```json
{
  "type": "card",
  "props": {
    "child": {
      "type": "button",
      "props": {
        "label": "Click Me",
        "action": "submit_form"
      }
    }
  }
}
```

### Step-by-Step Execution:

1. **Parser receives JSON**
   - Extracts: `type = "card"`
   - Extracts: `props = { child: {...} }`

2. **Registry builds Card widget**
   - Matches `case 'card'`
   - Creates `Card()` widget
   - **Recursively calls** `SDUIParser.parse(props['child'])` for nested content

3. **Parser processes nested child**
   - Extracts: `type = "button"`
   - Extracts: `props = { label: "Click Me", action: "submit_form" }`

4. **Registry builds Button widget**
   - Matches `case 'button'`
   - Creates `ElevatedButton()` with label
   - Attaches onPressed handler

5. **Final Widget Tree**
   ```
   Card
     └─ Padding
          └─ ElevatedButton("Click Me")
   ```

## RowData Pattern

### The Problem It Solves
Named fields require dictionary lookups which are slower:
```dart
// Slow: Dictionary lookup
user['firstName']  // O(log n) or O(n)
```

Positional access is faster:
```dart
// Fast: Array index
userData[0]  // O(1)
```

### Implementation
```dart
var myData = ["Hello World", "https://image.url", "Blue"];

// Access patterns:
data[0] → Text content
data[1] → Image URL (reserved for future use)
data[2] → Background color
```

### Usage in JSON:
```json
{
  "type": "custom_row",
  "props": {
    "data": ["Title Text", "img.png", "Blue"]
  }
}
```

## Why Recursive Rendering Matters

Recursive rendering allows infinite nesting depth without writing special code for each level:

```json
{
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
              "props": { "value": "Deep!" }
            }
          }
        }
      }
    }
  }
}
```

The same `SDUIParser.parse()` function handles all levels through recursion. This is how complex apps like Twitter, Instagram, and Facebook build their feeds.

## Adding New Widget Types

To add a new widget type, just add a case to WidgetRegistry:

```dart
case 'image':
  return Image.network(
    props['url'] ?? '',
    width: (props['width'] ?? 100).toDouble(),
    height: (props['height'] ?? 100).toDouble(),
  );
```

Then use it in JSON:
```json
{
  "type": "image",
  "props": {
    "url": "https://example.com/image.png",
    "width": 200,
    "height": 150
  }
}
```

## Career Impact

Understanding this architecture is valuable because:

1. **Airbnb, Lyft, Shopify** use similar patterns for their apps
2. Enables **A/B testing** without app updates
3. Allows **non-engineers** to update UI via CMS
4. Critical for **micro-frontends** and **module federation**
5. Demonstrates understanding of **design patterns** (Factory, Strategy)

## Next Steps

1. Add HTTP client to fetch JSON from real APIs
2. Implement caching for offline support
3. Add error handling for malformed JSON
4. Create a visual JSON editor/builder
5. Add animation and transition support
6. Implement state management for interactive widgets
