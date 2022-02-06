//
//  CalendarView.swift
//  CalendarSwiftUI
//
//  Created by ProstoKakTo on 06.02.2022.
//

import SwiftUI

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    
    var customCalendar = Calendar(identifier: .gregorian)
    
    
    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date, Date) -> DateView
    
    init(
        interval: DateInterval,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date, Date) -> DateView
    ) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }
    
    var body: some View {
        ScrollView ()  {
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                
                ForEach(months, id: \.self) { month in
                    
                    Section(header: header(for: month)) {
                        
                        ForEach(days(for: month), id: \.self) { date in
                            
                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                content(date, month).id(date)
                            } else {
                                content(date, month).id(date)
                            }
                            
                        }
                        
                    }
                    
                    
                }
                
                
            }
            .shadow(radius: 10)
            
               
        }
        .frame(height: 300, alignment: .center)
        
        
        
        
        
    }
    
    private var months: [Date] {
        //        customCalendar.firstWeekday = 2
        var customCalendar = calendar
        customCalendar.firstWeekday = 2
        return customCalendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    
    private func header(for month: Date) -> some View {
        var customCalendar = calendar
        customCalendar.firstWeekday = 2
        let component = customCalendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        
        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }
    
    private func days(for month: Date) -> [Date] {
        var customCalendar = calendar
        customCalendar.firstWeekday = 2
        guard
            let monthInterval = customCalendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = customCalendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = customCalendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return customCalendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(interval: .init(start: Date(), duration: 2592000)) { day, _ in
            Text("\(day.get(.day))")
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}
