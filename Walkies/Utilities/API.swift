//
//  API.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 09/12/24.
//

import Foundation

struct API {
    func apiCaller() async throws -> [JobModel] {
        let url = URL(string: "https://test-server-klob.onrender.com/fakeJob/apple/academy")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let jobs = try JSONDecoder().decode([JobModel].self, from: data)
            return jobs
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw error
        }
    }
}
