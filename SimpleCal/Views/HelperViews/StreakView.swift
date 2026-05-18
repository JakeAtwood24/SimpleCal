/*
//  StreakView.swift
//  SimpleCal
//  Created by Jake Atwood on 5/9/26.
*/

import SwiftUI

struct StreakView: View {
    @EnvironmentObject var mealStore: MealStore
    let today = Date()

    var body: some View {
        HStack {
            ForEach(weekdayDates(today), id: \.self) { date in
                VStack {
                    Text(date, format: .dateTime.weekday(.narrow))
                        .bold()
                        .foregroundStyle(Calendar.current.isDate(date, inSameDayAs: today) ? .orange : .black)

                    if date <= today {
                        let logged = mealStore.hasEntries(on: date)
                        Image(systemName: logged ? "bolt.fill" : "snowflake.fill")
                            .padding(14)
                            .foregroundStyle(.white)
                            .background(logged ? Color.black : Color.gray)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "circle.fill")
                            .padding(14)
                            .foregroundStyle(.secondary)
                            .background(Color.secondary.opacity(0.3))
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(.vertical, 10)
    }

    func weekdayDates(_ from: Date) -> [Date] {
        let cal = Calendar.current
        let today = cal.startOfDay(for: from)
        let weekday = cal.component(.weekday, from: today)
        let daysFromFirst = (7 + weekday - cal.firstWeekday) % 7
        let firstOfWeek = cal.date(byAdding: .day, value: -daysFromFirst, to: today)!
        return (0..<7).compactMap { cal.date(byAdding: .day, value: $0, to: firstOfWeek) }
    }
}

#Preview {
    StreakView().environmentObject(MealStore())
}
