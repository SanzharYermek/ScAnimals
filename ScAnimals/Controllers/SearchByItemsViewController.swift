//
//  SearchByItemsViewController.swift
//  ScAnimals
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchByItemsViewController: UICollectionViewController, Stylyzing {

    var referenceToDatabase: DatabaseReference!
    private(set) var searchController = UISearchController.init(searchResultsController: nil)
    private var animals: [DataSnapshot] = []
    private var filteredAnimals: [DataSnapshot] = []

    private(set) var path: String?

    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    init(with path: String) {
        let layout = PinterestLayout()
        self.path = path
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        fetchAnimals()
    }
}

extension SearchByItemsViewController: UICollectionViewDelegateFlowLayout {

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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimalItem.cellIdentifier(), for: indexPath) as? AnimalItem

        let animal: DataSnapshot = (isFiltering) ? filteredAnimals[indexPath.row] : animals[indexPath.row]

        cell?.configure(with: animal)
        
        return cell!
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot: DataSnapshot = (isFiltering) ? filteredAnimals[indexPath.row] : animals[indexPath.row]

        let viewController = AnimalDetailsViewController(with: AnimalModel.init(with: snapshot))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchByItemsViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        let searchText = searchController.searchBar.text ?? ""
        filteredAnimals = animals.filter { (animal: DataSnapshot) -> Bool in
            if let animalName = animal.childSnapshot(forPath: "name").value as? String {
                return animalName.lowercased().contains(searchText.lowercased())
            }
            return false
        }
        collectionView?.reloadData()
    }
}

private extension SearchByItemsViewController {

     func fetchAnimals() -> Void {
        if let path = path {
            collectionView?.backgroundView = LoadingView()
            referenceToDatabase.child("animals").child(path).observeSingleEvent(of: .value) { [weak self] (snapshots) in
                self?.collectionView?.backgroundView = nil
                if let animals = snapshots.children.allObjects as? [DataSnapshot], animals.isEmpty == false {
                    self?.animals = animals
                }
                self?.collectionView?.reloadData()
            }
        }
    }
}

extension SearchByItemsViewController: PinterestLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForLabelAtIndexPath indexPath: IndexPath) -> CGFloat {

        let animal: DataSnapshot = (isFiltering) ? filteredAnimals[indexPath.row] : animals[indexPath.row]
        if let name = animal.childSnapshot(forPath: "name").value as? String {
            let width = (collectionView.frame.size.width - 60) / 3 - 20
            let height = animal.key.heightWithConstrainedWidth(width: width, font: .systemFont(ofSize: 15))
            return CGFloat(height + 102.0)
        }
        return CGFloat(102.0)
    }
}


