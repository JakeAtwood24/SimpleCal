/*
//  StreakView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/9/26.
*/

import SwiftUI

struct HomeBarView: View {
    @Binding var selectedTab: AppTab

    private let tabs: [(tab: AppTab, icon: String)] = [
        (.home,     "house.fill"),
        (.log,      "scroll.fill"),
        (.macros,   "chart.pie.fill"),
        (.settings, "gearshape.fill")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.tab) { item in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = item.tab
                    }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } label: {
                    Image(systemName: item.icon)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(selectedTab == item.tab ? .white : .white.opacity(0.4))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
            }
        }
        .background(Color.black)
        .clipShape(Capsule())
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

#Preview {
    @Previewable @State var tab: AppTab = .home
    HomeBarView(selectedTab: $tab)
}
