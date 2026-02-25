//
//  CompliancePolicyRuleDTO.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation

struct CompliancePolicyRuleDTO: Codable {
    let id: String
    let name: String
    let keywordsAny: [String]
    let action: String?
    let requiresAppend: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case keywordsAny = "keywords_any"
        case action
        case requiresAppend = "requires_append"
    }
}
