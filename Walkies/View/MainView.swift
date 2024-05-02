//
//  MainView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 30/04/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("Estimate")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                    }
                }
            
            ResultView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Result")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                    }
                }
            
            HistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar.xaxis")
                        Text("History")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                    }
                }
        }
        .preferredColorScheme(.dark)
    }
}

// Function to get calories burned based on user input
// CaloriesBurned = [(Age * 0.2017) + (Weight * 0.09036) + (HeartRate * 0.6309) - 55.0969] * Time / 4.184 + (0.2 * MetersMin) + (0.9 * MetersMin * FractionalGrade) + 3.5

// Function to estimate the average time and meters per minute (m/min) from user input
//func estimateRunningSpeed(age: Int, weight: Double, heartRate: Int) -> Double? {
//    // Cooper Test equation parameters for men
//    let a: Double = 22.3511
//    let b: Double = -0.3113
//    let c: Double = 0.0055
//
//    // Estimate distance in meters based on age
//    let distance = a - (b * Double(age)) + (c * Double(age) * Double(age))
//
//    // Convert distance from meters to kilometers
//    let distanceKm = distance / 1000.0
//    let speedKmPerHour = distanceKm / 12.0
//    let speedMetersPerMinute = speedKmPerHour * 1000.0 / 60.0
//    return speedMetersPerMinute
//}
//
//// Example usage
//let age = 30
//let weight = 70.0 // in kilograms
//let heartRate = 160
//
//if let estimatedSpeed = estimateRunningSpeed(age: age, weight: weight, heartRate: heartRate) {
//    print("Estimated running speed: \(estimatedSpeed) meters per minute")
//} else {
//    print("Unable to estimate running speed.")
//}

