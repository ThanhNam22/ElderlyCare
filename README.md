# 🏥 Doctor Appointment Booking App

A **Flutter-based mobile application** that connects patients and doctors through an intuitive appointment booking system.  
This app supports **two user roles**: **Patient** and **Doctor**.

---

## ✨ Features

### 👤 Patient Role

- Browse and select available doctors  
- Book appointments with doctors  
- Make online payments for consultations  
- Leave reviews and ratings for doctors  

### 👨‍⚕️ Doctor Role

- View upcoming appointments  
- Confirm or reject appointment requests  

---

## 🚀 Technologies Used

- **Flutter** (latest stable version)  
- **Dart** for frontend logic  
- Backend (not specified) – expected to include:
  - Authentication  
  - Scheduling  
  - Payment handling  

---

## 📲 Getting Started

### Prerequisites

- Flutter SDK installed  
- Android Studio or VS Code with Flutter extensions  
- Emulator or physical Android/iOS device  

### Installation

1. **Clone the repository**  
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

2. **Install dependencies**  
   ```bash
   flutter pub get
   ```

3. **Run the app**  
   ```bash
   flutter run
   ```

---

## 📦 Suggested Folder Structure

```
lib/
├── models/           # Data models
├── screens/          # UI Screens
│   ├── patient/      # Screens for Patient role
│   └── doctor/       # Screens for Doctor role
├── services/         # API calls and business logic
├── widgets/          # Reusable UI components
└── main.dart         # App entry point
```

---

## 🛡️ Role Management

- The app determines the user's role upon login (e.g., based on backend response or profile data).
- Each role has access to specific screens and functionalities tailored to their needs.

---

## 📅 Appointment Flow

1. **Patient** selects a doctor and chooses a preferred time slot.  
2. **Doctor** receives the appointment request and confirms or rejects it.  
3. **Patient** is notified of the confirmation and can proceed with payment if accepted.  

---

## 💬 Feedback and Reviews

- After each appointment, patients can leave reviews and rate their doctor.  
- Ratings help improve service quality and assist other users in choosing doctors.

---

## 📧 Contact

For bug reports, issues, or feature requests, please open an issue in this repository or contact the project maintainer.


## 🖼️ Screenshots (Grid View)

<table>
  <tr>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/1.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/2.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/3.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/4.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/5.jpg?raw=true" width="150"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/6.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/7.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/8.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/9.jpg?raw=true" width="150"/></td>
    <td><img src="https://github.com/ThanhNam22/ElderlyCare/blob/main/screenshot/10.jpg?raw=true" width="150"/></td>
  </tr>
</table>


