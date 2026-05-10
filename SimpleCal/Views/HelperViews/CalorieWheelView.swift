/*
//  CalorieWheelView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/10/26.
*/

import SwiftUI

struct CalorieWheelView: View {
    // The calories that have been consumed today
    var consumedCalories: Double

    // Access the app storage value calculated from StartView
    @AppStorage("dailyCaloriesTarget") private var dailyCaloriesTarget: Double = 2000

    // This is for the progress bar
    private var progress: Double {
        min(consumedCalories / dailyCaloriesTarget, 1.0)
    }

    // This is to show the amount of calories you have left below
    private var remainingCalories: Int {
        Int(dailyCaloriesTarget - consumedCalories)
    }

    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(
                    Color.gray.opacity(0.2),
                    lineWidth: 22
                )

            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        // The color gradient (will change to uniform color scheme eventually)
                        gradient: Gradient(colors: [
                            .blue,
                            .cyan,
                            .green
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(
                        lineWidth: 22,
                        lineCap: .round // The way line caps work means that there's a weird green bit at the beginning that I need to fix... will get to it eventually.
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)

            // Put the info inside and centered
            VStack(spacing: 8) {
                Text("\(Int(consumedCalories))")
                    .font(.system(size: 42, weight: .bold))

                Text("of \(Int(dailyCaloriesTarget)) kcal")  // Fixed: was totalCalories
                    .foregroundColor(.secondary)

                Divider()
                    .frame(width: 80)

                Text("\(remainingCalories)")
                    .font(.title2.bold())

                Text("remaining")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0)) // Moved the "remaining" text closer to the actual value
            }
        }
        .frame(width: 250, height: 250)
        .padding()
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.05)
            .ignoresSafeArea()

        CalorieWheelView(consumedCalories: 1450)
    }
}
