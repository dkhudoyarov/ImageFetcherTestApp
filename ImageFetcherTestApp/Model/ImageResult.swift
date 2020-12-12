//
//  Image.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

struct ImageResult: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [Photo]
}

struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
}
