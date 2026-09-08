//
//  HomeView.swift
//  swiftui
//
//  Created by Shota Teranishi on 2026/09/07.
//

import SwiftUI

struct HomeView: View {
    @State private var query = ""
    @FocusState private var isSearchFocused: Bool

    private var filteredIndividuals: [Individual] {
        if query.isEmpty {
            return individuals
        }

        return individuals.filter { individual in
            individual.id.localizedCaseInsensitiveContains(query) ||
            individual.name.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        NavigationStack {
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
                        } // Done で仮想キーボードを閉じる

                    let columns = [
                        GridItem(.adaptive(minimum: 400), spacing: 16)
                    ]

                    LazyVGrid(columns: columns, spacing: 16) {
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
                .frame(maxWidth: 900)
                .frame(maxWidth: .infinity)
            }
            .simultaneousGesture(
                TapGesture().onEnded {
                    isSearchFocused = false
                }
            ) // Tap で仮想キーボードを閉じる
            .navigationTitle("OrcaCatalog")
            .scrollDismissesKeyboard(.immediately) // Scroll で仮想キーボードを閉じる
        }
    }
}

#Preview {
    HomeView()
}
