/*
//  AgePickerView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import SwiftUI

struct AgePickerView: View {
    @Binding var selection: String
    let range = 13...120
    private let itemWidth: CGFloat = 60
    
    @State private var scrollPosition: Int?

    var body: some View {
        GeometryReader { geometry in
            // Calculate padding so the center of the first/last item can reach the center of the screen
            let horizontalPadding = (geometry.size.width / 2) - (itemWidth / 2)
            
            VStack(spacing: 15) {
                Text("Selected Age: \(selection)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(range, id: \.self) { age in
                            VStack(spacing: 10) {
                                Text("\(age)")
                                    .font(.system(size: 28, weight: selection == "\(age)" ? .bold : .regular))
                                    .foregroundStyle(selection == "\(age)" ? .primary : .tertiary)
                                    .scaleEffect(selection == "\(age)" ? 1.2 : 1.0)
                                    .frame(width: itemWidth)
                                
                                Capsule()
                                    .frame(width: 3, height: selection == "\(age)" ? 30 : 15)
                                    .foregroundStyle(selection == "\(age)" ? .blue : .gray.opacity(0.5))
                            }
                            .tag(age)
                        }
                    }
                    .scrollTargetLayout() // This tells the behavior where the individual views are
                }
                // Use safeAreaPadding to push content to the center
                .safeAreaPadding(.horizontal, horizontalPadding)
                .scrollPosition(id: $scrollPosition, anchor: .center)
                .scrollTargetBehavior(.viewAligned)
                .onChange(of: scrollPosition) { _, newValue in
                    if let newValue {
                        selection = "\(newValue)"
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                }
            }
            .onAppear {
                if scrollPosition == nil {
                    scrollPosition = Int(selection) ?? 25
                }
            }
        }
        .frame(height: 120)
    }
}

#Preview {
    @Previewable @State var age = "25"
    return AgePickerView(selection: $age)
}
