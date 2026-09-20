import MapKit
import SwiftUI

/// 地図を表示するビュー
struct MapView: View {
    //    @State private var isSelected = false
    @State private var selectedID: String?

    //    let observations: [Observation]
    @State private var observations: [Observation] = []

    var body: some View {
        // 画面遷移のスタック
        NavigationStack {
            Map(selection: $selectedID) {
                ForEach(observations) { observation in
                    Annotation(
                        observation.id,
                        coordinate: observation.coordinate
                    ) {
                        if selectedID == observation.id {
                            // 画面遷移
                            NavigationLink {
                                IndividualDetailView(
                                    individual: observation.individual
                                )
                            } label: {
                                VStack(spacing: 6) {
                                            if let photoPath = observation.individual.photoPath,
                                               let url = URL(
                                                   string: "\(APIConfig.baseURL)/uploads/\(photoPath)"
                                               )
                                            {
                                                AsyncImage(url: url) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                .frame(width: 120, height: 80)
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 8)
                                                )
                                            }

                                            Text(observation.individual.name)
                                                .font(.headline)

                                            Text(observation.individual.description)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                .padding(8)
                                .background(.background)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 8)
                                )
                                .shadow(radius: 4)
                            }
                        } else {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                        }
                    }
                    .tag(observation.id)
                }
            }
        }
        .task {
            do {
                observations = try await fetchObservations()
            } catch {
                print("観察情報の取得失敗:", error)
            }
        }
    }
}

private func fetchObservations() async throws -> [Observation] {
    guard
        let url = URL(
            string: "\(APIConfig.baseURL)/api/observations"
        )
    else {
        throw URLError(.badURL)
    }

    let (data, response) = try await URLSession.shared.data(
        from: url
    )

    guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200
    else {
        throw URLError(.badServerResponse)
    }

    return try JSONDecoder().decode(
        [Observation].self,
        from: data
    )
}

#Preview {
    MapView()
}
