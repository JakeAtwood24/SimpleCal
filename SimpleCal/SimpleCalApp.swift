//
//  SimpleCalApp.swift
//  SimpleCal
//
//  Created by Jake Atwood on 5/7/26.
//

import SwiftUI

@main
struct SimpleCalApp: App {
    @StateObject private var mealStore = MealStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(mealStore)
        }
    }
}
