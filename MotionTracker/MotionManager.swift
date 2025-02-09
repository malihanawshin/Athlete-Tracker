//
//  MotionManager.swift
//  MotionTracker
//
//  Created by Maliha on 9/2/25.
//

import CoreMotion
import SwiftUI

class MotionManager: ObservableObject {
    private let motion = CMMotionManager()
    private var timer: Timer?
    private var startTime: Date?
    
    @Published var speed: Double = 0.0
    @Published var acceleration: Double = 0.0
    @Published var isTracking = false
    @Published var dataPoints: [DataPoint] = []
    
    struct DataPoint: Identifiable {
        let id = UUID()
        let time: Double
        let acceleration: Double
    }

    
    func startTracking() {
        guard motion.isDeviceMotionAvailable else { return }
        
        motion.deviceMotionUpdateInterval = 0.1
        motion.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: .main) { [weak self] data, error in
            guard let self = self, let data = data else { return }
            
            let userAcceleration = data.userAcceleration
            let a = sqrt(pow(userAcceleration.x, 2) + pow(userAcceleration.y, 2) + pow(userAcceleration.z, 2))
            let elapsed = self.startTime.map { Date().timeIntervalSince($0) } ?? 0.0
            
            DispatchQueue.main.async {
                self.acceleration = a
                
                if a > 0.02 { //ignore small noise
                    self.speed += a * 0.1 //update speed
                } else {
                    self.speed *= 0.98 //apply friction to slow down
                }
                
                self.dataPoints.append(DataPoint(time: elapsed, acceleration: a))
            }
        }
        
        startTime = Date()
        isTracking = true
    }
    
    func stopTracking() {
        motion.stopDeviceMotionUpdates()
        timer?.invalidate()
        isTracking = false
    }
}
