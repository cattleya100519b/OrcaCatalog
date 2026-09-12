import SwiftUI

/// 個体一覧に表示する個体カード
struct IndividualCard: View {
    let individual: Individual

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                        .scaledToFill()

                case .failure:
                    Text("Photo")
                        .foregroundStyle(.secondary)

                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .clipped()

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
    IndividualCard(
        individual: Individual(
            id: "K-001",
            name: "K-001",
            description: "Adult · Known individual",
            photoPath: nil
        )
    )
    .padding()
}
