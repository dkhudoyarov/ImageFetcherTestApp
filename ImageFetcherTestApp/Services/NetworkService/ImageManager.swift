//
//  ImageManager.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

protocol ImageManagerProtocol {
    func getImagesData(from photos: [Photo]) -> [Data]?
}

final class ImageManager: ImageManagerProtocol {
    static let shared = ImageManager()
    private init() {}
    
    func getImagesData(from photos: [Photo]) -> [Data]? {
        var data: [Data] = []
        for photo in photos {
            guard let stringURL = ApiBuilder.getApi(from: photo) else { return [] }
            guard let imageURL = URL(string: stringURL) else { return [] }
            guard let imageData = try? Data(contentsOf: imageURL) else { return [] }
            data.append(imageData)
        }
        return data
    }
}
