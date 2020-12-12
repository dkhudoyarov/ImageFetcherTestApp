//
//  StorageManager.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

protocol DataManagerProtocol {
    func saveLastImages(_ imagesData: [Data])
    func loadLastImages() -> [Data]?
}

final class DataManager: DataManagerProtocol {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func saveLastImages(_ imagesData: [Data]) {
        guard let data = try? JSONEncoder().encode(imagesData) else { return }
        userDefaults.set(data, forKey: Constant.userDefaultsKey)
    }
    
    func loadLastImages() -> [Data]? {
        guard let data = userDefaults.object(forKey: Constant.userDefaultsKey) as? Data else { return [] }
        guard let photos = try? JSONDecoder().decode([Data].self, from: data) else { return [] }
        return photos
    }
}
