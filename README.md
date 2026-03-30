# 💬 FlutterChat

A modern, feature-rich real-time messaging application built with Flutter and Firebase. Enjoy seamless communication with authentication, image sharing, and real-time message synchronization across multiple platforms.

[![Flutter](https://img.shields.io/badge/Flutter-3.9-blue.svg)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-orange.svg)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Linux%20%7C%20macOS%20%7C%20Windows-informational)](https://flutter.dev)

## ✨ Features

- 🔐 **Secure Authentication** - Firebase Auth integration with email/password and social sign-in support
- 💬 **Real-Time Messaging** - Instant message delivery using Firestore
- 🖼️ **Image Sharing** - Send and receive images directly in conversations
- 👥 **User Profiles** - Manage user information and online status
- 📱 **Cross-Platform** - Run on Android, iOS, Web, Linux, macOS, and Windows
- 🎨 **Modern UI** - Material Design 3 with beautiful color schemes
- 🔔 **Push Notifications** - Firebase Cloud Messaging for instant notifications
- 💾 **Cloud Storage** - Firebase Storage for media backup and retrieval

## 📋 Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Flutter** | Cross-platform mobile & desktop framework |
| **Dart** | Programming language |
| **Firebase Auth** | User authentication & management |
| **Firestore** | Real-time database |
| **Firebase Storage** | Media file storage |
| **Firebase Cloud Messaging** | Push notifications |
| **Image Picker** | Local image selection |

## 📁 Project Structure

```
lib/
├── main.dart              # App entry point & MaterialApp configuration
├── firebase_options.dart  # Firebase initialization config
├── screens/
│   ├── auth.dart         # Authentication screen (login/signup)
│   └── chats.dart        # Chat list & messaging screen
└── widgets/
    ├── chat_messages.dart    # Messages display widget
    ├── message_bubble.dart   # Individual message UI
    ├── new_message.dart      # Message input widget
    └── image_picker.dart     # Image selection widget
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (3.9.2 or higher)
- **Dart SDK** (included with Flutter)
- **Git** for version control
- A [Firebase Project](https://firebase.google.com)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-chat.git
   cd flutter-chat
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication (Email/Password)
   - Create a Firestore database
   - Enable Cloud Storage
   - Download and place `google-services.json` in `android/app/`
   - Download and place `GoogleService-Info.plist` in `ios/Runner/`

4. **Run the app**
   ```bash
   # For Android
   flutter run -d android

   # For iOS
   flutter run -d ios

   # For Web
   flutter run -d web

   # For all connected devices
   flutter run
   ```

## ⚙️ Configuration

### Firebase Setup (Detailed)

1. **Authentication**
   - Enable Email/Password authentication in Firebase Console
   - Configure authentication rules in Firestore

2. **Firestore Database**
   - Create collections: `users`, `chats`, `messages`
   - Set appropriate security rules for user privacy

3. **Cloud Storage**
   - Enable Firebase Storage
   - Configure access rules for media files

4. **Platform-Specific Configuration**
   - **Android**: Update `android/build.gradle.kts` with your package name
   - **iOS**: Update `ios/Runner/Info.plist` with GoogleService-Info.plist
   - **Web**: Update `web/index.html` with Firebase config

## 📖 Usage

### User Registration & Login
1. Launch the app
2. Create a new account with email and password
3. Verify your email address
4. Start chatting with other users

### Sending Messages
1. Navigate to the chat screen
2. Select a conversation or create a new one
3. Type your message in the input field
4. Press send (or use the send button)

### Sharing Images
1. In a chat conversation
2. Tap the image picker button
3. Select an image from your gallery
4. Image will be uploaded and shared instantly

## 🔒 Security

This app implements several security best practices:

- **Firebase Authentication** for secure user management
- **Firestore Security Rules** to protect user data
- **HTTPS/SSL** for all network communications
- **Environment-based Configuration** for sensitive data

## 🛠️ Development

### Building for Production

```bash
# Android
flutter build apk
# or
flutter build appbundle

# iOS
flutter build ios

# Web
flutter build web

# Windows
flutter build windows
```

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

## 📝 Code Guidelines

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart)
- Use meaningful variable and function names
- Comment complex logic
- Keep widgets small and reusable
- Use const constructors where possible

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-chat.git
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```

4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```

5. **Open a Pull Request**
   - Describe your changes clearly
   - Include any relevant issue numbers
   - Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support & Contact

Have questions or need help?

- 📧 Email: support@flutterchat.dev
- 🐛 Report bugs via GitHub Issues
- 💡 Suggest features via GitHub Discussions
- 📖 Check out the [Flutter Documentation](https://flutter.dev/docs)

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Firebase](https://firebase.google.com) for backend services
- [Material Design](https://material.io) for design guidelines
- All contributors and users of this project

---

<div align="center">

Made with ❤️ using Flutter & Firebase

[⬆ Back to top](#-flutterchat)

</div>
