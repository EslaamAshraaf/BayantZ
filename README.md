# BayanTZ Attendance Management App

This Flutter app helps manage and visualize employee attendance records stored in **Firebase Firestore**.  
It’s built with a clean, modular architecture using **Cubit** for state management, and designed to follow **Material Design** principles with full responsiveness across devices.

---

##  Overview

The application connects to Firebase to display employee information, attendance status, and summary data.  
It includes search, filter, and export features, along with real-time updates from Firestore.

Key highlights:
- Organized using **Clean Architecture** (data, domain, presentation layers).
- State management handled entirely by **Cubit**.
- Light and Dark mode support via `ThemeCubit`.
- All UI components designed according to the provided **Figma** specifications.

---

##  Main Features

###  Employee Information
- Displays employee details from Firebase.
- Shows status (Present, Absent, Late) consistently across the app.

###  Attendance Section
- Real-time data updates through Firestore.
- Three summary containers represent current attendance states.
- All values come from Firebase — nothing is hardcoded.

###  Search and Filter
- Search employees by attendance status.
- Filter dialog works as shown in the Figma design, with field validation included.

###  Export Dialog (UI)
- Includes a Material dialog for exporting attendance data.
- Currently implemented as UI only (no file export logic yet).

###  Attendance Table
- Table layout designed to match Figma specifications.
- Color-coded rows based on attendance state.
- Scrollable and adaptive for different screen sizes.

---

##  Design and Responsiveness

- The entire UI adapts to desktop, tablet, and mobile views.
- All dialogs use Material “Paper Dialog” design: padded, rounded, and clearly actionable.
- Light and Dark modes are supported.
- Consistent color palette defined in `app_colors.dart`.
- Icons implemented as SVG assets.

---

##  Architecture

The app follows a clean and scalable architecture to ensure separation of concerns.

