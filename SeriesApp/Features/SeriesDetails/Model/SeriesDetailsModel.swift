import Foundation

// MARK: - SeriesElement
struct SeriesDetailsElement: Codable {
    let id: Int
    let url: String
    let name: String
    let season, number: Int
    let image: Image
    let airstamp: String
    let summary: String

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, image, airstamp, summary
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
}

typealias Episodes = [SeriesDetailsElement]
