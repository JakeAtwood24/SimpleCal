/*
//  HomeView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import SwiftUI

// WILL ADD TO THIS NEXT METHINKS
struct HomeView: View {
    var body: some View {
        var totalCalories: Double = 1460 // Will be updated using the add meal things (it wants it to be a let so bad rn but it will be changed)
        
        // NOTE: This is my first time using NavigationStack, will do more research, but may not be properly utilized right now...
        NavigationStack {
            Spacer()
            
            StreakView() // Taken from previous app I worked on, will update to fit the calorie tracker idea better (In this case, I want to have it be red if you miss a day, orange if you go over, and green or smth if you get a day right [so there are three cases to motiviate both logging on the app and staying under calorie limit])
            
            CalorieWheelView(consumedCalories: Double(totalCalories))
                .frame(maxWidth: .infinity)
            
            Spacer() // This will be replaced by the meal logging section etc.
            
            HomeBarView() // Taken from previous app I worked on, will update to fit the calorie tracker idea better (Perhaps a weight tracking feature on the right, daily meal logging view, and the macro view)
        }
    }
}

#Preview {
    HomeView()
}
