# 🌤️ Weather App 

A feature-rich, high-performance Weather application built with Flutter, combining a pixel-perfect UI with a highly scalable architectural foundation. 

Under the hood, the project is structured around **Clean Architecture**, leveraging **Cubit (`flutter_bloc`)** for efficient, optimized state management. It handles complex data flows—such as switching between live GPS location weather and searched city forecasts—without unnecessary network overhead. Real-time data is fetched via the **OpenWeatherMap API** using robust HTTP client requests, demonstrating a strong separation of concerns across models, services, and presentation layers.

## 📸 Screenshots & UI Design
 
### Splash Screen
<p align="center">
  <img src="https://github.com/user-attachments/assets/81ba6f0f-dec5-43e8-b0fe-a63ee8e26435" width="45%" title="Splash Light" />
  <img src="https://github.com/user-attachments/assets/14ead5ee-12a9-433a-a0d5-a6a7228d5e3c" width="45%" title="Splash Dark" />
</p>

### Authentication (Light Mode)
<p align="center">
  <img src="https://github.com/user-attachments/assets/83662c8c-12d1-420e-b097-a3bb5b0231cb" width="30%" title="Sign Up Light" />
  <img src="https://github.com/user-attachments/assets/66fb19b6-ef89-4164-b90a-d94d37afdc36" width="30%" title="Login Light" />
  <img src="https://github.com/user-attachments/assets/d5752aff-5adf-4122-ac75-1f63a451128a" width="30%" title="Forgot Password Light" />
</p>

### Authentication (Dark Mode)
<p align="center">
  <img src="https://github.com/user-attachments/assets/a0d57dc5-c8f2-410c-ad57-3a1ab203ca30" width="30%" title="Sign Up Dark" />
  <img src="https://github.com/user-attachments/assets/2ef3cd9c-c564-496f-8a12-0f845a9206a4" width="30%" title="Login Dark" />
  <img src="https://github.com/user-attachments/assets/a0fdad98-2a23-44dc-8bde-3361ab93147b" width="30%" title="Forgot Password Dark" />
</p>

### Home Screen (Light Mode)
<p align="center">
  <img src="https://github.com/user-attachments/assets/9babfb3d-fd07-44ce-98df-89a4889faef4" width="45%" title="Home Light Part 1" />
  <img src="https://github.com/user-attachments/assets/3c8caabd-b0cf-48f2-8845-91a71b312823" width="45%" title="Home Light Part 2" />
</p>

### Home Screen (Dark Mode)
<p align="center">
  <img src="https://github.com/user-attachments/assets/d9371702-35d6-4306-bd27-647bb0426c42" width="45%" title="Home Dark Part 1" />
  <img src="https://github.com/user-attachments/assets/39bac88d-7f0c-45ed-b0d8-bc301225e6bc" width="45%" title="Home Dark Part 2" />
</p>

### Search
<p align="center">
  <img src="https://github.com/user-attachments/assets/320adc6e-a1e9-4d3d-bcfd-8770ee0cf7a1" width="23%" title="Search Light 1" />
  <img src="https://github.com/user-attachments/assets/6082be78-a2d5-434f-8fdb-dbe308767475" width="23%" title="Search Light 2" />
  <img src="https://github.com/user-attachments/assets/71e11459-f9e2-41c7-bd05-5700215018fd" width="23%" title="Search Dark 1" />
  <img src="https://github.com/user-attachments/assets/c5df1ccf-d58c-4fe9-abfc-bb56cb77fa41" width="23%" title="Search Dark 2" />
</p>

### Selected City Weather
<p align="center">
  <img src="https://github.com/user-attachments/assets/406b9330-d773-46d5-a179-b8a6150feb5d" width="23%" title="Selected City Light 1" />
  <img src="https://github.com/user-attachments/assets/1b7e35d7-f03f-4bc4-b50e-cec8262d5da7" width="23%" title="Selected City Light 2" />
  <img src="https://github.com/user-attachments/assets/4f32817f-6bcc-423c-8e47-883a440ef70b" width="23%" title="Selected City Dark 1" />
  <img src="https://github.com/user-attachments/assets/bcc34abe-98da-46a0-858e-89583db36013" width="23%" title="Selected City Dark 2" />
</p>

### Forecast
<p align="center">
  <img src="https://github.com/user-attachments/assets/ca7fe5cb-b21c-43c6-a73c-8150f6daf236" width="45%" title="Forecast Light" />
  <img src="https://github.com/user-attachments/assets/dac53616-0c96-48e3-a051-0b362d192fce" width="45%" title="Forecast Dark" />
</p>

### Profile
<p align="center">
  <img src="https://github.com/user-attachments/assets/d7360b53-d8e4-4f09-8d41-29545ffa2441" width="45%" title="Profile Light" />
  <img src="https://github.com/user-attachments/assets/1c4c6fe3-7790-4406-b6ed-4d4639ee2502" width="45%" title="Profile Dark" />
</p>


## ✨ Key Features

* **Advanced State Management (`flutter_bloc`):** Utilizes Cubit to efficiently manage global and local states, ensuring minimal widget rebuilds and a strict separation of business logic from the UI.
* **Robust REST API Integration:** Seamlessly fetches real-time weather data and forecasts from OpenWeatherMap using `dio`, coupled with `pretty_dio_logger` for clean and readable network debugging.
* **Secure Authentication & Database:** Features a comprehensive authentication flow powered by `firebase_auth`, supporting standard Email/Password login alongside social integrations (`google_sign_in` & `flutter_facebook_auth`). User data is securely managed via `cloud_firestore`.
* **Smart Location Services:** Uses `geolocator` to fetch precise user coordinates for local weather, and `geocoding` to translate coordinates into readable city and country names.
* **Pixel-Perfect Responsive UI:** Built utilizing `flutter_screenutil` to guarantee adaptive layouts, consistent padding, and adaptable font sizes across all screen dimensions. `auto_size_text` is used to gracefully handle dynamic text lengths without overflow errors.
* **Elegant Loading States:** Enhances perceived performance and UX by replacing traditional loading spinners with beautiful, modern shimmer effects using `skeletonizer`.
* **Dynamic Theming & Preferences:** Fully supports instant switching between Light and Dark modes. User preferences (Theme, Temperature Units, time format) are persistently saved locally using `shared_preferences`.
* **Clean Architecture:** The codebase follows a scalable folder structure, neatly separating models, services, cubits, and UI components for maximum maintainability.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** [Dart](https://dart.dev/)
* **State Management:** `flutter_bloc` (Cubit), `equatable`
* **Networking:** `dio`, `pretty_dio_logger`
* **Backend & Auth:** `firebase_core`, `firebase_auth`, `cloud_firestore`, `google_sign_in`, `flutter_facebook_auth`
* **Location Services:** `geolocator`, `geocoding`
* **UI Components & Styling:** `flutter_screenutil`, `skeletonizer`, `auto_size_text`
* **Local Storage:** `shared_preferences`
