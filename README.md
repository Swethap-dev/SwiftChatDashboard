# SwiftChatDashboard

**SwiftChatDashboard** is a SwiftUI-based iOS application that demonstrates a modern chat interface combined with a feature-rich dashboard.
The app focuses on **Clean Architecture**, **MVVM**, and smooth user experience using native Apple frameworks.

---

## ✨ Features

### 💬 Chat

* Chat list with unread message count
* Dynamic chat bubbles with auto-scrolling
* Last message & timestamp shown per conversation
* Mark messages as read when opening a chat
* System avatars with clean UI styling

### 📊 Dashboard

* Location-based simulated weather
* Interactive map with user & custom locations
* Statistics chart showing:

  * Unread messages
  * Images sent
  * Saved locations
* Pull-to-refresh support

### 🖼 Image Handling

* Capture images using camera
* Select images from photo library
* Grid-based image gallery
* Image detail preview

### 🎨 UI & UX

* SwiftUI animations & transitions
* Gradient backgrounds & modern card layouts
* Responsive layouts for different screen sizes

---

## 🧱 Architecture

* SwiftUI
* MVVM
* Clean Architecture
* Async/Await
* Repository pattern
* Single source of truth using shared ViewModels

---

## 🛠 Tech Stack

* SwiftUI
* MapKit
* Swift Charts
* CoreLocation
* UIKit (UIImagePickerController integration)

> ❌ No paid APIs
> ❌ No API keys required
> ✅ Runs fully offline with simulated data

---

## 🚀 Getting Started

1. Clone the repository

```bash
git clone <repo-url>
```

2. Open in Xcode

```bash
open SwiftChatDashboard.xcodeproj
```

3. Run on:

* Real device (for camera & location)
* Simulator (photo library supported)

---

## 📌 Notes

* Camera works **only on real devices**
* Location permission is required for map & weather simulation
* Image & chat data are stored in memory (demo purpose)

---

## 📄 License

This project is for learning and demonstration purposes.

