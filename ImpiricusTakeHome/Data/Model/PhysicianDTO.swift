//
//  PhysicianDTO.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

struct PhysicianDTO: Codable {
    let id: String
    let npi: String
    let firstName: String
    let lastName: String
    let speciality: String
    let state: String
    let hasConcentedToOptIn: String
    let preferredChannel: String
}
