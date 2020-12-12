//
//  DetailsViewController.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModelProtocol!
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        guard let imageData = viewModel.imageData else { return }
        imageView.image = UIImage(data: imageData)
    }
}
