//
//  SavedViewController.swift
//  ScAnimals
//
//  Created by I on 2/28/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SavedViewController: UICollectionViewController {

    private var animals: [AnimalModel] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchAnimals()
    }
}

extension SavedViewController: UICollectionViewDelegateFlowLayout {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return animals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedAnimalItem.cellIdentifier(), for: indexPath) as? SavedAnimalItem
        let animal = animals[indexPath.row]
        cell?.configure(with: animal)

        cell?.removeAnimalEvent = { [weak self] in
            self?.removeAnimal(with: animal.name)
            self?.fetchAnimals()
        }

        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15;
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ( self.collectionView.frame.size.width - 60 ) / 3,height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let viewController = AnimalDetailsViewController(with: animals[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension SavedViewController {

    func fetchAnimals() -> Void {
        if let animals = StoreManager.shared().fetchAnimals(),
            animals.isEmpty == false
        {
            self.animals = animals
            collectionView?.backgroundView = nil
        }
        else {
            self.animals = []
            collectionView?.backgroundView = MessageBackgroundView(with: "У вас нету сохраненных")
        }
        collectionView?.reloadData()
    }

    func removeAnimal(with animalName: String?) -> Void {
        if let name = animalName {
            StoreManager.shared().removeAnimal(with: name)
        }
    }
}


private extension SavedViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)

        //collection view
        collectionView?.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)

        //navigation item
        navigationItem.title = "Сохраненные"
    }

    func buildServices() -> Void {

        collectionView?.register(SavedAnimalItem.self, forCellWithReuseIdentifier: SavedAnimalItem.cellIdentifier())
    }
}

