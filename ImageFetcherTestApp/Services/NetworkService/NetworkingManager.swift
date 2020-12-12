//
//  NetworkingManager.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

protocol NetworkingManagerProtocol {
    func fetchUserData(completion: @escaping (Result<ImageResult, Error>) -> Void)
}

final class NetworkingManager: NetworkingManagerProtocol {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    private let networkDataFetcher: DataFetcherProtocol = NetworkDataFetcher()
        
    func fetchUserData(completion: @escaping (Result<ImageResult, Error>) -> Void) {
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=da9d38d3dee82ec8dda8bb0763bf5d9c&format=json&nojsoncallback=1"
        networkDataFetcher.fetchGenericJSONData(fromUrl: urlString, completion: completion)
    }
}
