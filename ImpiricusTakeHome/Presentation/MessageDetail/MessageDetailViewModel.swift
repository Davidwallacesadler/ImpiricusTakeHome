//
//  MessageDetailViewModel.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation

@Observable
final class MessageDetailViewModel {
    
    let message: Message
    private let compliancePoliciesRepo: CompliancePoliciesRepository
    
    var isLoading: Bool = false
    var policyViolations: [PolicyViolation] = []
    
    init(
        message: Message,
        compliancePoliciesRepo: CompliancePoliciesRepository
    ) {
        self.message = message
        self.compliancePoliciesRepo = compliancePoliciesRepo
    }
    
    func onRunComplianceCheckButtonTapped() {
        Task {
            isLoading = true
            defer {
                isLoading = false
            }
            
            guard let policyRules = await compliancePoliciesRepo.getPolicyRules() else { return }
            
            var violations: [PolicyViolation] = []
            for rule in policyRules.rules {
                for keyword in rule.keywordsAny {
                    if message.messageText.contains(keyword) {
                        violations.append(
                            PolicyViolation(message: "Issue: message contains '\(keyword)'", rule: rule)
                        )
                    }
                }
            }
            
            self.policyViolations = violations
        }
    }
    
    struct PolicyViolation: Identifiable {
        let id: UUID = UUID()
        let message: String
        let rule: CompliancePolicyRuleDTO
    }
}
