//
//  AnimalDetailsViewController.swift
//  ScAnimals
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AnimalDetailsViewController: UITableViewController {

    private lazy var headerView: CarouselOfImagesView = CarouselOfImagesView()
    private lazy var toSaveButtonView = UIButton.init()
    private var snapshot: DataSnapshot?
    private var animal: AnimalModel?
    private var isSaved: Bool = false


    init(with animal: AnimalModel) {
        self.animal = animal
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = animal.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }
}

extension AnimalDetailsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal?.description.count ?? 0
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell =  tableView.dequeueReusableCell(withIdentifier: DescriptionItem.cellIdentifier(), for: indexPath) as? DescriptionItem

        if let item = animal?.description[indexPath.row] {
            cell?.configure(with: item)
        }

        return cell!
    }
}

private extension AnimalDetailsViewController {

    func saveAnimal() -> Void {
        if let animal = animal {
            StoreManager.shared().setAnimal(with: animal)
        }
    }

    func removeAnimal() -> Void {
        if let name = animal?.name {
            StoreManager.shared().removeAnimal(with: name)
        }
    }

    func checkAnimalAlreadySaved() -> Void {
        if let name = animal?.name {
            self.isSaved = StoreManager.shared().animalIsExist(with: name)
        }
    }
}

private extension AnimalDetailsViewController {

    @objc
    func toSavePressed(_ sender: UIButton) -> Void {

        isSaved.toggle()
        isSaved ? saveAnimal() : removeAnimal()
        let image: UIImage = isSaved ? #imageLiteral(resourceName: "Group 38") : #imageLiteral(resourceName: "Group 38-1")
        sender.setImage(image, for: .normal)
    }
}

private extension AnimalDetailsViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //check animal already saved
        checkAnimalAlreadySaved()

        //superview
        view.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)

        //header view
        headerView.frame.size.height = 200.0
        headerView.items = animal?.images

        //table view
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero

        //to save button view
        let toSaveIcon = isSaved ? #imageLiteral(resourceName: "Group 38") : #imageLiteral(resourceName: "Group 38-1")
        toSaveButtonView.setImage(toSaveIcon, for: .normal)
        toSaveButtonView.addTarget(self, action: #selector(toSavePressed), for: .touchUpInside)

        //navigation item
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: toSaveButtonView)
    }

    func buildServices() -> Void {

        tableView.register(DescriptionItem.self, forCellReuseIdentifier: DescriptionItem.cellIdentifier())
    }
}
