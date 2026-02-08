# Example API Responses

This document contains example JSON responses for testing the SDUI functionality.

## Home Screen Example

```json
{
  "id": "home",
  "title": "Welcome Home",
  "components": [
    {
      "id": "welcome-card",
      "type": "card",
      "properties": {
        "elevation": 2
      },
      "children": [
        {
          "id": "welcome-column",
          "type": "column",
          "properties": {
            "spacing": 16
          },
          "children": [
            {
              "id": "welcome-text",
              "type": "text",
              "properties": {
                "text": "Welcome to SDUI!",
                "fontSize": 24,
                "fontWeight": "bold",
                "color": "#2196F3"
              }
            },
            {
              "id": "subtitle",
              "type": "text",
              "properties": {
                "text": "Server-Driven UI makes updating your app easy",
                "fontSize": 16,
                "color": "#666666"
              }
            },
            {
              "id": "get-started-btn",
              "type": "button",
              "properties": {
                "text": "Get Started",
                "onPress": "/profile"
              }
            }
          ]
        }
      ]
    },
    {
      "id": "features-section",
      "type": "column",
      "properties": {
        "spacing": 12
      },
      "children": [
        {
          "id": "features-title",
          "type": "text",
          "properties": {
            "text": "Features",
            "fontSize": 20,
            "fontWeight": "bold"
          }
        },
        {
          "id": "feature-1",
          "type": "card",
          "properties": {
            "elevation": 1
          },
          "children": [
            {
              "id": "feature-1-text",
              "type": "text",
              "properties": {
                "text": "✓ Dynamic UI Updates",
                "fontSize": 16
              }
            }
          ]
        },
        {
          "id": "feature-2",
          "type": "card",
          "properties": {
            "elevation": 1
          },
          "children": [
            {
              "id": "feature-2-text",
              "type": "text",
              "properties": {
                "text": "✓ Clean Architecture",
                "fontSize": 16
              }
            }
          ]
        },
        {
          "id": "feature-3",
          "type": "card",
          "properties": {
            "elevation": 1
          },
          "children": [
            {
              "id": "feature-3-text",
              "type": "text",
              "properties": {
                "text": "✓ BLoC State Management",
                "fontSize": 16
              }
            }
          ]
        }
      ]
    }
  ]
}
```

## Profile Screen Example

```json
{
  "id": "profile",
  "title": "User Profile",
  "components": [
    {
      "id": "profile-header",
      "type": "card",
      "properties": {
        "elevation": 3
      },
      "children": [
        {
          "id": "profile-column",
          "type": "column",
          "properties": {
            "spacing": 12
          },
          "children": [
            {
              "id": "avatar",
              "type": "image",
              "properties": {
                "url": "https://via.placeholder.com/150",
                "width": 150,
                "height": 150
              }
            },
            {
              "id": "name",
              "type": "text",
              "properties": {
                "text": "John Doe",
                "fontSize": 24,
                "fontWeight": "bold"
              }
            },
            {
              "id": "email",
              "type": "text",
              "properties": {
                "text": "john.doe@example.com",
                "fontSize": 16,
                "color": "#666666"
              }
            }
          ]
        }
      ]
    },
    {
      "id": "profile-actions",
      "type": "column",
      "properties": {
        "spacing": 12
      },
      "children": [
        {
          "id": "edit-profile-btn",
          "type": "button",
          "properties": {
            "text": "Edit Profile",
            "onPress": "/edit-profile"
          }
        },
        {
          "id": "settings-btn",
          "type": "button",
          "properties": {
            "text": "Settings",
            "onPress": "/settings"
          }
        },
        {
          "id": "logout-btn",
          "type": "button",
          "properties": {
            "text": "Logout",
            "onPress": "/logout"
          }
        }
      ]
    }
  ]
}
```

## Product Listing Example

```json
{
  "id": "products",
  "title": "Products",
  "components": [
    {
      "id": "search-section",
      "type": "card",
      "properties": {
        "elevation": 1
      },
      "children": [
        {
          "id": "search-text",
          "type": "text",
          "properties": {
            "text": "Search Products",
            "fontSize": 18,
            "fontWeight": "bold"
          }
        }
      ]
    },
    {
      "id": "products-grid",
      "type": "column",
      "properties": {
        "spacing": 16
      },
      "children": [
        {
          "id": "product-1",
          "type": "card",
          "properties": {
            "elevation": 2
          },
          "children": [
            {
              "id": "product-1-content",
              "type": "column",
              "properties": {
                "spacing": 8
              },
              "children": [
                {
                  "id": "product-1-image",
                  "type": "image",
                  "properties": {
                    "url": "https://via.placeholder.com/200x150",
                    "width": 200,
                    "height": 150
                  }
                },
                {
                  "id": "product-1-name",
                  "type": "text",
                  "properties": {
                    "text": "Product 1",
                    "fontSize": 18,
                    "fontWeight": "bold"
                  }
                },
                {
                  "id": "product-1-price",
                  "type": "text",
                  "properties": {
                    "text": "$29.99",
                    "fontSize": 16,
                    "color": "#4CAF50"
                  }
                },
                {
                  "id": "product-1-btn",
                  "type": "button",
                  "properties": {
                    "text": "View Details",
                    "onPress": "/product/1"
                  }
                }
              ]
            }
          ]
        },
        {
          "id": "product-2",
          "type": "card",
          "properties": {
            "elevation": 2
          },
          "children": [
            {
              "id": "product-2-content",
              "type": "column",
              "properties": {
                "spacing": 8
              },
              "children": [
                {
                  "id": "product-2-image",
                  "type": "image",
                  "properties": {
                    "url": "https://via.placeholder.com/200x150",
                    "width": 200,
                    "height": 150
                  }
                },
                {
                  "id": "product-2-name",
                  "type": "text",
                  "properties": {
                    "text": "Product 2",
                    "fontSize": 18,
                    "fontWeight": "bold"
                  }
                },
                {
                  "id": "product-2-price",
                  "type": "text",
                  "properties": {
                    "text": "$49.99",
                    "fontSize": 16,
                    "color": "#4CAF50"
                  }
                },
                {
                  "id": "product-2-btn",
                  "type": "button",
                  "properties": {
                    "text": "View Details",
                    "onPress": "/product/2"
                  }
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Settings Screen Example

```json
{
  "id": "settings",
  "title": "Settings",
  "components": [
    {
      "id": "settings-list",
      "type": "column",
      "properties": {
        "spacing": 8
      },
      "children": [
        {
          "id": "account-section",
          "type": "card",
          "properties": {
            "elevation": 1
          },
          "children": [
            {
              "id": "account-header",
              "type": "text",
              "properties": {
                "text": "Account",
                "fontSize": 18,
                "fontWeight": "bold"
              }
            }
          ]
        },
        {
          "id": "notifications-section",
          "type": "card",
          "properties": {
            "elevation": 1
          },
          "children": [
            {
              "id": "notifications-header",
              "type": "text",
              "properties": {
                "text": "Notifications",
                "fontSize": 18,
                "fontWeight": "bold"
              }
            }
          ]
        },
        {
          "id": "privacy-section",
          "type": "card",
          "properties": {
            "elevation": 1
          },
          "children": [
            {
              "id": "privacy-header",
              "type": "text",
              "properties": {
                "text": "Privacy & Security",
                "fontSize": 18,
                "fontWeight": "bold"
              }
            }
          ]
        },
        {
          "id": "about-section",
          "type": "card",
          "properties": {
            "elevation": 1
          },
          "children": [
            {
              "id": "about-header",
              "type": "text",
              "properties": {
                "text": "About",
                "fontSize": 18,
                "fontWeight": "bold"
              }
            }
          ]
        }
      ]
    }
  ]
}
```

## Testing with Mock Data

You can use these responses with a mock server or update your data source to return hardcoded responses for testing:

```dart
@override
Future<ScreenConfigModel> getScreenConfig(String screenId) async {
  // For testing, return mock data
  final mockResponses = {
    'home': homeScreenJson,
    'profile': profileScreenJson,
    'products': productsScreenJson,
    'settings': settingsScreenJson,
  };
  
  if (mockResponses.containsKey(screenId)) {
    return ScreenConfigModel.fromJson(mockResponses[screenId]!);
  }
  
  throw ServerException('Screen not found');
}
```

## Color Reference

Common colors used in examples:
- Primary Blue: `#2196F3`
- Success Green: `#4CAF50`
- Text Gray: `#666666`
- Black: `#000000`
- White: `#FFFFFF`
- Light Gray Background: `#F5F5F5`
