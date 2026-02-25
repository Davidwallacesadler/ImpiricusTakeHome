//
//  DateRangePickerScreen.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import SwiftUI

struct DateRangePickerScreen: View {
    
    @Binding var dateRange: DateInterval?
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            List {
                DatePicker("Start", selection: $startDate, displayedComponents: [.date])
                DatePicker("End", selection: $endDate, displayedComponents: [.date])
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    if startDate <= endDate {
                        dateRange = DateInterval(start: startDate, end: endDate)
                        dismiss()
                    }
                } label: {
                    Text("Select")
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue, in: RoundedRectangle(cornerRadius: 16))
                        .padding()
                }
            }
            .navigationTitle("Date Range")
        }
    }
}

// MARK: - Previews

#Preview {
    DateRangePickerScreen(dateRange: .constant(nil))
}
