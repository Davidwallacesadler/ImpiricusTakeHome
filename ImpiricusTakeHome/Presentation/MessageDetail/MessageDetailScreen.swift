//
//  MessageDetailScreen.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import SwiftUI

struct MessageDetailScreen: View {

    @State private var viewModel: MessageDetailViewModel
    
    init(message: Message) {
        _viewModel = State(initialValue: MessageDetailViewModel(
            message: message,
            compliancePoliciesRepo: CompliancePoliciesRepository(dataSource: MockCompliancePoliciesDataSource()))
        )
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    SentimentTag(sentiment: viewModel.message.sentiment)
                    Text(viewModel.message.messageText)
                        .font(.subheadline)
                }
            } header: {
                Text("Message Details")
                    .font(.headline)
            }
            
            Section {
                Text(viewModel.message.complianceTag)
                    .font(.subheadline)
            } header: {
                Text("Compliance Tag")
                    .font(.headline)
            }
            
            Section {
                if viewModel.policyViolations.isEmpty {
                    Text("No Violations Found")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                } else {
                    ForEach(viewModel.policyViolations) { violation in
                        HStack {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.headline)
                                .foregroundStyle(Color.red)
                            
                            VStack(alignment: .leading) {
                                Text("\(violation.rule.name)")
                                    .font(.headline)
                                    .foregroundStyle(Color.red)
                                    
                                Text(violation.message)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            } header: {
                Text("Policy Violations")
                    .font(.headline)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                viewModel.onRunComplianceCheckButtonTapped()
            } label: {
                Text(viewModel.isLoading ? "Running Compliance Check..." : "Run Compliance Check")
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isLoading ? Color.gray : Color.blue, in: RoundedRectangle(cornerRadius: 16))
                    .padding()
                    .disabled(viewModel.isLoading)
            }
        }
        .navigationTitle(viewModel.message.topic)
    }
}
