//
//  ProcessInput.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 02/05/24.
//

import Foundation

struct ProcessInput {
    func estimateRunningSpeed(age: Int, weight: Double, heartRate: Int) -> Double? {
        // Cooper Test equation parameters for men
        let a: Double = 22.3511
        let b: Double = -0.3113
        let c: Double = 0.0055
        
        // Estimate distance in meters based on age
        let distance = a - (b * Double(age)) + (c * Double(age) * Double(age))
        
        // Convert distance from meters to kilometers
        let distanceKm = distance / 1000.0
        let speedKmPerHour = distanceKm / 12.0
        let speedMetersPerMinute = speedKmPerHour * 1000.0 / 60.0
        return speedMetersPerMinute * 1000
    }
    
    func calculateCaloriesBurned(age: Double, weight: Double, heartRate: Double, timeInMinutes: Double, metersPerMinute: Double, fractionalGrade: Double) -> Double {
        let caloriesFromResting = (age * 0.2017) + (weight * 0.09036) + (heartRate * 0.6309) - 55.0969
        let caloriesFromExercise = ((timeInMinutes / 4.184) * ((0.2 * metersPerMinute) + (0.9 * metersPerMinute * fractionalGrade) + 3.5))
        let totalCaloriesBurned = caloriesFromResting + caloriesFromExercise
        return totalCaloriesBurned
    }
}
