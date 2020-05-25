//
//  Stylizing.swift
//  ScAnimals
//
//  Created by I on 3/8/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

protocol Stylyzing {}

extension Stylyzing where Self: SearchByItemsViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildService()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)

        //search controller view
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите тип животного"
        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.black
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                // Background color
                backgroundview.backgroundColor = UIColor.white
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }

        definesPresentationContext = true

        //collection view
        collectionView?.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }

        //navigation item view
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = path
    }

    func buildLayouts() -> Void {

    }

    func buildService() -> Void {

        referenceToDatabase = Database.database().reference()
        collectionView?.register(AnimalItem.self, forCellWithReuseIdentifier: AnimalItem.cellIdentifier())
    }
}

extension Stylyzing where Self: SearchByCategoryViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildService()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)

        //search controller view
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите категорию животных"
        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.black
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                // Background color
                backgroundview.backgroundColor = UIColor.white
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }

        definesPresentationContext = true

        //collection view
        collectionView?.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }

        //navigation item view
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Категория"
    }

    func buildLayouts() -> Void {

    }

    func buildService() -> Void {

        referenceToDatabase = Database.database().reference()
        collectionView?.register(CategoryItem.self, forCellWithReuseIdentifier: CategoryItem.cellIdentifier())
    }
}
