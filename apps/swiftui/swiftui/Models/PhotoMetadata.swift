import Foundation
import ImageIO

/// 写真のメタデータを表す
struct PhotoMetadata {
    let latitude: Double?
    let longitude: Double?

    init(data: Data) {
        guard let source = CGImageSourceCreateWithData(
            data as CFData,
            nil
        ) else {
            latitude = nil
            longitude = nil
            return
        }

        let properties = CGImageSourceCopyPropertiesAtIndex(
            source,
            0,
            nil
        ) as? [CFString: Any]

        let gps = properties?[kCGImagePropertyGPSDictionary] as? [CFString: Any]

        latitude = gps?[kCGImagePropertyGPSLatitude] as? Double
        longitude = gps?[kCGImagePropertyGPSLongitude] as? Double
    }
}
