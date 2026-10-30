# KAI - AI Companion

KAI is a custom, fully mobile AI companion built with Flutter. 

**Created by:** SHREYAN

## Features

* **Advanced AI Brain:** Google Gemini API (Flash models like `gemini-2.5-flash` and `gemini-3.5-flash`) for rapid, high reasoning.
* **Offline Voice Recognition:** Uses the `vosk_flutter` package to provide completely offline, on-device wake-word detection and speech-to-text transcription.
* **Persistent Local Memory:** Uses SQLite (`sqflite`) to securely store and retrieve chat history entirely on the device without needing a cloud database.
* **Cyberpunk UI:** A sleek, dark-themed user interface.
* **Custom Personal Engine:** Strictly adheres to its programmed identity as a logical companion.

##  Tech Stack

* **Frontend:** Flutter / Dart
* **AI Integration:** `google_generative_ai`
* **Local Database:** `sqflite`, `path`
* **Audio & Speech:** `vosk_flutter`, `permission_handler`
* **Platform:** Android (Compiled for SDK 34)

##  Getting Started

### Prerequisites
* Flutter SDK (Latest stable)
* Android Studio with Android SDK 34 installed

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/beingshreyan/Kai-AI-FLUTTER.git
   cd Kai-AI-FLUTTER
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure the Gemini API Key:**
   * Obtain an API key from [Google AI Studio](https://aistudio.google.com/).
   * Place your API key in your project's configuration file (`lib/core/constants.dart').

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