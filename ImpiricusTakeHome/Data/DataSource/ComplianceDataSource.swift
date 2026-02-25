//
//  ComplianceDataSource.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation

protocol CompliancePoliciesDataSource {
    func fetchPolicyRules() async -> CompliancePolicyRulesDTO?
}

// TODO: Real Implementation goes here...

// MARK: - Mock Implementation

class MockCompliancePoliciesDataSource: CompliancePoliciesDataSource {
    
    func fetchPolicyRules() async -> CompliancePolicyRulesDTO? {
        try? await Task.sleep(for: .seconds(2)) // Simulate hitting remote API
        if let fileURL = Bundle.main.url(forResource: "compliance_policies", withExtension: "json") {
            do {
                let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                let decoder = JSONDecoder()
                if let jsonData = fileContents.data(using: .utf8) {
                    return try decoder.decode(CompliancePolicyRulesDTO.self, from: jsonData)
                }
            } catch {
                print("Error parsing policies")
            }
        } else {
            print("Failed to find policy rules")
        }
        
        return nil
    }
}

