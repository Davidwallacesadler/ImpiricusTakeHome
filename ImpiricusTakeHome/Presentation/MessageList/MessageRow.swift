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

// MARK: - SubViews

private struct SentimentTag: View {
    
    let sentiment: Message.Sentiment
    
    private var tagColor: Color {
        switch sentiment {
        case .neutral:
            Color.gray
        case .positve:
            Color.green
        case .negative:
            Color.red
        case .unknown:
            Color.black
        }
    }
    
    private var displayText: String {
        switch sentiment {
        case .neutral:
            "Neutral"
        case .positve:
            "Positive"
        case .negative:
            "Negative"
        case .unknown(let name):
            "Unknown: \(name)"
        }
    }
    
    var body: some View {
        Text(displayText)
            .font(.caption)
            .foregroundStyle(Color.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tagColor.opacity(0.8), in: Capsule())
    }
}
