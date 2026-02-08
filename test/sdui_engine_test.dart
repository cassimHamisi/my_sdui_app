import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_sdui_app/sdui_engine.dart';

void main() {
  group('WidgetRegistry Tests', () {
    test('build text widget', () {
      final widget = WidgetRegistry.build('text', {'value': 'Test', 'size': 16});
      expect(widget, isA<Text>());
    });

    test('build card widget', () {
      final widget = WidgetRegistry.build('card', {
        'child': {'type': 'text', 'props': {'value': 'Inside Card'}}
      });
      expect(widget, isA<Card>());
    });

    test('build button widget', () {
      final widget = WidgetRegistry.build('button', {
        'label': 'Click Me',
        'action': 'test_action'
      });
      expect(widget, isA<ElevatedButton>());
    });

    test('build custom_row widget', () {
      final widget = WidgetRegistry.build('custom_row', {
        'data': ['Test', 'url', 'Blue']
      });
      expect(widget, isA<MyCustomRow>());
    });

    test('build unknown widget returns SizedBox', () {
      final widget = WidgetRegistry.build('unknown', {});
      expect(widget, isA<SizedBox>());
    });
  });

  group('SDUIParser Tests', () {
    test('parse text widget from JSON', () {
      final json = {
        'type': 'text',
        'props': {'value': 'Hello', 'size': 18}
      };
      final widget = SDUIParser.parse(json);
      expect(widget, isA<Text>());
    });

    test('parse nested widgets (recursive)', () {
      final json = {
        'type': 'card',
        'props': {
          'child': {
            'type': 'button',
            'props': {'label': 'Nested Button'}
          }
        }
      };
      final widget = SDUIParser.parse(json);
      expect(widget, isA<Card>());
    });
  });

  group('MyCustomRow Tests', () {
    testWidgets('renders with data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyCustomRow(data: ['Test Text', 'url', 'Blue']),
          ),
        ),
      );

      expect(find.text('Test Text'), findsOneWidget);
    });

    testWidgets('renders with empty data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyCustomRow(data: []),
          ),
        ),
      );

      expect(find.text('No Data'), findsOneWidget);
    });

    testWidgets('applies correct color from data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyCustomRow(data: ['Text', 'url', 'Red']),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.red);
    });
  });

  group('DynamicScreen Tests', () {
    testWidgets('renders app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: DynamicScreen()),
      );

      expect(find.text('My SDUI Project'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders card with button from JSON', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: DynamicScreen()),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Dynamic Server Button'), findsOneWidget);
    });
  });
}
