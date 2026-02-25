//
//  MessageRow.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import SwiftUI

struct MessageRow: View {
    
    let message: Message
    let physicianName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(physicianName ?? "Unknown Physician")
                    .font(.headline)
                
                Spacer()
                
                SentimentTag(sentiment: message.sentiment)
            }
            Text(message.topic)
                .font(.caption)

            Text(message.timestamp.formatted(date: .numeric, time: .standard))
                .font(.caption)
                .foregroundStyle(Color.gray)
        }
    }
}

// MARK: - Previews

#Preview {
    MessageRow(
        message: Message(
            id: 1,
            physicianID: 1,
            channel: .email,
            direction: .inbound,
            timestamp: Date(),
            messageText: "Hi there!",
            campaignID: "CMP-001",
            topic: "Refills",
            complianceTag: "CT-01",
            sentiment: .positve,
            deliveryStatus: .delivered,
            responseLatency: 0.0125
        ),
        physicianName: "Dave Sadler"
    )
}
