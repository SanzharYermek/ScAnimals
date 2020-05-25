//
//  HistoryModel.swift
//  ScAnimals
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

struct HistoryModel: Codable {
    
    let name: String?
    let type: String
    let confidence: Int
    let image: Data
    let date: Date
}
