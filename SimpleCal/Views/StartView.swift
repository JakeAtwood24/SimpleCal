/*
//  StartView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import SwiftUI

enum Field {
    case age
    case weight
    case feet
    case inches
}

struct StartView: View {
    // For first time input
    @AppStorage("hasCompletedSetup")
        private var hasCompletedSetup = false
    
    @AppStorage("isMale") private var isMale: Bool = true
    @AppStorage("age") private var age: String = ""
    @AppStorage("weightLb") private var weightLb: String = ""
    @AppStorage("heightFt") private var heightFt: String = ""
    @AppStorage("heightIn") private var heightIn: String = ""

    @State private var activityLevel: ActivityLevel = .sedentary
    @State private var lossPace: LossPace = .normalLoss

    // Keyboard Focus
    @FocusState private var focusedField: Field?

    // Parsed Values
    var ageValue: Double { Double(age) ?? 0 }
    var weightValue: Double { Double(weightLb) ?? 0 }
    var feetValue: Double { Double(heightFt) ?? 0 }
    var inchesValue: Double { Double(heightIn) ?? 0 }

    // Valide the values to make sure they are reasonable
    var inputsAreValid: Bool {
        ageValue > 0 &&
        weightValue > 0 &&
        feetValue > 0
    }

    // Calculate the daily calories recommended for their goal
    var dailyCalories: Int {
        CalorieCalculator.calculateCalories(
            isMale: isMale,
            age: ageValue,
            weightLb: weightValue,
            heightFt: feetValue,
            heightIn: inchesValue,
            activityLevel: activityLevel,
            lossPace: lossPace
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                // Personal Details Section
                Section("Personal Details") {
                    // Choose your gender
                    Picker("Gender", selection: $isMale) {
                        Text("Male").tag(true)
                        Text("Female").tag(false)
                    }
                    .pickerStyle(.segmented)

                    // Input your age
                    // NOTE: I want to change this from type to maybe a wheel picker??
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .age)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .weight
                        }
                }

                // Body Measurements Section
                Section("Body Measurements") {
                    // Current weight
                    TextField("Current Weight (lbs)", text: $weightLb)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .weight)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .feet
                        }

                    // Feet and inches side by side for height
                    HStack {
                        TextField("Feet", text: $heightFt)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .feet)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .inches
                            }

                        TextField("Inches", text: $heightIn)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .inches)
                            .submitLabel(.done)
                    }
                }

                // Lifestyle
                Section("Lifestyle & Goals") {

                    // Activity level of the user
                    Picker("Activity", selection: $activityLevel) {
                        ForEach(ActivityLevel.allCases) { level in
                            Text(level.rawValue)
                                .tag(level)
                        }
                    }
                    Text(activityLevel.description)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    // Goal loss per week
                    Picker("Goal", selection: $lossPace) {
                        ForEach(LossPace.allCases) { pace in
                            Text(pace.rawValue)
                                .tag(pace)
                        }
                    }
                }

                // Daily Calorie Target
                Section {
                    VStack(spacing: 10) {
                        Text("Daily Calorie Target")
                            .font(.headline)

                        // If there is nothing wrong
                        if inputsAreValid {
                            Text("\(dailyCalories)")
                                .font(.system(size: 42, weight: .bold))
                            Text("kcal/day")
                                .foregroundColor(.secondary)
                        // Error checking
                        } else {
                            Text("Enter your information")
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
                
                // Continue button
                Button {
                    withAnimation {
                        hasCompletedSetup = true
                    }
                } label: {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Profile Setup")
        }
    }
}

#Preview {
    StartView()
}
