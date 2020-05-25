//
//  SearchByCategoryViewController.swift
//  ScAnimals
//
//  Created by I on 2/28/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import FirebaseDatabase



class SearchByCategoryViewController: UICollectionViewController, Stylyzing {

    var referenceToDatabase: DatabaseReference!
    private(set) var searchController = UISearchController.init(searchResultsController: nil)
    private var animals: [DataSnapshot] = []
    private var filteredAnimals: [DataSnapshot] = []

    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    init() {
        let layout = PinterestLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()

        fetchCategories()
    }
}

extension SearchByCategoryViewController: UICollectionViewDelegateFlowLayout {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if isFiltering {
            return filteredAnimals.count
        }
        return animals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItem.cellIdentifier(), for: indexPath) as? CategoryItem

        let animal: DataSnapshot = (isFiltering) ? filteredAnimals[indexPath.row] : animals[indexPath.row]

        cell?.configure(with: animal.key)

        return cell!
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animal: DataSnapshot = (isFiltering) ? filteredAnimals[indexPath.row] : animals[indexPath.row]

        let viewController = SearchByItemsViewController(with: animal.key)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchByCategoryViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        let searchText = searchController.searchBar.text ?? ""
        filteredAnimals = animals.filter { (animal: DataSnapshot) -> Bool in
            return animal.key.lowercased().contains(searchText.lowercased())
        }
        collectionView?.reloadData()
    }
}

private extension SearchByCategoryViewController {

    func fetchCategories() -> Void {
        collectionView?.backgroundView = LoadingView()
        referenceToDatabase.child("animals").observeSingleEvent(of: .value) { [weak self] (snapshots) in
            self?.collectionView?.backgroundView = nil
            if let animals = snapshots.children.allObjects as? [DataSnapshot], animals.isEmpty == false {
                self?.animals = animals
            }
            self?.collectionView?.reloadData()
        }
    }
}

extension SearchByCategoryViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForLabelAtIndexPath indexPath: IndexPath) -> CGFloat {

        let animal: DataSnapshot = (isFiltering) ? filteredAnimals[indexPath.row] : animals[indexPath.row]
        let width = (collectionView.frame.size.width - 60) / 3 - 20
        let height = animal.key.heightWithConstrainedWidth(width: width, font: .systemFont(ofSize: 15))
        return CGFloat(height + 102.0)
    }
}

