//
//  MessageDataSource.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation
import SwiftCSV

protocol MessageDataSource {
    func fetchMessages() async -> [MessageDTO]
}

// TODO: Real Implementation goes here...

// MARK: - Mock Implementation

class MockMessageDataSource: MessageDataSource {
    
    func fetchMessages() async -> [MessageDTO] {
        try? await Task.sleep(for: .seconds(2)) // Simulate hitting remote API
        if let fileURL = Bundle.main.url(forResource: "messages", withExtension: "csv") {
            do {
                let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                let messageCSV = try CSV<Named>(string: fileContents)
                
                print(messageCSV.rows.map { row in
                    csvToMessage(columnToRowData: row)
                })
                return messageCSV.rows.map { row in
                    csvToMessage(columnToRowData: row)
                }
            } catch {
                print("Error parsing messages")
            }
        } else {
            print("Failed to messages")
        }
        
        return []
    }
    
    private func csvToMessage(columnToRowData: [String: String]) -> MessageDTO {
        MessageDTO(
            id: columnToRowData["message_id"] ?? "-1",
            physicianID: columnToRowData["physician_id"] ?? "-1",
            channel: columnToRowData["channel"] ?? "",
            direction: columnToRowData["direction"] ?? "",
            timestamp: columnToRowData["timestamp"] ?? "",
            messageText: columnToRowData["message_text"] ?? "",
            campaignID: columnToRowData["campaign_id"] ?? "",
            topic: columnToRowData["topic"] ?? "",
            complianceTag: columnToRowData["compliance_tag"] ?? "",
            sentiment: columnToRowData["sentiment"] ?? "",
            deliveryStatus: columnToRowData["delivery_status"] ?? "",
            responseLatencySec: columnToRowData["response_latency_sec"]
        )
    }
}
