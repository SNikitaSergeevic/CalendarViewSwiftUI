//
//  ContentView.swift
//  CalendarSwiftUI
//
//  Created by ProstoKakTo on 06.02.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.calendar) var calendar
    
    var body: some View {
        VStack {
            
           
            CalendarView(interval: .init(start: Date(), duration: 2592000)) { day, month in
                if calendar.isDate(day, equalTo: month, toGranularity: .month) {
                    Text("\(day.get(.day))")
                        .frame(width: 22, height: 22, alignment: .center)
                        .padding(8)
                        .background(Color.green.opacity(0.4))
                        .cornerRadius(20)
                } else {
                    Text("\(day.get(.day))")
                        .frame(width: 22, height: 22, alignment: .center)
                        .foregroundColor(Color.gray)
                        .padding(8)
                        .cornerRadius(20)
                }
            }
                
                
                
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }

