# XConvert

A comprehensive unit converter app built with Flutter that allows users to convert between various units of measurement.

![XConvert Banner](assets/images/app_banner.png)

## Download & Try
[**👉 Download XConvert_v1.0.0.apk**](https://github.com/farrakhanwahab/XConvert/releases/download/v1.0.0/XConvert_v1.0.0.apk)  
*(SHA-256: `c2d103c2c4a1aa171f39e1742ef96c447b0abc2e41178f0d5ed1e0e8556cf4a3`)*

## Features

- Currency conversion with live exchange rates
- Length, weight, temperature, area, volume conversions
- Speed, time, energy, power, data, frequency conversions
- Animated splash screen with flag-like text animation
- Dark and light theme support
- Responsive design

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/farrakhanwahab/XConvert.git
   cd XConvert
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development

- The app uses Riverpod for state management
- Currency data is fetched from external APIs
- Theme supports both light and dark modes
- All converter screens inherit from BaseConverterScreen

## Dependencies

- flutter_riverpod: State management
- http: API calls for currency rates
- google_fonts: Typography
- fl_chart: Charts for currency history
- lucide_icons: Icon set
- shared_preferences: Local storage

## API Details

**Currency API:** [Frankfurter API](https://api.frankfurter.app) - Free, no key required
- Live exchange rates and historical data
- Shows error message if unavailable
- Other converters work offline
