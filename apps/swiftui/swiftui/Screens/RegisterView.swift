import PhotosUI
import SwiftUI

/// 個体の写真と基本情報を登録する画面
struct RegisterView: View {
    let onRegistered: () -> Void
    @State private var selectedItem: PhotosPickerItem?
    @State private var image: Image?
    @State private var imageData: Data?
    @State private var id = ""
    @State private var name = ""
    @State private var description = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
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

                TextField("識別番号", text: $id)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)

                TextField("個体名", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)

                TextField("説明", text: $description, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)
                    .lineLimit(3...6)

                HStack {
                    Spacer()

                    Button("登録する") {
                        Task {
                            await register()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(
                        image == nil || id.isEmpty || name.isEmpty
                            || description.isEmpty
                    )
                }
            }
            .padding(24)
            .frame(maxWidth: 640)
            .frame(maxWidth: .infinity)
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                isTextFieldFocused = false
            }
        )
        .scrollDismissesKeyboard(.immediately)
        .task(id: selectedItem) {
            guard let selectedItem else {
                return
            }

            if let data = try? await selectedItem.loadTransferable(
                type: Data.self
            ),
                let uiImage = UIImage(data: data)
            {
                imageData = data
                image = Image(uiImage: uiImage)
            }
        }
    }

    /// 写真と個体情報をAPIへ送信して個体を登録
    private func register() async {
        guard let imageData else {
            return
        }

        guard let url = URL(string: "\(APIConfig.baseURL)/api/individuals")
        else {
            return
        }

        let boundary = UUID().uuidString

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )

        var body = Data()

        func appendField(name: String, value: String) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append(
                "Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n"
                    .data(using: .utf8)!
            )
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        appendField(name: "id", value: id)
        appendField(name: "name", value: name)
        appendField(name: "description", value: description)

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append(
            "Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n"
                .data(using: .utf8)!
        )
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        do {
            let (data, response) = try await URLSession.shared.upload(
                for: request,
                from: body
            )

            if let httpResponse = response as? HTTPURLResponse {
                print("status:", httpResponse.statusCode)

                if httpResponse.statusCode == 201 {
                    onRegistered()
                }
            }

            print(String(data: data, encoding: .utf8) ?? "")
        } catch {
            print("登録失敗:", error)
        }
    }
}

#Preview {
    RegisterView {
    }
}
