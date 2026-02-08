import 'package:flutter/material.dart';
import '../../domain/entities/screen_config.dart';

/// Widget that renders a component based on its type
class ComponentRenderer extends StatelessWidget {
  final ComponentConfig config;

  const ComponentRenderer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    switch (config.type) {
      case 'text':
        return _buildText(config.properties);
      case 'button':
        return _buildButton(config.properties);
      case 'container':
        return _buildContainer(config.properties, config.children);
      case 'column':
        return _buildColumn(config.properties, config.children);
      case 'row':
        return _buildRow(config.properties, config.children);
      case 'image':
        return _buildImage(config.properties);
      case 'card':
        return _buildCard(config.properties, config.children);
      default:
        return _buildUnknown(config.type);
    }
  }

  Widget _buildText(Map<String, dynamic> properties) {
    final text = properties['text'] as String? ?? '';
    final fontSize = (properties['fontSize'] as num?)?.toDouble() ?? 14.0;
    final fontWeight = properties['fontWeight'] as String? ?? 'normal';
    final color = properties['color'] as String?;

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight == 'bold' ? FontWeight.bold : FontWeight.normal,
        color: color != null ? _parseColor(color) : null,
      ),
    );
  }

  Widget _buildButton(Map<String, dynamic> properties) {
    final text = properties['text'] as String? ?? 'Button';
    final onPress = properties['onPress'] as String?;

    return ElevatedButton(
      onPressed: () {
        // Handle button press - you can implement navigation or actions here
        debugPrint('Button pressed: $onPress');
      },
      child: Text(text),
    );
  }

  Widget _buildContainer(
    Map<String, dynamic> properties,
    List<ComponentConfig>? children,
  ) {
    final padding = (properties['padding'] as num?)?.toDouble() ?? 0.0;
    final margin = (properties['margin'] as num?)?.toDouble() ?? 0.0;
    final backgroundColor = properties['backgroundColor'] as String?;

    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: backgroundColor != null
          ? BoxDecoration(color: _parseColor(backgroundColor))
          : null,
      child: children != null && children.isNotEmpty
          ? ComponentRenderer(config: children.first)
          : null,
    );
  }

  Widget _buildColumn(
    Map<String, dynamic> properties,
    List<ComponentConfig>? children,
  ) {
    final spacing = (properties['spacing'] as num?)?.toDouble() ?? 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
              ?.map((child) => Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: ComponentRenderer(config: child),
                  ))
              .toList() ??
          [],
    );
  }

  Widget _buildRow(
    Map<String, dynamic> properties,
    List<ComponentConfig>? children,
  ) {
    final spacing = (properties['spacing'] as num?)?.toDouble() ?? 0.0;

    return Row(
      children: children
              ?.map((child) => Padding(
                    padding: EdgeInsets.only(right: spacing),
                    child: ComponentRenderer(config: child),
                  ))
              .toList() ??
          [],
    );
  }

  Widget _buildImage(Map<String, dynamic> properties) {
    final url = properties['url'] as String? ?? '';
    final width = (properties['width'] as num?)?.toDouble();
    final height = (properties['height'] as num?)?.toDouble();

    return Image.network(
      url,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    );
  }

  Widget _buildCard(
    Map<String, dynamic> properties,
    List<ComponentConfig>? children,
  ) {
    return Card(
      elevation: (properties['elevation'] as num?)?.toDouble() ?? 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: children != null && children.isNotEmpty
            ? ComponentRenderer(config: children.first)
            : null,
      ),
    );
  }

  Widget _buildUnknown(String type) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.red.withOpacity(0.1),
      child: Text(
        'Unknown component type: $type',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Color _parseColor(String colorString) {
    // Remove '#' if present
    final hex = colorString.replaceAll('#', '');
    
    // Add full opacity if not specified
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    } else if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    }
    
    return Colors.black;
  }
}
