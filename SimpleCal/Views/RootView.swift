/*
//  RootView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/7/26.
*/

import SwiftUI

struct RootView: View {
    // So it doesn't open to setup every time you open
    @AppStorage("hasCompletedSetup")
    private var hasCompletedSetup = false

    // To decide what screen to go to
    var body: some View {
        // HomeView if setup is done
        if hasCompletedSetup {
            HomeView()
        // StartView if not
        } else {
            StartView()
        }
    }
}

#Preview {
    RootView()
}
