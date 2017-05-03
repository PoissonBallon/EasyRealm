//
//  Pokedex.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 22/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RealmSwift

final class Pokedex:Object {
  dynamic var identifier = UUID().uuidString
  
  override static func primaryKey() -> String? {
    return "identifier"
  }

}
