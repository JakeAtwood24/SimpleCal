/*
//  FoodMacros.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import Foundation

// Simple food model, has optionals in case other macros are desired
struct FoodItem: Identifiable {
    // Mandatory for the item
    let id = UUID()
    let name: String
    let calories: Int

    // Optional macros
    // Fats
    let fat: Double?
    let monounsaturatedFat: Double?
    let polyunsaturatedFat: Double?
    let saturatedFat: Double?
    let transFat: Double?

    // Chol + Sodium
    let cholesterol : Double?
    let sodium: Double?
    
    // Carbs
    let carbs: Double?
    let fiber: Double?
    let sugar: Double?
    
    // Protein
    let protein: Double?
   
    // Vitamins
    let vitaminA: Double?
    let vitaminC: Double?
    let vitaminB1: Double? // Thiamin
    let vitaminB2: Double? // Riboflavin
    let vitamineB3: Double? // Niacin
    let vitamineB9: Double? // Folate
    let vitamineB6: Double?
    let vitamineB12: Double?
    
    // Minerals
    let calcium: Double?
    let iron: Double?
    let magnesium: Double?
    let phosphorus: Double?
    let potassium: Double?
    let zinc: Double?
    
    // Other chemicals
    let caffeine: Double?
}

enum MealType: String, CaseIterable, Identifiable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snacks"

    var id: String { rawValue }
}
