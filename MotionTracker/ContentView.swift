//
//  ContentView.swift
//  MotionTracker
//
//  Created by Maliha on 9/2/25.
//

import SwiftUI
import CoreMotion
import CoreBluetooth
import Charts

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    @StateObject private var bluetoothManager = BluetoothManager()
    
    var body: some View {
        VStack {
            Text("Speed: \(motionManager.speed, specifier: "%.2f") m/s")
                .font(.largeTitle)
                .padding()
            
            Text("Acceleration: \(motionManager.acceleration, specifier: "%.2f") m/s²")
                .font(.title2)
                .padding()
            
            //need to improve data visualization
            
            Chart(motionManager.dataPoints) { point in
                LineMark(
                    x: .value("Time", point.time),
                    y: .value("Acceleration", point.acceleration)
                )
                .foregroundStyle(.blue)
            }
            .frame(height: 200)
            .padding()
            
            //currently it connects with bluetooth device but do not capture motion data,
            //need to update code and test with smart watches having built-in motion sensors and open API
            
            Text("Bluetooth: \(bluetoothManager.isConnected ? "Connected" : "Disconnected")")
                .foregroundColor(bluetoothManager.isConnected ? .green : .red)
                .padding()
            
            // capturing motion data of the smart app where the app is running
            
            Button(action: {
                motionManager.isTracking ? motionManager.stopTracking() : motionManager.startTracking()
            }) {
                Text(motionManager.isTracking ? "Stop Tracking" : "Start Tracking")
                    .font(.title)
                    .padding()
                    .background(motionManager.isTracking ? Color.yellow : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
