// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pictureInfo = try? newJSONDecoder().decode(PictureInfo.self, from: jsonData)

import Foundation

// MARK: - PictureInfo
struct PictureInfo: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
