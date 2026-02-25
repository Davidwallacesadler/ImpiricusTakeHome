//
//  MessageDTO.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

struct MessageDTO: Codable {
    let id: String
    let physicianID: String
    let channel: String
    let direction: String
    let timestamp: String // NOTE: iso-8601
    let messageText: String
    let campaignID: String
    let topic: String
    let complianceTag: String
    let sentiment: String
    let deliveryStatus: String
    let responseLatencySec: String?
}
