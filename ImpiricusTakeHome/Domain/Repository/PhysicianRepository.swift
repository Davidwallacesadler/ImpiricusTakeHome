//
//  PhysicianRepository.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

class PhysicianRepository {
    
    private let dataSource: PhysicianDataSource
    
    init(dataSource: PhysicianDataSource) {
        self.dataSource = dataSource
    }
    
    func getPhysicians() async -> [Physician] {
        await dataSource
            .fetchPhysicians()
            .map { physicianDTOToDomainObject(dto: $0) }
    }
    
    private func physicianDTOToDomainObject(dto: PhysicianDTO) -> Physician {
        Physician(
            id: Int(dto.id) ?? -1,
            npi: Int(dto.npi) ?? -1,
            firstName: dto.firstName,
            lastName: dto.lastName,
            speciality: dto.speciality,
            state: dto.state,
            hasConcentedToOptIn: dto.hasConcentedToOptIn == "True",
            preferredChannel: dto.preferredChannel
        )
    }
}
