/*
//  StreakView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/9/26.
*/

import SwiftUI

struct StreakView: View {
    let startingDate = Date()
    
    var body: some View {
        HStack {
            ForEach(weekdayDates(startingDate), id: \.self) { date in
                VStack {
                    Text(date, format: .dateTime.weekday(.narrow))
                        .bold()
                        .foregroundStyle(weekdayFrom(date) == weekdayFrom(startingDate) ? .orange : .black)
                    
                    if date <= startingDate {
                        Image(systemName: isCompleted(date) ? "bolt" : "snowflake")
                            .symbolVariant(.fill)
                            .padding(14)
                            .foregroundStyle(.white)
                            .background(isCompleted(date) ? .black : .gray)
                            .clipShape(.circle)
                    } else {
                        Image(systemName: "circle")
                            .symbolVariant(.fill)
                            .padding(14)
                            .foregroundStyle(.secondary)
                            .background(.secondary)
                            .clipShape(.circle)
                    }
                }
            }
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
        
    
    func weekdayDates(_ startingDate: Date) -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: startingDate)
        let weekday = calendar.component(.weekday, from: today)
        
        let firstWeekdayIndex = calendar.firstWeekday
        let daysInAWeek = calendar.maximumRange(of: .weekday)?.count ?? 7
        
        let daysFromFirst = (daysInAWeek + weekday - firstWeekdayIndex) % daysInAWeek
        let firstDateOfWeek = calendar.date(byAdding: .day, value: -daysFromFirst, to: today)!
        return (0..<daysInAWeek).compactMap {
            calendar.date(byAdding: .day, value: $0, to: firstDateOfWeek)
        }
    }
    
    func isCompleted(_ date: Date) -> Bool {
        Calendar.current.component(.weekday, from: date).isMultiple(of: 2)
    }
    
    func weekdayFrom(_ date: Date) -> Int {
        Calendar.current.component(.weekday, from: date)
    }
}

#Preview {
    StreakView()
}
