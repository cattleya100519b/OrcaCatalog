import SwiftUI

struct HomeView: View {
    @State private var query = ""
    @State private var individuals: [Individual] = []
    @FocusState private var isSearchFocused: Bool

    private var filteredIndividuals: [Individual] {
        if query.isEmpty {
            return individuals
        }

        return individuals.filter { individual in
            individual.id.localizedCaseInsensitiveContains(query)
                || individual.name.localizedCaseInsensitiveContains(query)
        }
    }

    private func columns(for width: CGFloat) -> [GridItem] {
        // iPhone: 1列
        // iPad縦: 2列
        // iPad横: 3列
        let count: Int

        if width < 600 {
            count = 1
        } else if width < 900 {
            count = 2
        } else {
            count = 3
        }

        return Array(
            repeating: GridItem(.flexible(), spacing: 16),
            count: count
        )
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("OrcaCatalog")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)

                            Text("個体を探す")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }

                        TextField("個体名・IDを検索", text: $query)
                            .textFieldStyle(.roundedBorder)
                            .focused($isSearchFocused)
                            .submitLabel(.done)
                            .onSubmit {
                                isSearchFocused = false
                            }

                        LazyVGrid(
                            columns: columns(for: geometry.size.width),
                            spacing: 16
                        ) {
                            ForEach(filteredIndividuals) { individual in
                                NavigationLink {
                                    IndividualDetailView(individual: individual)
                                } label: {
                                    IndividualCard(individual: individual)
                                }
                            }
                        }
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity)
                }
                .refreshable {
                    await loadIndividuals()
                }
            }
            .simultaneousGesture(
                TapGesture().onEnded {
                    isSearchFocused = false
                }
            )
            .navigationTitle("OrcaCatalog")
            .scrollDismissesKeyboard(.immediately)
            .task {
                await loadIndividuals()
            }
        }
    }

    private func loadIndividuals() async {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/individuals")
        else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            individuals = try JSONDecoder().decode(
                [Individual].self,
                from: data
            )
        } catch {
            print(error)
        }
    }
}

#Preview {
    HomeView()
}
