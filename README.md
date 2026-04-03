## SehhaLink

SehhaLink is a Flutter application for managing user accounts and uploading medical documents with file management and summaries.

### Features

- **Onboarding**
  - Localized onboarding screen content
- **Authentication**
  - Register
  - Login
  - Forgot password (send OTP)
  - Reset password (OTP + new password)
  - Token persistence in secure storage
- **Home**
  - Upload summary card
  - Upload medical documents (file picker, multi-select)
  - Drag and drop upload (where supported)
  - Upload progress list (uploading/done/failed)
- **Files**
  - View uploaded files
  - Open files from device
  - Delete files (confirmation dialog)
- **Profile**
  - Profile details
  - Update profile photo (camera/gallery)
  - Drawer with language selection
  - Logout
- **Localization**
  - English and Arabic translations

### Tech stack and architecture

- **State management**: `flutter_bloc` using `Cubit`
  - Examples: `LoginCubit`, `RegisterCubit`, `ForgetPasswordCubit`, `HomeCubit`, `CurrentUserCubit`
- **Dependency injection**: `get_it`
  - Setup: `lib/core/dependency_Injection/get_it.dart`
  - Feature-specific registration: `lib/core/dependency_Injection/*_di.dart`
- **Networking**: `dio`
  - Factory: `lib/core/networking/dio_factory.dart`
  - Abstractions: `NetworkService` and `RemoteDataSource`
- **Local storage**
  - **Database**: `isar`
    - Initialization: `lib/core/service/isar_service.dart`
    - Models: `lib/core/current_user/data/model/`
  - **Secure storage**: `flutter_secure_storage`
    - Token handling: `lib/core/service/secure_storage_service.dart`
  - **Local profile image caching**
    - Profile images are copied into the app documents directory
- **Localization**: `easy_localization`
  - Dictionaries: `assets/translations/en.json`, `assets/translations/ar.json`
- **Routing**
  - Route generator: `lib/core/routing/app_route.dart`
  - Route names: `lib/core/routing/routes.dart`
- **UI utilities**
  - Responsive sizing: `flutter_screenutil`
  - Drawer: `flutter_advanced_drawer`
  - Bottom navigation: `salomon_bottom_bar`

### Project structure (high level)

- `lib/core/`: app-wide services, networking, DI, routing, theme, helpers, shared widgets
- `lib/features/`: feature modules (auth, home, profile, navigation, view_details)
- `assets/translations/`: localization files (`en.json`, `ar.json`)

### Requirements

- Flutter SDK (stable)
- Dart SDK (bundled with Flutter)

### Setup

Install dependencies:

```bash
flutter pub get
```

### Run

```bash
flutter run
```

### Tests

```bash
flutter test
```

### Localization

Translations are stored in:

- `assets/translations/en.json`
- `assets/translations/ar.json`

Usage in widgets:

```dart
'profile.logout'.tr()
```

To add a new string:

- Add the key to both `en.json` and `ar.json`
- Replace any hardcoded UI text with `'<key>'.tr()`

### Build (examples)

Android APK:

```bash
flutter build apk
```

Web:

```bash
flutter build web
```
