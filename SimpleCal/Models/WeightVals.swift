/*
//  WeightVals.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import Foundation

// For how active they are
enum ActivityLevel: String, CaseIterable, Identifiable {
    // Each of the different activity cases
    case sedentary = "Sedentary"
    case lightlyActive = "Lightly Active"
    case moderatelyActive = "Moderately Active"
    case heavilyActive = "Heavily Active"
    case athletic = "Athletic"

    var id: String { rawValue }

    // Descriptions for each of the different activity options
    var description: String {
        switch self {
        case .sedentary:
            return "Little to no exercise"
        case .lightlyActive:
            return "Exercise 1–3 days/week"
        case .moderatelyActive:
            return "Exercise 3–5 days/week"
        case .heavilyActive:
            return "Hard exercise 6–7 days/week"
        case .athletic:
            return "Intense training or physical job"
        }
    }
}

// For how fast their goal is
enum LossPace: String, CaseIterable, Identifiable {
    // Each of the cases for how quick the weight loss should be
    case maintenanceLoss = "Maintenance"
    case mildLoss = "Mild (0.5 lbs/week)"
    case normalLoss = "Normal (1 lb/week)"
    case extremeLoss = "Extreme (2 lbs/week)"

    var id: String { rawValue }
    
    // Descriptions for each of the different goal speeds
    var description: String {
        switch self {
        case .maintenanceLoss:
            return "Maintenance"
        case .mildLoss:
            return "Mild (0.5 lbs/week)"
        case .normalLoss:
            return "Normal (1 lb/week)"
        case .extremeLoss:
            return "Extreme (2 lbs/week)"
        }
    }
}
