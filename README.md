# 📻 Radio Stations App

A beautifully crafted Flutter app to **search, listen to, and favorite radio stations** from around the world.  
Built with 💙 using **MVVM architecture**, **Provider**, **Floor (SQLite)**, and **just_audio**.

---

## ✨ Features

- 🔎 Real-time **search bar** for station discovery
- 📡 Stream any station with **buffering indicator**
- ❤️ **Add/Remove favorites**, stored locally via SQLite
- 🎚️ **Play/Pause and Volume control**
- 🌓 **Dark Mode support** (auto-switch based on system theme)
- 💾 Favorites persist across app restarts
- ✅ Fully reactive UI using `Provider` + `StreamBuilder`
- 🚀 Clean architecture (MVVM + DI)

---

## 🚀 Quick Start

### 🔧 Requirements

- Flutter **3.19.0** or newer
- Dart **3.2.0** or newer
- Android Studio / Xcode / VS Code

---

### 🛠 Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/radio-stations-app.git
   cd radio-stations-app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate Floor database code**

   > This step generates the `app_database.g.dart` file for SQLite DAO access.

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

---

### ▶️ Run the App

#### 💻 On Android emulator or device

```bash
flutter run
```

#### 🍎 On iOS simulator or device

```bash
flutter run -d ios
```

#### Run tests

```bash
flutter test
```

> If you face any `App Transport Security` issue when streaming HTTP stations on iOS,  
> make sure your `Info.plist` allows insecure media content (for dev only).

---

### 🔁 Rebuilding Floor (after model/DAO changes)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

✅ Follows MVVM pattern  
✅ Uses `Provider` for DI and state management  
✅ Uses `Floor` for reactive local storage

---

