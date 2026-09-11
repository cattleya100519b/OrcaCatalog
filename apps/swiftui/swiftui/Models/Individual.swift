struct Individual: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let photoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case photoPath = "photo_path"
    }
}
