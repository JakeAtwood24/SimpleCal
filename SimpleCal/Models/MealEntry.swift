/*
//  MealEntry.swift
//  SimpleCal
//  Created by Jake Atwood on 5/16/26.
*/

import Foundation

struct MealEntry: Identifiable, Codable {
    let id: UUID
    let name: String
    let calories: Int
    let mealType: MealType
    let date: Date

    init(name: String, calories: Int, mealType: MealType, date: Date = .now) {
        self.id = UUID()
        self.name = name
        self.calories = calories
        self.mealType = mealType
        self.date = date
    }
}
