/*
//  BarSelectView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import SwiftUI

struct BarSelectView<T: Hashable & CaseIterable>: View {
    @Binding var selection: T
    let options: [T]
    let icons: [String]?
    let labels: [String]?
    
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                // We use a Text/Image inside an .onTapGesture instead of a standard Button
                // sometimes standard Buttons in a Form try to take over the whole row.
                VStack {
                    if let icons = icons {
                        Image(systemName: icons[index])
                    } else if let labels = labels {
                        Text(labels[index])
                    }
                }
                .font(.system(size: 18, weight: .medium))
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                // Use .contentShape to make the whole area tappable
                .contentShape(Rectangle())
                .foregroundStyle(selection == option ? .white : .primary)
                .background {
                    if selection == option {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                            // ID must be unique to this specific bar instance
                            .matchedGeometryEffect(id: "segment", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selection = option
                    }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
        .padding(4)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    // Created a dummy state variable for the preview to control
    @Previewable @State var mockSelection: ActivityLevel = .sedentary
    
    // Then passed the required data into the view
    BarSelectView(
        selection: $mockSelection,
        options: ActivityLevel.allCases,
        icons: ["chair.fill", "figure.walk", "figure.run", "figure.outdoor.cycle", "figure.highintensity.intervaltraining"],
        labels: nil
    )
    .padding() // Gave it some room to breathe in the preview
}
