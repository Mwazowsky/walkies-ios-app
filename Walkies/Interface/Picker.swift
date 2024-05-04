//
//  Picker.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 30/04/24.
//

import Foundation
import SwiftUI



struct PickerView: View {
    @ObservedObject var vm: FormData
    
    var body: some View {
        Picker("", selection: $vm.newFormData.activityDetails.activityType) {
            ForEach(newFormData.ActivityDetails.ActivityType.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .navigationTitle("Select Activity Type")
    }
}

struct HistoryDatePicker: View {
    @Binding var selectedDate: Date
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 30)
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        VStack {
            DatePicker(
                "Pick a date",
                selection: $selectedDate,
                in: dateRange,
                displayedComponents: [.date])
                .padding()
                .datePickerStyle(.wheel)
            
            Text("Selected Date: \(formattedDate)")
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
}

