//
//  Model.swift
//  NeorisPTecnica
//
//  Created by Jesus Mora on 27/11/24.
//

struct PhotoResponse: Codable, Identifiable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
