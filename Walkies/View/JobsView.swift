//
//  JobsView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 09/12/24.
//

import SwiftUI

private class JobsViewModel: ObservableObject {
    @Published var jobs: [JobModel]? = nil
}

struct JobsView: View {
    @StateObject fileprivate var jobsModel = JobsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let jobs = jobsModel.jobs {
                List(jobs) { job in
                    Text("\(String(describing: job.positionName)) by \(String(describing: job.corporateName))")
                }
            } else {
                Text("No data available")
            }
        }
        .padding(20.0)
        .task {
            do {
                let api = API()
                jobsModel.jobs = try await api.apiCaller()
            } catch {
                jobsModel.jobs = nil
                print("Error fetching jobs: \(error)")
            }
        }
    }
}

