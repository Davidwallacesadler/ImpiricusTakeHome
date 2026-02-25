//
//  Physician.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

struct Physician: Identifiable {
    let id: Int
    let npi: Int
    let firstName: String
    let lastName: String
    let speciality: String
    let state: String
    let hasConcentedToOptIn: Bool
    let preferredChannel: String
}
