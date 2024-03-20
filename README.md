# Korean Master: Learn Korean Effectively

Welcome to Korean Master, the ultimate app for learning key concepts of the Korean language, expanding your vocabulary, and immersing yourself in Korean culture. Our app is designed to make learning Korean engaging, informative, and fun, complete with achievements to track your progress.

## Features

Korean Master is divided into two main components: the learner's app and the CMS for content management. Here's what you can expect from each:

### Learner's App

- **Vocabulary:** Get introduced to essential Korean vocabulary. (Note: Active learning component under development)
- **Lessons Management:** Access well-structured lessons on Korean grammar, phrases, and usage.
- **Culture Tips:** Learn about Korean culture with tips and facts that enhance your learning experience.
- **Achievements:** Track your progress and unlock achievements as you learn.

### CMS (macOS App)

- **Content Management:** Easily add, modify, and organize lessons, vocabulary, and cultural tips.
- **Firebase Integration:** Manage user data and app content securely.

## Currently Implemented Features

As of now, the following features are available:

- Basic vocabulary introduction (without active learning quizzes)
- Management of Korean lessons
- Korean cultural tips and facts

We are continuously working to add more features and enhance your learning experience.

## Build Steps

### Learner's App
1. **Setup:**
   - Ensure you have Xcode installed on your macOS device.
   - Clone the repository to your local machine.

2. **Firebase Configuration:**
   - Obtain `GoogleService-Info.plist` for Firebase:
     - Contact the developer to obtain the file, or
     - Create your own Firebase project and download the file.
   - Add `GoogleService-Info.plist` to the app's root directory.

3. **Build and Run:**
   - Open the project in Xcode.
   - Resolve any dependencies.
   - Build and run the app.

### CMS (macOS App)

1. **Setup:**
   - Ensure you have Xcode installed on your macOS device.
   - Clone the repository to your local machine.

2. **Firebase Configuration:**
   - Obtain `GoogleService-Info.plist` for Firebase:
     - Contact the developer to obtain the file, or
     - Create your own Firebase project and download the file.
   - Add `GoogleService-Info.plist` to the app's root directory.

3. **Folder Structure:**
   - Create the following folders within the project directory:
     - `Static/` for static resources.
     - `API/` for API-related files.
   - Within the `API/` directory, create a new Swift file (e.g., `DeepLConfig.swift`).
   - Declare a variable for the DeepL API key (e.g., `let deeplAPIKey = "YOUR_API_KEY"`).

4. **Build and Run:**
   - Open the CMS project in Xcode.
   - Resolve any dependencies.
   - Build and run the CMS app.

## Support

If you encounter any issues or have questions, feel free to open an issue on the GitHub repository or contact the developer directly.
'support.koreanmaster@malteruff.com'
---

Enjoy learning Korean with Korean Master, and embark on your journey to mastering the language while diving deep into the fascinating Korean culture!
