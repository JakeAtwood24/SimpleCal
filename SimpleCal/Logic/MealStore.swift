/*
//  MealStore.swift
//  SimpleCal
//  Created by Jake Atwood on 5/16/26.
*/

import Foundation
import Combine

class MealStore: ObservableObject {
    @Published var entries: [MealEntry] = []

    private let storageKey = "mealEntries"

    init() {
        load()
    }

    // Today's Data
    var todayEntries: [MealEntry] {
        let cal = Calendar.current
        return entries.filter { cal.isDateInToday($0.date) }
    }

    var todayCalories: Double {
        Double(todayEntries.reduce(0) { $0 + $1.calories })
    }

    // Entries grouped by MealType for today
    func todayEntries(for mealType: MealType) -> [MealEntry] {
        todayEntries.filter { $0.mealType == mealType }
    }

    func calories(for mealType: MealType) -> Int {
        todayEntries(for: mealType).reduce(0) { $0 + $1.calories }
    }

    // Streak Logic
    // Returns true if the given date had any logged meals
    func hasEntries(on date: Date) -> Bool {
        let cal = Calendar.current
        return entries.contains { cal.isDate($0.date, inSameDayAs: date) }
    }

    // CRUD
    func add(_ entry: MealEntry) {
        entries.append(entry)
        save()
    }

    func delete(_ entry: MealEntry) {
        entries.removeAll { $0.id == entry.id }
        save()
    }

    // Persistence
    private func save() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([MealEntry].self, from: data)
        else { return }
        entries = decoded
    }
}
