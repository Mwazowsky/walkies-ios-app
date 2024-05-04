//
//  HistoryDatePicker.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 03/05/24.
//

import SwiftUI

struct HistoryCardView: View {
    @State private var selectedDate = Date()
    
    @StateObject var vm = FormData()
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        GroupBox{
            HStack() {
                Spacer()
            }
            .padding(.top, 40)
            DisclosureGroup(
                content: { HistoryDatePicker(selectedDate: $selectedDate) },
                label: { HStack {
                    Text("History Date: ")
                        .fontWeight(.semibold)
                        .foregroundColor(.textSecondary)
                    Spacer()
                    Text("\(selectedDate, formatter: dateFormatter)")
                        .foregroundColor(.blue)
                } }
            )
            .padding(.bottom, 10)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    MainView()
}
