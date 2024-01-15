# Ecommerce app with Riverpod

### Overview
This Flutter app is a simple eCommerce application that allows users to browse products, view product details, and manage their shopping cart. The app utilizes the Riverpod state management library, Dio for API requests, and Hive for local storage of cart items.

### Screens
1. Home Screen
Displays a list of all products available for purchase.
Users can browse through the product list and tap on a product to view details.
2. Product Details Screen
Provides detailed information about a selected product.
Users can add the product to their cart from this screen.
4. Cart Screen
Shows the items added to the cart.
Users can update the quantity of items or remove them from the cart.

### Dependencies
**Riverpod**: State management library for Flutter.

**Dio**: HTTP client for making API requests.

**Hive**: Local database for storing cart items.


### Configuration

**API Integration:**
Update the API endpoints in the api_service.dart file.
Ensure that the API responses are correctly parsed in the respective model classes.

**Hive Configuration:**
Modify the Hive initialization in the main.dart file according to your needs.

