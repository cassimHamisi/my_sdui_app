import '../models/screen_config_model.dart';

/// Mock data for testing SDUI screens
class MockSduiData {
  static final Map<String, Map<String, dynamic>> _mockResponses = {
    'home': {
      'id': 'home',
      'title': 'Welcome Home',
      'components': [
        {
          'id': 'welcome-card',
          'type': 'card',
          'properties': {'elevation': 2},
          'children': [
            {
              'id': 'welcome-column',
              'type': 'column',
              'properties': {'spacing': 16},
              'children': [
                {
                  'id': 'welcome-text',
                  'type': 'text',
                  'properties': {
                    'text': 'Welcome to SDUI!',
                    'fontSize': 24,
                    'fontWeight': 'bold',
                    'color': '#2196F3'
                  }
                },
                {
                  'id': 'subtitle',
                  'type': 'text',
                  'properties': {
                    'text': 'Server-Driven UI makes updating your app easy',
                    'fontSize': 16,
                    'color': '#666666'
                  }
                },
                {
                  'id': 'get-started-btn',
                  'type': 'button',
                  'properties': {
                    'text': 'Get Started',
                    'onPress': '/profile'
                  }
                }
              ]
            }
          ]
        },
        {
          'id': 'features-section',
          'type': 'column',
          'properties': {'spacing': 12},
          'children': [
            {
              'id': 'features-title',
              'type': 'text',
              'properties': {
                'text': 'Features',
                'fontSize': 20,
                'fontWeight': 'bold'
              }
            },
            {
              'id': 'feature-1',
              'type': 'card',
              'properties': {'elevation': 1},
              'children': [
                {
                  'id': 'feature-1-text',
                  'type': 'text',
                  'properties': {
                    'text': '✓ Dynamic UI Updates',
                    'fontSize': 16
                  }
                }
              ]
            },
            {
              'id': 'feature-2',
              'type': 'card',
              'properties': {'elevation': 1},
              'children': [
                {
                  'id': 'feature-2-text',
                  'type': 'text',
                  'properties': {
                    'text': '✓ Clean Architecture',
                    'fontSize': 16
                  }
                }
              ]
            },
            {
              'id': 'feature-3',
              'type': 'card',
              'properties': {'elevation': 1},
              'children': [
                {
                  'id': 'feature-3-text',
                  'type': 'text',
                  'properties': {
                    'text': '✓ BLoC State Management',
                    'fontSize': 16
                  }
                }
              ]
            }
          ]
        }
      ]
    },
    'profile': {
      'id': 'profile',
      'title': 'User Profile',
      'components': [
        {
          'id': 'profile-header',
          'type': 'card',
          'properties': {'elevation': 3},
          'children': [
            {
              'id': 'profile-column',
              'type': 'column',
              'properties': {'spacing': 12},
              'children': [
                {
                  'id': 'name',
                  'type': 'text',
                  'properties': {
                    'text': 'John Doe',
                    'fontSize': 24,
                    'fontWeight': 'bold'
                  }
                },
                {
                  'id': 'email',
                  'type': 'text',
                  'properties': {
                    'text': 'john.doe@example.com',
                    'fontSize': 16,
                    'color': '#666666'
                  }
                }
              ]
            }
          ]
        },
        {
          'id': 'profile-actions',
          'type': 'column',
          'properties': {'spacing': 12},
          'children': [
            {
              'id': 'edit-profile-btn',
              'type': 'button',
              'properties': {
                'text': 'Edit Profile',
                'onPress': '/edit-profile'
              }
            },
            {
              'id': 'settings-btn',
              'type': 'button',
              'properties': {
                'text': 'Settings',
                'onPress': '/settings'
              }
            }
          ]
        }
      ]
    }
  };

  /// Get mock screen configuration
  static ScreenConfigModel? getMockScreen(String screenId) {
    final data = _mockResponses[screenId];
    if (data != null) {
      return ScreenConfigModel.fromJson(data);
    }
    return null;
  }

  /// Check if mock data exists for a screen ID
  static bool hasMockData(String screenId) {
    return _mockResponses.containsKey(screenId);
  }

  /// Get all available mock screen IDs
  static List<String> getAvailableScreenIds() {
    return _mockResponses.keys.toList();
  }
}
