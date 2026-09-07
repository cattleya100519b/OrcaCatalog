//
//  IndividualDetailView.swift
//  swiftui
//
//  Created by Shota Teranishi on 2026/09/07.
//

import SwiftUI

struct IndividualDetailView: View {
    let individual: Individual

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Rectangle()
                    .fill(.gray.opacity(0.15))
                    .aspectRatio(4 / 3, contentMode: .fit)
                    .overlay {
                        Text("Photo")
                            .foregroundStyle(.secondary)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Individual")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)

                    Text(individual.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                VStack(spacing: 0) {
                    InfoRow(label: "識別番号", value: individual.id)
                    InfoRow(label: "性別", value: "Unknown")
                    InfoRow(label: "ステータス", value: "Known individual")
                }
            }
            .padding(24)
            .frame(maxWidth: 700)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("個体詳細")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
        }
        .padding(.vertical, 14)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
}

#Preview {
    NavigationStack {
        IndividualDetailView(individual: individuals[0])
    }
}
