/*
//  CalorieCalcs.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import Foundation

// Calculates the amount of calories they should consume per day for the values given, returns an int
// Taking in a lot of the values as doubles to simplify calculations
struct CalorieCalculator {
    static func calculateCalories(
        isMale: Bool,
        age: Double,
        weightLb: Double,
        heightFt: Double,
        heightIn: Double,
        activityLevel: ActivityLevel,
        lossPace: LossPace
    ) -> Int {

        // Convert to metric
        let kg = weightLb / 2.2046
        let cm = ((heightFt * 12) + heightIn) * 2.54

        // BMR (Calculated using the Harris-Benedict equation)
        var bmr = (10 * kg) + (6.25 * cm) - (5 * age)
        bmr += isMale ? 5 : -161 // The only difference if male/female

        // Activity multipliers
        let multipliers: [ActivityLevel: Double] = [
            .sedentary: 1.2,
            .lightlyActive: 1.375,
            .moderatelyActive: 1.55,
            .heavilyActive: 1.725,
            .athletic: 1.9
        ]

        // Weight-loss deficit preferences
        let deficits: [LossPace: Double] = [
            .maintenanceLoss: 0,
            .mildLoss: 300,
            .normalLoss: 500,
            .extremeLoss: 1000
        ]

        // Calculate TDEE values which is used to find daily calorie count by subtracting deficit value.
        let tdee = bmr * (multipliers[activityLevel] ?? 1.2) // Use ?? 1.2 just in case can't find value
        let result = tdee - (deficits[lossPace] ?? 0) // Use ?? 0 just in case can't find value

        let minimum = isMale ? 1500 : 1200 // Safe minimum calories (this is just so there is a safe limit for each gender)
        return max(Int(result), minimum) // Will either return that value or the value calculated for them-- whichever is safer (max)
    }
}
