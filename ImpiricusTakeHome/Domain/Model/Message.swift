//
//  Message.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation

struct Message: Identifiable {
    let id: Int
    let physicianID: Int
    let channel: Channel
    let direction: Direction
    let timestamp: Date
    let messageText: String
    let campaignID: String
    let topic: String
    let complianceTag: String
    let sentiment: Sentiment
    let deliveryStatus: DeliveryStatus
    let responseLatency: TimeInterval?
    
    enum Channel {
        case email
        case sms
        case voice
        case unknown(name: String)
        
        static func from(name: String) -> Self {
            switch name {
            case "email":
                .email
            case "sms":
                .sms
            case "voice":
                .voice
            default:
                .unknown(name: name)
            }
        }
    }
    
    enum Direction {
        case outbound
        case inbound
        case unknown(name: String)
        
        static func from(name: String) -> Self {
            switch name {
            case "outbound":
                .outbound
            case "inbound":
                .inbound
            default:
                .unknown(name: name)
            }
        }
    }
    
    enum DeliveryStatus {
        case delivered
        case failed
        case bounced
        case unknown(name: String)
        
        static func from(name: String) -> Self {
            switch name {
            case "delivered":
                .delivered
            case "failed":
                .failed
            case "bounced":
                .bounced
            default:
                .unknown(name: name)
            }
        }
    }
    
    enum Sentiment {
        case neutral
        case positve
        case negative
        case unknown(name: String)
        
        static func from(name: String) -> Self {
            switch name {
            case "neutral":
                .neutral
            case "positive":
                .positve
            case "negative":
                .negative
            default:
                .unknown(name: name)
            }
        }
    }
}
