# KAI - Cyberpunk AI Companion

KAI is a custom, fully-featured mobile AI companion built with Flutter. Designed with a dark cyberpunk aesthetic, KAI acts as a "logical anchor," processing human conversational inputs through a strictly rational, higher-dimensional perspective.

**Created by:** SHREYAN

## 🚀 Features

* **Advanced AI Brain:** Powered by the Google Gemini API (optimized for Flash models like `gemini-2.5-flash` and `gemini-3.8-flash`) for rapid, high-context reasoning.
* **Offline Voice Recognition:** Utilizes the `vosk_flutter` package to provide completely offline, on-device wake-word detection and speech-to-text transcription.
* **Persistent Local Memory:** Employs SQLite (`sqflite`) to securely store and retrieve chat history entirely on the device without needing a cloud database.
* **Cyberpunk UI:** A sleek, dark-themed user interface designed for immersion.
* **Custom Persona Engine:** Strictly adheres to its programmed identity as a logical companion created by SHREYAN.

## 🛠️ Tech Stack

* **Frontend:** Flutter / Dart
* **AI Integration:** `google_generative_ai`
* **Local Database:** `sqflite`, `path`
* **Audio & Speech:** `vosk_flutter`, `permission_handler`
* **Platform:** Android (Compiled for SDK 34)

## ⚙️ Getting Started

### Prerequisites
* Flutter SDK (Latest stable)
* Android Studio with Android SDK 34 installed

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/kai_companion.git
   cd kai_companion
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure the Gemini API Key:**
   * Obtain an API key from [Google AI Studio](https://aistudio.google.com/).
   * Place your API key in your project's configuration file (e.g., `lib/features/chat/gemini_service.dart` or a secure constants file).

4. **Add the Vosk Offline Audio Model:**
   * Download a compatible lightweight Vosk model (e.g., English) from the official Vosk website.
   * Extract the model files and place them inside the `assets/vosk_model` directory in the root of this project.
   * Ensure the assets path is correctly declared in your `pubspec.yaml`.

5. **Run the app:**
   ```bash
   flutter run
   ```

## 🧩 Build Notes & Troubleshooting

This project uses modern Android Gradle configurations (AGP 8.0+). If you encounter build errors on a fresh clone regarding `permission_handler` or `vosk_flutter` targeting older SDKs, ensure that:
* The `dependency_overrides` for `permission_handler: ^11.3.1` and `permission_handler_android: ^12.0.13` are present in your `pubspec.yaml`.
* The `targetSdkVersion` and `compileSdkVersion` inside the cached `vosk_flutter` package are bumped to `34`, and the old `package=` attribute is removed from its `AndroidManifest.xml` if Flutter's auto-fix fails.

## 🔮 Future Roadmap

* [ ] Add visual microphone pulse for active listening.
* [ ] Integrate word-by-word streaming for Gemini responses.
* [ ] Explore Firebase/Supabase integration for encrypted group-chat syncing.