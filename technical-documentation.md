# Legumlex Customer Portal - Technical Documentation

## Project Overview

**Application Name:** Legumlex Customer Portal  
**Package:** `legumlex_customer`  
**Platform:** Android Flutter Application  
**Version:** 1.0.0+1  
**Flutter SDK:** ^3.5.0  

The Legumlex Customer Portal is a comprehensive legal management application designed for client-lawyer interactions. It provides features for project management, case tracking, document handling, invoicing, and real-time communication.

---

## Architecture Overview

### 1. Project Structure
```
lib/
├── common/                 # Shared components and controllers
│   ├── components/         # Reusable UI widgets
│   ├── controllers/        # Global controllers (theme, localization)
│   └── models/            # Common data models
├── core/                  # Core utilities and services
│   ├── helper/            # Utility helpers
│   ├── route/             # Navigation routing
│   ├── service/           # API services and DI
│   └── utils/             # Constants, themes, styles
└── features/              # Feature-based modules
    ├── auth/              # Authentication
    ├── cases/             # Legal case management
    ├── dashboard/         # Main dashboard
    ├── invoice/           # Invoice management
    ├── project/           # Project management
    └── [other features]/
```

### 2. Design Pattern
- **Clean Architecture** with feature-based modularization
- **Repository Pattern** for data layer abstraction
- **MVC Pattern** with GetX controllers
- **Dependency Injection** using GetX service locator

---

## Key Features

### Core Modules
1. **Authentication System**
   - User login/registration
   - JWT token management
   - Automatic session handling

2. **Dashboard**
   - Project status overview
   - Invoice analytics with charts
   - Quick access to key metrics

3. **Case Management** (Legal Focus)
   - Case tracking and details
   - Consultation scheduling
   - Document management
   - Hearing information

4. **Project Management**
   - Multi-tab project details
   - Task management
   - Time tracking
   - Discussion threads
   - Milestone tracking

5. **Financial Management**
   - Invoice tracking and payments
   - Estimate management
   - Contract handling with digital signatures

6. **Support System**
   - Ticket management
   - Knowledge base access

7. **Multi-language Support**
   - 6 languages: English, Arabic, German, Spanish, French, Hindi
   - RTL support for Arabic

---

## Technology Stack

### Core Dependencies
```yaml
# State Management & Navigation
get: ^4.7.2                    # State management & navigation

# Network & Data
http: ^1.3.0                   # HTTP requests
shared_preferences: ^2.5.2     # Local storage
cached_network_image: ^3.4.1   # Image caching
connectivity_plus: ^6.1.3      # Network connectivity

# UI Components
lottie: ^3.3.1                 # Animations
carousel_slider: ^5.0.0        # Image carousels
syncfusion_flutter_charts: ^28.2.6  # Chart widgets
curved_navigation_bar: ^1.0.6  # Bottom navigation

# Utilities
url_launcher: ^6.3.1          # External URL launching
share_plus: ^10.1.4           # Content sharing
image_picker: ^1.1.2          # Camera/gallery access
file_picker: ^9.0.0           # File selection
signature: ^6.0.0             # Digital signatures
```

### Development Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Code quality analysis

---

## State Management Architecture

### GetX Pattern Implementation
The application uses GetX for comprehensive state management with the following patterns:

#### 1. Controller Structure
```dart
class FeatureController extends GetxController {
  // Private variables
  bool _isLoading = false;
  
  // Public getters
  bool get isLoading => _isLoading;
  
  // State update method
  void updateState() {
    _isLoading = false;
    update(); // Notifies UI
  }
}
```

#### 2. View-Controller Binding
```dart
GetBuilder<FeatureController>(
  builder: (controller) => Widget(...)
);
```

#### 3. Dependency Injection
Controllers are injected using GetX's service locator:
```dart
Get.put(ApiClient(sharedPreferences: Get.find()));
Get.put(FeatureRepo(apiClient: Get.find()));
Get.put(FeatureController(repo: Get.find()));
```

---

## API Architecture

### 1. Centralized API Client
**File:** `lib/core/service/api_service.dart`

**Key Features:**
- Automatic JWT token injection
- Centralized error handling
- SSL certificate bypass for development
- Automatic logout on 401 errors
- Debug logging

### 2. Repository Pattern
Each feature implements a repository for API abstraction:

```dart
class FeatureRepo {
  final ApiClient apiClient;
  
  Future<ResponseModel> getData() async {
    String url = '${UrlContainer.baseUrl}/endpoint';
    final response = await apiClient.request(url, Method.getMethod);
    return ResponseModel.fromJson(response);
  }
}
```

### 3. Response Models
Standardized response handling with:
- Status codes
- Error messages
- JSON data parsing
- Type-safe model conversion

---

## UI/UX Architecture

### 1. Design System
**Theme Implementation:**
- Light/Dark theme support
- Consistent color palette via `ColorResources`
- Typography system with `Montserrat-Arabic` font family
- Responsive dimensions via `Dimensions` class

### 2. Component Library
**Location:** `lib/common/components/`

**Key Components:**
- **Custom AppBar** - Standardized app bar with actions
- **Custom Buttons** - Various button styles and loading states  
- **Custom Form Fields** - Validation-ready input fields
- **Custom Cards** - Consistent card layouts
- **Custom Dialogs** - Alert and confirmation dialogs
- **Custom Loaders** - Loading indicators
- **Bottom Sheets** - Modal bottom sheets for actions

### 3. Navigation System
**File:** `lib/core/route/route.dart`

- Named route system using GetX
- Centralized route definitions
- Parameter passing via `Get.arguments`
- 20+ defined routes for all screens

---

## Permission & Security System

### 1. Dynamic Feature Control
**MainNavigationController** manages feature availability:
- Runtime permission checking
- Dynamic navigation bar construction
- Feature disabling on 403 errors
- Graceful degradation

### 2. Authentication Security
- JWT token storage in secure preferences
- Automatic token refresh
- Session timeout handling
- Secure API communication

---

## Internationalization (i18n)

### 1. Multi-language Support
**Supported Languages:**
- English (en)
- Arabic (ar) - with RTL support
- German (de)
- Spanish (es)
- French (fr)
- Hindi (hi)

### 2. Implementation
- JSON-based translation files in `assets/lang/`
- GetX translation system
- Runtime language switching
- Persistent language preferences

---

## Data Models

### Core Models
1. **User Models**
   - LoginResponseModel
   - RegistrationResponseModel
   - UserProfile data

2. **Case Models**
   - CaseModel - Legal case details
   - ConsultationModel - Consultation scheduling
   - DocumentModel - Case documents
   - HearingModel - Court hearing information

3. **Project Models**
   - ProjectModel - Project overview
   - TaskModel - Task management
   - DiscussionModel - Communication threads
   - TimesheetModel - Time tracking

4. **Financial Models**
   - InvoiceModel - Invoice management
   - EstimateModel - Cost estimates
   - ContractModel - Legal contracts
   - PaymentModel - Payment tracking

---

## File Structure Details

### Assets Organization
```
assets/
├── images/           # Static images and icons
├── fonts/            # Montserrat-Arabic font family
├── lang/             # Translation JSON files
└── animation/        # Lottie animation files
```

### Feature Module Structure
Each feature follows consistent organization:
```
features/feature_name/
├── controller/       # GetX controllers
├── model/           # Data models
├── repo/            # Repository classes
├── view/            # Screen widgets
└── widget/          # Feature-specific widgets
```

---

## Development Guidelines

### 1. Code Quality
- Follows Flutter/Dart linting rules
- Consistent naming conventions
- Proper error handling with try-catch blocks
- Loading state management for all async operations

### 2. Testing Strategy
- Unit testing setup with flutter_test
- Repository layer testing recommended
- Controller logic testing
- Widget testing for complex UI components

### 3. Performance Considerations
- Lazy loading of dependencies
- Image caching with CachedNetworkImage
- Efficient list rendering for large datasets
- Memory management with proper dispose methods

---

## Key Screens

### 1. Authentication Flow
- **SplashScreen** - App initialization
- **OnBoardIntroScreen** - Feature introduction
- **LoginScreen** - User authentication
- **RegistrationScreen** - New user signup

### 2. Main Application
- **MainNavigationScreen** - Bottom tab navigation
- **DashboardScreen** - Analytics and overview
- **CasesScreen** - Legal case management
- **ProjectsScreen** - Project listing and management
- **InvoicesScreen** - Financial tracking
- **TicketsScreen** - Support system
- **ProfileScreen** - User profile management

### 3. Detail Screens
- **CaseDetailsScreen** - Individual case information
- **ProjectDetailsScreen** - Multi-tab project management
- **InvoiceDetailsScreen** - Invoice breakdown
- **ContractDetailsScreen** - Contract management
- **TicketDetailsScreen** - Support ticket details

---

## Integration Points

### 1. External Services
- **Backend API** - RESTful API integration
- **File Storage** - Document and image handling
- **Push Notifications** - (Framework ready)
- **Deep Linking** - URL-based navigation

### 2. Device Features
- **Camera/Gallery** - Document capture
- **File System** - Document management
- **Network Detection** - Offline handling
- **Secure Storage** - Sensitive data handling

---

## Deployment Configuration

### Android Configuration
**File:** `android/app/build.gradle`
- Package name: `com.flutex.customer`
- Minimum SDK: Android API level configuration
- Target SDK: Latest Android version
- Proguard configuration for release builds

### Assets Configuration
**File:** `pubspec.yaml`
- Images: `assets/images/`
- Fonts: Montserrat-Arabic family
- Translations: `assets/lang/`
- Animations: `assets/animation/`

---

## Future Enhancement Opportunities

### 1. Technical Improvements
- Implement proper error logging service
- Add comprehensive testing suite
- Implement offline-first architecture
- Add push notification handling
- Implement biometric authentication

### 2. Feature Enhancements
- Real-time chat system
- Video consultation integration
- Advanced document editing
- Calendar integration
- Advanced analytics dashboard

### 3. Performance Optimizations
- Implement pagination for large lists
- Add image compression for uploads
- Implement background task processing
- Add advanced caching strategies

---

## Conclusion

The Legumlex Customer Portal is a well-structured Flutter application that demonstrates modern mobile development practices. It provides a comprehensive legal management solution with robust architecture, clean code organization, and excellent user experience considerations. The modular design and clean architecture make it highly maintainable and extensible for future requirements.

---

*This documentation provides a comprehensive overview of the current application architecture and serves as a foundation for any future UI redesign or feature development efforts.*