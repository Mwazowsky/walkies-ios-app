//
//  FormData.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 02/05/24.
//

import Foundation
import SwiftUI

struct newFormData{
    var physicalDetails : PhysicalDetails
    var activityDetails : ActivityDetails
}

extension newFormData {
    struct PhysicalDetails {
        var age: String
        var weight: String
        var bpm: String
    }
    
    struct ActivityDetails{
        var distance: String
        var surfGrade: String
        var activityType: ActivityType
        var isOnTreadmill: Bool = false
    }
    
    static var empty : newFormData {
        let physicalDetails = newFormData.PhysicalDetails(age: "", weight: "", bpm: "")
        let activityDetails = newFormData.ActivityDetails(distance: "", surfGrade: "", activityType: newFormData.ActivityDetails.ActivityType.allCases.first ?? .running)
        
        return newFormData(physicalDetails: physicalDetails, activityDetails: activityDetails)
    }
}

extension newFormData.ActivityDetails {
    enum ActivityType: String, Identifiable, CaseIterable {
        var id: Self { self }
        case running
        case walking
        case jogging
        case hiking
    }
}

final class FormData: ObservableObject {
    @Published var newFormData : newFormData = .empty
}
