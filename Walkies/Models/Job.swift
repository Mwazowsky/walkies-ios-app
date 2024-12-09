//
//  ApiModels.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 09/12/24.
//

import Foundation

struct WrapperModel: Codable {
    let jobs: [JobModel]
}

struct JobModel: Codable, Identifiable {
    let jobVacancyCode: String?
    let positionName: String?
    let corporateId: String?
    let corporateName: String?
    let status: String?
    let descriptions: String?
    let corporateLogo: String?
    let applied: String?
    let salaryFrom: Int?
    let salaryTo: Int?
    let postedDate: String?

    // Conforming to Identifiable protocol
    var id: String? { jobVacancyCode }

    enum CodingKeys: String, CodingKey {
        case jobVacancyCode
        case positionName
        case corporateId
        case corporateName
        case status
        case descriptions
        case corporateLogo
        case applied
        case salaryFrom
        case salaryTo
        case postedDate
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobVacancyCode = try values.decodeIfPresent(String.self, forKey: .jobVacancyCode)
        positionName = try values.decodeIfPresent(String.self, forKey: .positionName)
        corporateId = try values.decodeIfPresent(String.self, forKey: .corporateId)
        corporateName = try values.decodeIfPresent(String.self, forKey: .corporateName)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        descriptions = try values.decodeIfPresent(String.self, forKey: .descriptions)
        corporateLogo = try values.decodeIfPresent(String.self, forKey: .corporateLogo)
        applied = try values.decodeIfPresent(String.self, forKey: .applied)
        salaryFrom = try values.decodeIfPresent(Int.self, forKey: .salaryFrom)
        salaryTo = try values.decodeIfPresent(Int.self, forKey: .salaryTo)
        postedDate = try values.decodeIfPresent(String.self, forKey: .postedDate)
    }
}
