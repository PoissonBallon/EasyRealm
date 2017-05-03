//
//  Tainer.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 22/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RealmSwift

final class Trainer: Object {
  dynamic var identifier = UUID().uuidString
  dynamic var pokedex:Pokedex?
  var pokemons = List<Pokemon>()
  
  override static func primaryKey() -> String? {
    return "identifier"
  }
  
}
