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
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                Section(header: HeaderView()) {
                    if let jobs = jobsModel.jobs {
                        ForEach(jobs) { job in
                            JobCard(job: job)
                        }
                    } else {
                        Text("No data available")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
        }
        .padding(.horizontal, 20)
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

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Job Listings")
                .font(.title2)
                .bold()
            Spacer()
        }
        .padding(.vertical, 10)
        .background(.white)
    }
}

struct JobCard: View {
    let job: JobModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(job.positionName ?? "Unknown Position")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(job.corporateName ?? "Unknown Company")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if let corporateLogo = job.corporateLogo, let url = URL(string: corporateLogo) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                    }
                }
            }
            
            HStack {
                if let salaryFrom = job.salaryFrom, let salaryTo = job.salaryTo {
                    Text("💰 Rp\(salaryFrom) - Rp\(salaryTo)")
                        .font(.footnote)
                        .foregroundColor(.green)
                }
                Spacer()
                if let postedDate = job.postedDate {
                    Text("📅 Posted: \(postedDate)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            if let descriptions = job.status {
                Text(descriptions)
                    .font(.body)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
            
            Button("Apply") {
                print("Apply")
            }
            .buttonStyle(PlainButtonStyle())
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(25)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.vertical, 5)
    }
}


#Preview {
    JobsView()
}
