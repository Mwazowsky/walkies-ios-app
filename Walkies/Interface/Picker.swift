//
//  Picker.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 30/04/24.
//

import Foundation
import SwiftUI

enum ActivityType {
    case running
    case walking
    case jogging
    case hiking
}

struct PickerView: View {
    @Binding var activityType: ActivityType
    
    var body: some View {
        Picker("", selection: $activityType) {
            Text("Running").tag(ActivityType.running)
            Text("Walking").tag(ActivityType.walking)
            Text("Jogging").tag(ActivityType.jogging)
            Text("Hiking").tag(ActivityType.hiking)
        }
        .pickerStyle(WheelPickerStyle())
        .navigationTitle("Select Activity Type")
    }
}
