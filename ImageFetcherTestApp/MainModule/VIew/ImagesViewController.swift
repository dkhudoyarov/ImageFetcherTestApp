//
//  ImagesViewController.swift
//  ImageFetcherTestApp
//
//  Created by Денис on 10.12.2020.
//

import UIKit

final class ImagesViewController: UIViewController {
    
    // MARK: - Private properties
    private var viewModel: ImagesViewModelProtocol!
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
        
    // MARK: - Overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupConstraints()
        viewModel = ImagesViewModel()
        viewModel.loadImagesFromBase()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.viewModel = sender as? DetailsViewModelProtocol
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        viewModel.fetchImages {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Collection view data cource
extension ImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.collectionCell, for: indexPath) as? ImageCollectionViewCell
        guard let imageCell = cell else { return UICollectionViewCell() }
    
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        imageCell.viewModel = cellViewModel
    
        return imageCell
    }
}

// MARK: - Collection view delegate
extension ImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailsViewModel = viewModel.viewModelForSelectedItem(at: indexPath)
        performSegue(withIdentifier: Constant.segueId, sender: detailsViewModel)
    }
}

// MARK: - Private methods
extension ImagesViewController {
    
    private func setupCollectionView() {
        let size = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: size * Sizes.portraitItemSize, height: size * Sizes.portraitItemSize)
        layout.sectionInset = Sizes.portraitEdgeInsets
        layout.minimumLineSpacing = Sizes.portraitEdgeInsets.left
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: Constant.collectionCell)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

