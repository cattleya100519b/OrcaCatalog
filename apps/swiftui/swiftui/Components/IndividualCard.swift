//
//  IndividualCard.swift
//  swiftui
//
//  Created by Shota Teranishi on 2026/09/07.
//

import SwiftUI

struct IndividualCard: View {
    let individual: Individual

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(.gray.opacity(0.15))
                .aspectRatio(4 / 3, contentMode: .fit)
                .overlay {
                    Text("Photo")
                        .foregroundStyle(.secondary)
                }

            VStack(alignment: .leading, spacing: 6) {
                Text(individual.name)
                    .font(.headline)

                Text(individual.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.2))
        }
    }
}

#Preview {
    IndividualCard(individual: individuals[0])
        .padding()
}
