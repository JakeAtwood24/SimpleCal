/*
//  WeightCalcs.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import Foundation

// Life questions for calculations
let isMale: Bool = true
let age: Double = 20
let activityLevel: ActivityLevel = .moderatelyActive
let lossPace: LossPace = .extremeLoss
// All of the necessary weight measurements and conversions
let weightLb: Double = 190.0
let weightKg: Double = weightLb / 2.2046
// All of the necessary height measurements and conversions
let heightFt: Double = 6.0 // Take feet of user
let heightIn: Double = 0.0 // Take inches of user
let heightCm: Double = ((heightFt * 12) + heightIn) * 2.54 // Convert the US height to global

// The user has to select how active they are (the more active, the more calories they burn, the more they can eat)
enum ActivityLevel {
    case sedentary
    case lightlyActive
    case moderatelyActive
    case heavilyActive
    case athletic
}

// The use will select what they want the pace of their weight loss to be
enum LossPace {
    case maintenanceLoss
    case mildLoss
    case normalLoss
    case extremeLoss
}

// First you have to calculate basal metabolic rate (BMR), which is calories needed to maintain current weight with no activity
func calculateBMR() -> Double {
    if isMale { // Male case
        // Men: (10 × weight in kg) + (6.25 × height in cm) - (5 × age in years) + 5
        return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5
    }
    else { // Non-male case
        // Women: (10 × weight in kg) + (6.25 × height in cm) - (5 × age in years) - 161
        return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161
    }
}

// TDEE is basically the BMR with the exercise you do added in.
func calculateTDEE() -> Double {
    let bmr = calculateBMR()
    
    switch activityLevel {
        case .sedentary:
            return bmr * 1.2
        case .lightlyActive:
            return bmr * 1.375
        case .moderatelyActive:
            return bmr * 1.55
        case .heavilyActive:
            return bmr * 1.725
        case .athletic:
            return bmr * 1.9
    }
}

// From the maintenance value found in the TDEE calculations, you can subtract base amounts to find deficit goal.
func calculateDailyCals() -> Double {
    let tdee = calculateTDEE()
    
    switch lossPace {
        case .maintenanceLoss:
            return tdee
        case .mildLoss:
            return tdee - 300
        case .normalLoss:
            return tdee - 500
        case .extremeLoss:
            return tdee - 1000
    }
}
