//
//  DetailsViewModel.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

protocol DetailsViewModelProtocol {
    var imageData: Data? { get }
    init(imageData: Data)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    var imageData: Data?
    
    required init(imageData: Data) {
        self.imageData = imageData
    }
}
