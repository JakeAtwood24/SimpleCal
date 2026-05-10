/*
//  StartView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import SwiftUI

// Field Focus - For tracking the focus of what the keyboard is on
enum Field {
    case age
    case weight
    case feet
    case inches
}

struct StartView: View {
    // Setup Completion State - For first time input
    @AppStorage("hasCompletedSetup") private var hasCompletedSetup = false
    
    // Data Storage - Store all values recorded so the calorie count can stay the same
    @AppStorage("isMale") private var isMale: Bool = true
    @AppStorage("age") private var age: String = ""
    @AppStorage("weightLb") private var weightLb: String = ""
    @AppStorage("heightFt") private var heightFt: String = ""
    @AppStorage("heightIn") private var heightIn: String = ""
    @AppStorage("activityLevel") private var activityLevel: ActivityLevel = .sedentary
    @AppStorage("lossPace") private var lossPace: LossPace = .normalLoss

    // To store the total calorie amount once its calculated
    @AppStorage("dailyCaloriesTarget")
    private var dailyCaloriesTarget: Double = 2000
    
    // Keyboard Focus - Works with Field enum from above to track where keyboard is focused
    @FocusState private var focusedField: Field?

    // Parsed Values - casts the values from appstorage to Double (from String), and defaults to 0 if there is an issue.
    var ageValue: Double { Double(age) ?? 0 }
    var weightValue: Double { Double(weightLb) ?? 0 }
    var feetValue: Double { Double(heightFt) ?? 0 }
    var inchesValue: Double { Double(heightIn) ?? 0 }

    // Error Checking - Makes sure that the inputs are valid
    var inputsAreValid: Bool {
        ageValue > 0 && weightValue > 0 && feetValue > 0 && inchesValue >= 0
    }

    // dailyCalories Calculation - Uses CalorieCalcs file to actually calculate recommended daily calories
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
        // NOTE: This is my first time using NavigationStack, will do more research, but may not be properly utilized right now...
        NavigationStack {
            Form {
                // Personal Details Section
                VStack {
                    // HStack used to put male/female buttons side-by-side
                    HStack(spacing: 20) {
                        // Male Button
                        Button(action: { isMale = true }) {
                            VStack {
                                // "Male" SF symbols icon
                                Image(systemName: "figure.stand").font(Font.title.bold())
                                // "Male" subtext just in case
                                Text("Male").font(Font.subheadline)
                            }
                            .frame(maxWidth: .infinity) // Makes the button as wide as possible (so it's not just around the icon/text
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(isMale ? .blue : .gray.opacity(0.3)) // Blue if selected, light gray if not
                        
                        // Female Button
                        Button(action: { isMale = false }) {
                            VStack {
                                // "Female" SF symbols icon
                                Image(systemName: "figure.stand.dress").font(Font.title.bold())
                                // "Female" subtext just in case
                                Text("Female").font(Font.subheadline)
                            }
                            .frame(maxWidth: .infinity) // Makes the button as wide as possible (so it's not just around the icon/text
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(!isMale ? .pink.opacity(0.7) : .gray.opacity(0.3)) // Light pink if selected, light gray if not
                    }
                    .padding(.vertical, 5) // A little bit of padding for visual clarity
                    .listRowBackground(Color.clear)

                    // Input your age
                    AgePickerView(selection: $age).listRowBackground(Color.clear)
                        .padding(10)
                }

                // Body Measurements Section
                Section("Body Measurements") {
                    VStack(spacing: 20) {
                        // Weight Entry
                        HStack {
                            // Weight icon from SF symbols
                            Image(systemName:"scalemass")
                            
                            // Functionally a subtitle just in case
                            Text("Weight:")
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.secondary)
                            
                            // Spacer() here to push both sides to the very edge (visually nice)
                            Spacer()
                            
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                // The actual weight value input
                                TextField("0", text: $weightLb)
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .keyboardType(.decimalPad) // Use a decimal pad so they can only enter valid numbers
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 100)
                                    .focused($focusedField, equals: .weight)
                                
                                // Tiny "lbs" subtitle so the user knows the units of their input
                                Text("lbs")
                                    .font(.system(.subheadline, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding()

                        // Height Entry
                        HStack(spacing: 15) {
                            // Ruler icon to show height
                            Image(systemName:"ruler")
                            
                            // Height subtitle just in case
                            Text("Height:")
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.secondary)
                            
                            // Pushes the two portions to the edges for visual consistency
                            Spacer()
                            
                            // Feet Input
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                // The input for the foot measurement, defaults at 0
                                TextField("0", text: $heightFt)
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .keyboardType(.numberPad) // Use only numberPad so no decimals and no text
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 40)
                                    .focused($focusedField, equals: .feet)
                                
                                // Little "ft" to show the units they are inputting
                                Text("ft")
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.tertiary)
                            }
                            
                            // Inches Input
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                // Input for inches, also defaults to 0
                                TextField("0", text: $heightIn)
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .keyboardType(.numberPad) // Once again numberPad so no decimals or text
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 40)
                                    .focused($focusedField, equals: .inches)
                                
                                // Little "in" beside the input just to units are clear
                                Text("in")
                                    .font(.system(.caption, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .padding()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .background(Color(.white))
                    .listRowInsets(EdgeInsets()) // Removes the default Form padding
                    .listRowBackground(Color.clear) // Makes our custom backgrounds pop
                }

                // Lifestyle Section
                Section("Lifestyle & Goals") {
                    // Activity Level Select (1-5 Speed)
                    VStack(alignment: .leading) {
                        Text("Activity Level")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        BarSelectView(
                            selection: $activityLevel,
                            options: ActivityLevel.allCases,
                            icons: ["figure.seated.side.right", "figure.walk", "figure.run", "figure.outdoor.cycle", "figure.highintensity.intervaltraining"],
                            labels: nil
                        )
                        
                        // Put description below, images alone don't communicate fully here
                        Text(activityLevel.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                    .padding(.vertical, 8)

                    // Goal Pace Select (Turtle to Hare)
                    VStack(alignment: .leading) {
                        Text("Weight Loss Goal")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        BarSelectView(
                            selection: $lossPace,
                            options: LossPace.allCases,
                            icons: ["tortoise.fill", "tortoise", "hare", "hare.fill"],
                            labels: nil
                        )
                        
                        // Descriptions, would be unsafe without them, need the user to know how much weight they will be losing
                        Text(lossPace.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                    .padding(.vertical, 8)
                }

                // Daily Calorie Target Section
                Section {
                    VStack(spacing: 10) {
                        Text("Daily Calorie Target")
                            .font(.headline)

                        if inputsAreValid {
                            // Display the estimated daily calorie goal here
                            Text("\(dailyCalories)")
                                .font(.system(size: 42, weight: .bold))
                            // Units just for the users information
                            Text("kcal/day")
                                .foregroundColor(.secondary)
                        // If input is bad or nothing is in, give message to make that clear
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
                    // Save calculated calories
                    dailyCaloriesTarget = Double(dailyCalories)

                    withAnimation {
                        hasCompletedSetup = true // Once this is changed to true, it will instantly transition to HomeView (as you start from RootView)
                    }
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Profile Setup") // The text at the top (WANT TO CHANGE, ITS A LITTLE UGLY)
        }
    }
}

#Preview {
    StartView()
}
