# Server-Driven UI (SDUI) Guide

## What is SDUI?

Server-Driven UI is an architectural pattern where the server controls the UI structure and behavior, allowing for dynamic updates without requiring app releases.

## Benefits

1. **Dynamic Updates**: Change UI without app store releases
2. **A/B Testing**: Easy to test different UI variations
3. **Personalization**: Customize UI per user
4. **Consistency**: Ensure UI consistency across platforms
5. **Rapid Iteration**: Faster feature deployment

## How It Works

### 1. Server Response

The server returns JSON describing the UI structure:

```json
{
  "id": "home",
  "title": "Welcome",
  "components": [
    {
      "id": "greeting",
      "type": "text",
      "properties": {
        "text": "Hello, User!",
        "fontSize": 24,
        "fontWeight": "bold"
      }
    },
    {
      "id": "cta-button",
      "type": "button",
      "properties": {
        "text": "Get Started",
        "onPress": "/profile"
      }
    }
  ]
}
```

### 2. Client Rendering

The app uses `ComponentRenderer` to dynamically render components:

```dart
Widget build(BuildContext context) {
  switch (config.type) {
    case 'text':
      return _buildText(config.properties);
    case 'button':
      return _buildButton(config.properties);
    // ... more cases
  }
}
```

## Supported Components

### Text Component

```json
{
  "id": "text-1",
  "type": "text",
  "properties": {
    "text": "Hello World",
    "fontSize": 16,
    "fontWeight": "bold",
    "color": "#000000"
  }
}
```

**Properties**:
- `text` (string): Text content
- `fontSize` (number): Font size in pixels
- `fontWeight` (string): "normal" or "bold"
- `color` (string): Hex color code

### Button Component

```json
{
  "id": "button-1",
  "type": "button",
  "properties": {
    "text": "Click Me",
    "onPress": "/details"
  }
}
```

**Properties**:
- `text` (string): Button text
- `onPress` (string): Navigation route or action

### Container Component

```json
{
  "id": "container-1",
  "type": "container",
  "properties": {
    "padding": 16,
    "margin": 8,
    "backgroundColor": "#F0F0F0"
  },
  "children": [...]
}
```

**Properties**:
- `padding` (number): Internal spacing
- `margin` (number): External spacing
- `backgroundColor` (string): Hex color code

### Column Component

```json
{
  "id": "column-1",
  "type": "column",
  "properties": {
    "spacing": 12
  },
  "children": [...]
}
```

**Properties**:
- `spacing` (number): Space between children

### Row Component

```json
{
  "id": "row-1",
  "type": "row",
  "properties": {
    "spacing": 8
  },
  "children": [...]
}
```

**Properties**:
- `spacing` (number): Space between children

### Image Component

```json
{
  "id": "image-1",
  "type": "image",
  "properties": {
    "url": "https://example.com/image.jpg",
    "width": 200,
    "height": 150
  }
}
```

**Properties**:
- `url` (string): Image URL
- `width` (number, optional): Image width
- `height` (number, optional): Image height

### Card Component

```json
{
  "id": "card-1",
  "type": "card",
  "properties": {
    "elevation": 4
  },
  "children": [...]
}
```

**Properties**:
- `elevation` (number): Shadow elevation

## Complete Example

### Server Response

```json
{
  "id": "product-detail",
  "title": "Product Details",
  "components": [
    {
      "id": "product-card",
      "type": "card",
      "properties": {
        "elevation": 2
      },
      "children": [
        {
          "id": "content-column",
          "type": "column",
          "properties": {
            "spacing": 16
          },
          "children": [
            {
              "id": "product-image",
              "type": "image",
              "properties": {
                "url": "https://example.com/product.jpg",
                "width": 300,
                "height": 200
              }
            },
            {
              "id": "product-name",
              "type": "text",
              "properties": {
                "text": "Amazing Product",
                "fontSize": 20,
                "fontWeight": "bold"
              }
            },
            {
              "id": "product-price",
              "type": "text",
              "properties": {
                "text": "$99.99",
                "fontSize": 18,
                "color": "#2196F3"
              }
            },
            {
              "id": "buy-button",
              "type": "button",
              "properties": {
                "text": "Buy Now",
                "onPress": "/checkout"
              }
            }
          ]
        }
      ]
    }
  ]
}
```

## Adding New Component Types

To add a new component type:

1. Update `ComponentRenderer.build()`:
```dart
case 'your-component':
  return _buildYourComponent(config.properties);
```

2. Implement the builder method:
```dart
Widget _buildYourComponent(Map<String, dynamic> properties) {
  // Extract properties
  final value = properties['value'] as String?;
  
  // Return widget
  return YourWidget(value: value);
}
```

3. Document the component format

## Best Practices

### 1. Versioning
Include API version in requests:
```dart
dio.options.headers['API-Version'] = '1.0';
```

### 2. Fallback Handling
Always handle unknown component types:
```dart
default:
  return _buildUnknown(config.type);
```

### 3. Error States
Provide clear error messages:
```dart
if (state is SduiError) {
  return ErrorWidget(message: state.message);
}
```

### 4. Loading States
Show loading indicators:
```dart
if (state is SduiLoading) {
  return CircularProgressIndicator();
}
```

### 5. Validation
Validate server responses on the client:
```dart
if (json['components'] == null) {
  throw ServerException('Invalid response');
}
```

## Performance Considerations

1. **Caching**: Cache frequently accessed screens
2. **Lazy Loading**: Load images lazily
3. **Pagination**: Paginate long lists
4. **Compression**: Use gzip compression
5. **CDN**: Serve images from CDN

## Security

1. **Validation**: Validate all server inputs
2. **Sanitization**: Sanitize user-provided content
3. **HTTPS**: Always use HTTPS
4. **Authentication**: Protect API endpoints
5. **Rate Limiting**: Implement rate limiting

## Testing SDUI

### Mock Server Response

```dart
final mockResponse = {
  'id': 'test',
  'title': 'Test Screen',
  'components': [
    {
      'id': 'test-text',
      'type': 'text',
      'properties': {'text': 'Test'}
    }
  ]
};
```

### Test Component Rendering

```dart
testWidgets('renders text component', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ComponentRenderer(
        config: ComponentConfig(
          id: 'test',
          type: 'text',
          properties: {'text': 'Hello'},
        ),
      ),
    ),
  );
  
  expect(find.text('Hello'), findsOneWidget);
});
```

## Migration Strategy

1. **Phase 1**: Implement SDUI for new features
2. **Phase 2**: Migrate non-critical screens
3. **Phase 3**: Migrate critical screens with fallbacks
4. **Phase 4**: Full SDUI with local fallbacks

## Resources

- [Airbnb's SDUI Approach](https://medium.com/airbnb-engineering/a-deep-dive-into-airbnbs-server-driven-ui-system-842244c5f5)
- [DoorDash's SDUI](https://doordash.engineering/2022/10/06/building-a-server-driven-ui-system/)
