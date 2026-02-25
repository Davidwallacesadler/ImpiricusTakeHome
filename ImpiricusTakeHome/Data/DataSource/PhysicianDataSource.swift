//
//  PhysicianDataSource.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation
import SwiftCSV

protocol PhysicianDataSource {
    func fetchPhysicians() async -> [PhysicianDTO]
}

// TODO: Real Implementation goes here...

// MARK: - Mock Implementation

class MockPhysicianDataSource: PhysicianDataSource {
    
    func fetchPhysicians() async -> [PhysicianDTO] {
        try? await Task.sleep(for: .seconds(2)) // Simulate hitting remote API
        if let fileURL = Bundle.main.url(forResource: "physicians", withExtension: "csv") {
            do {
                let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                let messageCSV = try CSV<Named>(string: fileContents)
                
                return messageCSV.rows.map { row in
                    csvToPhysician(columnToRowData: row)
                }
            } catch {
                print("Error parsing messages")
            }
        } else {
            print("Failed to messages")
        }
        
        return []
    }
    
    private func csvToPhysician(columnToRowData: [String: String]) -> PhysicianDTO {
        PhysicianDTO(
            id: columnToRowData["physician_id"] ?? "-1",
            npi: columnToRowData["npi"] ?? "-1",
            firstName: columnToRowData["first_name"] ?? "",
            lastName: columnToRowData["last_name"] ?? "",
            speciality: columnToRowData["specialty"] ?? "",
            state: columnToRowData["state"] ?? "",
            hasConcentedToOptIn: columnToRowData["consent_opt_in"] ?? "",
            preferredChannel: columnToRowData["preferred_channel"] ?? ""
        )
    }
}
