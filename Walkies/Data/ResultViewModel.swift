//
//  ResultViewModel.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 04/05/24.
//

import Foundation

struct newResult{
    var results : ResultDetails
}

extension newResult {
    struct ResultDetails {
        var calories: String
        var steps: String
        var time: String
        var heart: String
    }
    
    static var empty : newResult {
        let resultDetails = newResult.ResultDetails(calories: "", steps: "", time: "", heart: "")
        
        return newResult(results: resultDetails)
    }
}

final class ResultData : ObservableObject {
    @Published private var result: newResult = .empty
    @Published private(set) var userInputs: FormData
    
    init(_userInputs: FormData) {
        self.userInputs = _userInputs
    }
    
    func saveInputs(_ newInputs: FormData) {
        userInputs = newInputs
    }
}
