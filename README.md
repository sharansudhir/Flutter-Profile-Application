# profile_management

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

The application has 2 Text Fields, and a Forgot Password Button which directs to a page to enter email and password. The email has validation for which regular expression has been created and a password field has been created without any validation. Two button, one that allows to go back and a Change Password Button which on successful validation shows a toast message.

On the Main page, a dropdown list is generated by using an API from https://www.printful.com/docs/countries, and on selection of Canada, the submit button gets activated, selection of any country other than canada sets the button as inactive. A datepicker has been added to add Date of Birth.

On click of submit button, toast message "Profile Saved" appears.

The application was created on VS Code on Windows 10 OS. The emulator was created using AVD Manager. The APK version can be downloaded in the path \build\app\outputs\flutter-apk".