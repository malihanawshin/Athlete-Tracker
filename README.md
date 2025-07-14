# Motion Bluetooth Tracker

**Motion Bluetooth Tracker** is a SwiftUI-based iOS app that tracks motion data either from the iPhone’s built-in sensors or a connected Bluetooth Low Energy (BLE) device (e.g., smartwatch). The app visualizes real-time acceleration data on a line chart and displays current speed and acceleration numerically.

## Features

* Real-time motion data visualization using Charts
* Tracks motion using Core Motion when no BLE device is connected
* Connects to BLE devices that broadcast motion data
* Automatic scanning and connection to BLE peripherals
* Displays speed and acceleration values
* Simple user interface with a single "Start Tracking" button

## Technologies Used

* SwiftUI
* Core Motion
* Core Bluetooth
* Charts framework (iOS 16+)

## How It Works

1. **On Launch**:

   * The app starts scanning for BLE peripherals.
   * If a known BLE device is connected, it listens for motion data from the device.
   * If no BLE device is available, it uses the iPhone's internal motion sensors.

2. **On "Start Tracking" Button Press**:

   * If a BLE device is connected, it begins fetching motion data from that peripheral.
   * Otherwise, it starts collecting motion data from the phone's accelerometer.

3. **UI**:

   * A single chart shows motion (acceleration) data over time.
   * Current speed and acceleration are shown below the chart in text format.

## Project Structure

```
MotionBluetoothTracker/
├── MotionTrackingView.swift       # Main UI with chart and controls
├── MotionManager.swift            # Tracks motion using Core Motion
├── BluetoothManager.swift         # Handles BLE scanning and data reception
├── Models/
│   └── MotionData.swift           # Struct for storing motion data
├── Assets/
│   └── AppIcon, LaunchScreen, etc.
└── Info.plist                     # Add required permissions here
```

## Privacy Usage

Ensure your `Info.plist` includes:

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app uses Bluetooth to receive motion data from external devices.</string>
```

## Requirements

* iOS 16+
* Xcode 14+
* A BLE peripheral that sends motion data (e.g., Apple Watch with developer mode, custom BLE device, or BLE simulator like LightBlue)

## Limitations

* BLE motion tracking depends on the connected device's capabilities and services.
* Xiaomi Smart Band 7 and some commercial wearables may not expose motion characteristics via BLE.

