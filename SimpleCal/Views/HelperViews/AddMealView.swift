/*
//  AddMealView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/16/26.
*/

import SwiftUI

struct AddMealView: View {
    @EnvironmentObject var mealStore: MealStore
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var caloriesText: String = ""
    @State private var selectedMealType: MealType = .breakfast
    @FocusState private var focusedField: AddMealField?

    enum AddMealField { case name, calories }

    private var calories: Int { Int(caloriesText) ?? 0 }
    private var isValid: Bool { !name.isEmpty && calories > 0 }

    var body: some View {
        NavigationStack {
            Form {
                Section("Food Details") {
                    TextField("Food name", text: $name)
                        .focused($focusedField, equals: .name)

                    HStack {
                        TextField("Calories", text: $caloriesText)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .calories)
                        Text("kcal")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Meal") {
                    Picker("Meal type", selection: $selectedMealType) {
                        ForEach(MealType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Preview the entry before saving
                if isValid {
                    Section {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(name).font(.headline)
                                Text(selectedMealType.rawValue).font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(calories) kcal").font(.headline)
                        }
                    } header: {
                        Text("Preview")
                    }
                }
            }
            .navigationTitle("Log Meal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        mealStore.add(MealEntry(
                            name: name,
                            calories: calories,
                            mealType: selectedMealType
                        ))
                        dismiss()
                    }
                    .disabled(!isValid)
                }
            }
            .onAppear { focusedField = .name }
        }
    }
}

#Preview {
    AddMealView().environmentObject(MealStore())
}
