//
//  ImagesViewModel.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import Foundation

protocol ImagesViewModelProtocol {
    var imagesData: [Data] { get }
    func fetchImages(completion: @escaping () -> Void)
    func loadImagesFromBase()
    func numberOfItems() -> Int?
    func viewModelForSelectedItem(at indexPAth: IndexPath) -> DetailsViewModelProtocol?
    func cellViewModel(at indexPath: IndexPath) -> ImageCollectionCellViewModelProtocol?
}

final class ImagesViewModel: ImagesViewModelProtocol {
    var imagesData: [Data] = []
    
    // MARK: - Public methods
    func fetchImages(completion: @escaping () -> Void) {
        NetworkingManager.shared.fetchUserData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageResult):
                let photos = self.getLastTwentyPhotos(from: imageResult.photos.photo)
                self.imagesData = ImageManager.shared.getImagesData(from: photos) ?? []
                self.saveImagesToBase()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadImagesFromBase() {
        self.imagesData = DataManager.shared.loadLastImages()  ?? []
    }
    
    func numberOfItems() -> Int? {
        imagesData.count
    }
    
    func viewModelForSelectedItem(at indexPath: IndexPath) -> DetailsViewModelProtocol? {
        let imageData = imagesData[indexPath.item]
        return DetailsViewModel(imageData: imageData)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ImageCollectionCellViewModelProtocol? {
        let imageData = imagesData[indexPath.item]
        return ImageCollectionCellViewModel(imageData: imageData)
    }
}

// MARK: - Private methods
extension ImagesViewModel {
    
    private func saveImagesToBase() {
        DataManager.shared.saveLastImages(self.imagesData)
    }

    private func getLastTwentyPhotos(from photo: [Photo]) -> [Photo] {
        photo.suffix(20)
    }
}
