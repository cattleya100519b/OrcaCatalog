import SwiftUI

struct IndividualDetailView: View {
    let individual: Individual

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                AsyncImage(
                    url: URL(
                        string: "\(APIConfig.baseURL)/uploads/\(individual.photoPath ?? "")"
                    )
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()

                    case .failure:
                        Text("Photo")
                            .foregroundStyle(.secondary)

                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Individual")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)

                    Text(individual.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(individual.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 0) {
                    InfoRow(label: "識別番号", value: individual.id)
                    InfoRow(label: "性別", value: "Unknown")
                    InfoRow(label: "ステータス", value: "Known individual")
                }
            }
            .padding(24)
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
        IndividualDetailView(
            individual: Individual(
                id: "K-001",
                name: "K-001",
                description: "Adult · Known individual",
                photoPath: nil
            )
        )
    }
}
