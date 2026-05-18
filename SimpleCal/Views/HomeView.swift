/*
//  HomeView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

//  HomeView.swift
//  SimpleCal

import SwiftUI

enum AppTab { case home, log, macros, settings }

struct HomeView: View {
    @EnvironmentObject var mealStore: MealStore
    @State private var selectedTab: AppTab = .home // Selects what part of the home bar you're on
    @State private var showingAddMeal = false

    var body: some View {
        NavigationStack { // This is used to navigate the views
            VStack(spacing: 0) {
                // Content area switches on tab
                switch selectedTab {
                case .home:
                    homeContent
                case .log:
                    logContent
                case .macros:
                    macrosContent
                case .settings:
                    settingsContent
                }

                Spacer()

                // Bottom bar
                HomeBarView(selectedTab: $selectedTab) // Keep the home bar no matter what page is up
                
                Spacer()
            }
            .sheet(isPresented: $showingAddMeal) {
                AddMealView().environmentObject(mealStore)
            }
            .toolbar {
                // "+" button in nav bar to log a meal from any tab
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddMeal = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
        }
    }

    // Home tab
    private var homeContent: some View {
        ScrollView {
            VStack(spacing: 16) {
                StreakView() // The streak view at the top of the home page

                CalorieWheelView(consumedCalories: mealStore.todayCalories) // Consumed calories wheel
                    .frame(maxWidth: .infinity)

                // Quick meal breakdown by type
                if !mealStore.todayEntries.isEmpty {
                    mealSummaryCard
                }
            }
            .padding(.bottom, 100) // Clear the tab bar
        }
    }

    private var mealSummaryCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today").font(.headline).padding(.horizontal)

            ForEach(MealType.allCases) { type in
                let cals = mealStore.calories(for: type)
                if cals > 0 {
                    HStack {
                        Text(type.rawValue).foregroundStyle(.secondary)
                        Spacer()
                        Text("\(cals) kcal").fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.vertical, 12)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }

    // Log
    private var logContent: some View {
        List {
            ForEach(MealType.allCases) { type in
                let entries = mealStore.todayEntries(for: type)
                if !entries.isEmpty {
                    Section(type.rawValue) {
                        ForEach(entries) { entry in
                            HStack {
                                Text(entry.name)
                                Spacer()
                                Text("\(entry.calories) kcal")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onDelete { indexSet in
                            let toDelete = indexSet.map { entries[$0] }
                            toDelete.forEach { mealStore.delete($0) }
                        }
                    }
                }
            }

            if mealStore.todayEntries.isEmpty {
                ContentUnavailableView(
                    "No meals logged",
                    systemImage: "fork.knife",
                    description: Text("Tap + to log your first meal")
                )
            }
        }
        .listStyle(.insetGrouped)
    }

    // Macros (placeholder)
    private var macrosContent: some View {
        ContentUnavailableView(
            "Macros coming soon",
            systemImage: "chart.pie",
            description: Text("Protein, carbs, and fat breakdown will live here")
        )
    }

    // Settings (placeholder)
    private var settingsContent: some View {
        ContentUnavailableView(
            "Settings",
            systemImage: "gearshape",
            description: Text("Profile editing will live here")
        )
    }
}

#Preview {
    HomeView().environmentObject(MealStore())
}
