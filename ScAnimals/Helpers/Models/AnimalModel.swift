//
//  AnimalModel.swift
//  ScAnimals
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Yerzhan. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct AnimalDescriptionModel: Codable {
    var title: String?
    var value: String?

    init (with snapshot: DataSnapshot?) {
        title = snapshot?.childSnapshot(forPath: "title").value as? String
        value = snapshot?.childSnapshot(forPath: "value").value as? String
    }
}

struct AnimalModel: Codable {
    var name: String?
    var images: [String]?
    var description: [AnimalDescriptionModel] = []

    init (with snapshot: DataSnapshot?) {
        name = snapshot?.childSnapshot(forPath: "name").value as? String
        images = snapshot?.childSnapshot(forPath: "images").value as? [String]
        (snapshot?.childSnapshot(forPath: "description").children.allObjects as? [DataSnapshot])?.forEach({ (snapshot) in
            description.append(AnimalDescriptionModel(with: snapshot))
        })
    }
}

