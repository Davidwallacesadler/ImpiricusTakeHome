//
//  MessageRepository.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation

class MessageRepository {
    
    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime
        ]
        return formatter
    }()
    
    private let dataSource: MessageDataSource
    
    init(dataSource: MessageDataSource) {
        self.dataSource = dataSource
    }
    
    func getMessages() async -> [Message] {
        await dataSource
            .fetchMessages()
            .map { messageDTOToDomainObject(dto: $0) }
    }
    
    private func messageDTOToDomainObject(dto: MessageDTO) -> Message {
        var responseLatency: TimeInterval? = nil
        if let dtoLatency = dto.responseLatencySec {
            responseLatency = Double(dtoLatency)
        }
        
        return Message(
            id: Int(dto.id) ?? -1,
            physicianID: Int(dto.physicianID) ?? -1,
            channel: Message.Channel.from(name: dto.channel),
            direction: Message.Direction.from(name: dto.direction),
            timestamp: Self.isoFormatter.date(from: dto.timestamp) ?? Date(),
            messageText: dto.messageText,
            campaignID: dto.campaignID,
            topic: dto.topic,
            complianceTag: dto.complianceTag,
            sentiment: Message.Sentiment.from(name: dto.sentiment),
            deliveryStatus: Message.DeliveryStatus.from(name: dto.deliveryStatus),
            responseLatency: responseLatency
        )
    }
}
