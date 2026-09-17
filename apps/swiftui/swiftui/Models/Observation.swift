import Foundation
import CoreLocation

/// 観察情報を表すデータモデル
struct Observation: Identifiable, Codable {
    // 観察ID
    let id: String
    let latitude: Double
    let longitude: Double
    // 個体内部に個体ID
    let individual: Individual

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
