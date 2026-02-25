//
//  PhysicianPickerScreen.swift
//  ImpiricusTakeHome
//
//  Created by David Sadler on 2/25/26.
//

import SwiftUI

struct PhysicianPickerScreen: View {
    
    let physicians: [Physician]
    @Binding var selection: Physician?
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        NavigationStack {
            List(physicians) { phys in
                Button {
                    selection = phys
                    dismiss()
                } label: {
                    HStack {
                        Text(phys.name)
                            .foregroundStyle(Color.primary)
                        
                        Spacer()
                        
                        if phys.id == selection?.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(Color.blue)
                        }
                    }
                    .font(.headline)
                }
            }
            .navigationTitle("Physicians")
        }
    }
}

// MARK: - Previews

#Preview {
    PhysicianPickerScreen(
        physicians: [
            Physician(
                id: 1,
                npi: 1,
                firstName: "Dave",
                lastName: "Sadler",
                speciality: "iOS Dev",
                state: "UT",
                hasConcentedToOptIn: false,
                preferredChannel: "sms"
            )
        ],
        selection: .constant(nil)
    )
}
