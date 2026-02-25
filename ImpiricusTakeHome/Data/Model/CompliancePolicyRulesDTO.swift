//
//  CompliancePolicyRulesDTO.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation

struct CompliancePolicyRulesDTO: Codable {
    let version: String
    let updated: String
    let rules: [CompliancePolicyRuleDTO]
    
    enum CodingKeys: String, CodingKey {
        case version
        case updated
        case rules
    }
}
