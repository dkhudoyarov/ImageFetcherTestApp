//
//  RequestManager.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

protocol RequestProtocol {
    func request(fromUrl urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

final class RequestManager: RequestProtocol {
    func request(fromUrl urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlTask = createDataTask(fromUrl: url, completion: completion)
        urlTask.resume()
    }
    
    private func createDataTask(fromUrl url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
