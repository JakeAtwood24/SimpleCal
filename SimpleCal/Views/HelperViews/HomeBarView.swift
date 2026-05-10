/*
//  StreakView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/9/26.
*/

import SwiftUI

struct HomeBarView: View {
    var body: some View {
        HStack() {
                Image(systemName: "house.fill")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading:30, bottom: 20, trailing: 30))
                    .background(Color.black)
                    .clipShape(Capsule())
            
                Image(systemName: "scroll.fill")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading:30, bottom: 20, trailing: 30))
                    .background(Color.black)
                    .clipShape(Capsule())
            
                Image(systemName: "apple.meditate")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading:30, bottom: 20, trailing: 30))
                    .background(Color.black)
                    .clipShape(Capsule())
        
                Image(systemName: "point.forward.to.point.capsulepath.fill")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading:30, bottom: 20, trailing: 30))
                    .background(Color.black)
                    .clipShape(Capsule())
        }.background(Color.black).clipShape(Capsule())
        .padding()
    }
}

#Preview {
    HomeBarView()
}
