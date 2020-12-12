//
//  CollectionCellViewModel.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

protocol ImageCollectionCellViewModelProtocol {
    var imageData: Data? { get }
    init(imageData: Data)
}

final class ImageCollectionCellViewModel: ImageCollectionCellViewModelProtocol {
    var imageData: Data?
    
    required init(imageData: Data) {
        self.imageData = imageData
    }
}
