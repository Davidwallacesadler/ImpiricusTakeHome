//
//  MessageListViewModel.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import Foundation

@Observable
final class MessageListViewModel {
    private let messagesRepo: MessageRepository
    private let physicianRepo: PhysicianRepository
    
    var messages: [Message] = []
    
    var physicians: [Physician] = []
    
    private(set) var physicianIDToPhysicianName: [Int: String] = [:]
    
    var filterPhysician: Physician? = nil
    var filterDateRange: DateInterval? = nil
    
    var displayMessages: [Message] {
        messages.filter {
            let includesPhysician: Bool
            if let filterPhysician {
                includesPhysician = $0.physicianID == filterPhysician.id
            } else {
                includesPhysician = true
            }
            
            let includesDate: Bool
            if let filterDateRange {
                includesDate = filterDateRange.contains($0.timestamp)
            } else {
                includesDate = true
            }
            
            return includesPhysician && includesDate
        }
    }
    
    var displayFilterRange: String? {
        guard let filterDateRange else {
            return nil
        }
        return "\(filterDateRange.start.formatted(date: .numeric, time: .omitted)) - \(filterDateRange.end.formatted(date: .numeric, time: .omitted))"
    }
    
    var isLoading: Bool = false
    var sheetType: SheetType? = nil
    
    init(messagesRepo: MessageRepository, physicianRepo: PhysicianRepository) {
        self.messagesRepo = messagesRepo
        self.physicianRepo = physicianRepo
    }
    
    func fetchAllData() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        messages = await messagesRepo.getMessages()
        physicians = await physicianRepo.getPhysicians()
        physicianIDToPhysicianName = physicians.reduce(into: [Int: String]()) { partialResult, phys in
            partialResult[phys.id] = phys.name
        }
    }
    
    func onPhysicianFilterButtonTapped() {
        sheetType = .physicianSelect
    }
    
    func onPhysicianFilterClearButtonTapped() {
        filterPhysician = nil
    }
    
    func onDateRangeFilterButtonTapped() {
        sheetType = .dateRangeSelect
    }
    
    func onDateRangeClearButtonTapped() {
        filterDateRange = nil
    }
    
    enum SheetType: Identifiable {
        case physicianSelect
        case dateRangeSelect
        
        var id: String {
            switch self {
            case .physicianSelect:
                "Phys-Select"
            case .dateRangeSelect:
                "DateRange-Select"
            }
        }
    }
}
