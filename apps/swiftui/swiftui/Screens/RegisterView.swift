//
//  RegisterView.swift
//  swiftui
//
//  Created by Shota Teranishi on 2026/09/07.
//

import PhotosUI
import SwiftUI

struct RegisterView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var image: Image?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("OrcaCatalog")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)

                        Text("写真を登録")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }

                    if let image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )

                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images
                        ) {
                            Text("写真を変更")
                        }
                        .buttonStyle(.bordered)
                    } else {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images
                        ) {
                            Label("写真を選択", systemImage: "photo")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 32)
                        }
                        .buttonStyle(.bordered)
                    }

                    HStack {
                        Spacer()

                        Button("登録する") {
                            // 後でAPIに送る
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(image == nil)
                    }
                }
                .padding(24)
                .frame(maxWidth: 640)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("写真を登録")
        }
        .task(id: selectedItem) {
            guard let selectedItem else {
                return
            }

            if let data = try? await selectedItem.loadTransferable(
                type: Data.self
            ),
            let uiImage = UIImage(data: data) {
                image = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    RegisterView()
}
