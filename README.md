# Weather App

This application utilizes Google Maps and CoreLocation to provide weather information and navigation features. It allows users to set destinations, receive weather updates, and manage trips effectively.

## Features

1. **Current Location Navigation**
   - Displays user's current location on Google Maps.
   - Allows navigation to the current location with a dedicated button.

2. **Trip Management**
   - Enables setting a destination using geocoding and displaying it on the map.
   - Supports setting reminders for destination arrival.

3. **User Interface**
   - Custom UI elements for intuitive user interaction.
   - Implements shadow effects and button actions for improved usability.

4. **Error Handling and Alerts**
   - Alerts users for location access issues and trip completion confirmation.
   - Handles crashes gracefully with debug options.

5. **Background Operation**
   - Supports background location updates and alarm sounds during navigation.

## Implementation Details

- **Technologies Used:** Google Maps SDK, CoreLocation, UIKit, AVFoundation.
- **Design Patterns:** Utilizes delegation and closures for UI updates and user interactions.
- **Data Persistence:** Stores trip details and preferences using UserDefaults for offline by using RealmSwift.

## Screenshots

![Uploading Simulator Screenshot - iPhone 15 Pro - 2024-07-09 at 12.46.24.png…]()

## Credits

- Developed by Karthikeyan K
- Contact: karthi10062001@gmail.com
