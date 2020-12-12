//
//  Constants.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import UIKit

struct Constant {
    static let collectionCell = "cell"
    static let segueId = "showDetails"
    static let userDefaultsKey = "UserDefaultsKey"
}

struct ApiBuilder {
    static func getApi(from photo: Photo) -> String? {
        "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
}

struct Sizes {
    static let screenSize = UIScreen.main.bounds.width
    static let portraitItemSize: CGFloat = 0.35
    static let landscapeItemSize: CGFloat = 0.2
    static let portraitEdgeInsets = UIEdgeInsets(top: screenSize * 0.1,
                                                  left: screenSize * 0.1,
                                                  bottom: screenSize * 0.1,
                                                  right: screenSize * 0.1)
    static let landscapeEdgeInsets = UIEdgeInsets(top: screenSize * 0.04,
                                                   left: screenSize * 0.04,
                                                   bottom: screenSize * 0.04,
                                                   right: screenSize * 0.04)
}
