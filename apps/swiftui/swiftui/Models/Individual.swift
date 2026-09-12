/// 個体を表すデータモデル
struct Individual: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let photoPath: String?
    
    /// Swift のプロパティ名と API の JSON キー名を対応付け
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case photoPath = "photo_path"
    }
}
