//
//  ComplianceRepository.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

class CompliancePoliciesRepository {
    
    private let dataSource: CompliancePoliciesDataSource
    
    init(dataSource: CompliancePoliciesDataSource) {
        self.dataSource = dataSource
    }
    
    func getPolicyRules() async ->  CompliancePolicyRulesDTO? {
        await dataSource.fetchPolicyRules()
    }
}
