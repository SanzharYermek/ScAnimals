//
//  StorageManager.swift
//  Jiber
//
//  Created by I on 9/5/19.
//  Copyright © 2019 Shyngys. All rights reserved.
//

import Foundation
import Cache

class StoreManager: NSObject {

    //MARK: - Keys
    private let diskConfigurationKey    = "DISKCONFIGURATIONKEY"
    private let saved_animals           = "SAVED_ANIMALS"
    private let history                 = "HISTORY"

    //MARK: - Variables

    private var storage : Storage?  //Cache manager

    // MARK: - Public functions

    class func shared() -> StoreManager {
        return sharedManager
    }

    private static var sharedManager: StoreManager = {
        let manager = StoreManager()
        return manager
    }()

    //MARK: - Init

    private override init() {
        super.init()
        self.setupStorage()
    }

    func cleanCache() {
        try? self.storage?.removeAll()
    }

    //MARK: - Private functions

    private func setupStorage() {

        let disk = DiskConfig(name: diskConfigurationKey)
        let memory = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
        storage = try! Storage(diskConfig: disk, memoryConfig: memory)
    }

}

//MARK: - SAVED

extension StoreManager {

    func fetchAnimals() -> [AnimalModel]? {

        if let animals = try? storage?.object(ofType: [AnimalModel].self, forKey: saved_animals) {
            return animals
        }
        return nil
    }

    func setAnimal(with model: AnimalModel) -> Void {

        if var animals = fetchAnimals() {
            animals.append(model)
            try? storage?.setObject(animals, forKey: saved_animals)
        }
        else{
            try? storage?.setObject([model], forKey: saved_animals)
        }
    }

    func animalIsExist(with name: String) -> Bool {
        if let animals = fetchAnimals() {
            for animal in animals {
                if animal.name == name {
                    return true
                }
            }
            return false
        }
        return false
    }

    func removeAnimal(with name: String) -> Void {
        var index: Int?
        if var animals = fetchAnimals() {
            animals.enumerated().forEach { (arg0) in
                if arg0.element.name == name {
                    index = arg0.offset
                }
            }

            if let index = index {
                animals.remove(at: index)
                try? storage?.setObject(animals, forKey: saved_animals)
            }
        }
    }
}

//MARK: - HISTORY

extension StoreManager {

    func fetchHistory() -> [HistoryModel]? {

        if let animals = try? storage?.object(ofType: [HistoryModel].self, forKey: history) {
            return animals
        }
        return nil
    }

    func setAnimalToHistory(with model: HistoryModel) -> Void {

        if var historyOfScanners = fetchHistory() {
            historyOfScanners.append(model)
            try? storage?.setObject(historyOfScanners, forKey: history)
        }
        else{
            try? storage?.setObject([model], forKey: history)
        }
    }

    func removeAnimalFromHistory(with row: Int) -> Void {
        if var historyOfScanners = fetchHistory() {
            historyOfScanners.remove(at: row)
            try? storage?.setObject(historyOfScanners, forKey: history)
        }
    }
}
