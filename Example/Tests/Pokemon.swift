//
//  Pokemon.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 10/03/2017.
//


import Foundation
import RealmSwift

final class Pokeball:Object {
  dynamic var identifier = UUID().uuidString
  dynamic var level = 1
  dynamic var branding = ""
  
  static func create() -> Pokeball {
    let ball = Pokeball()
    ball.level = Int(arc4random()) % 5
    return ball
  }
  
}

final class Pokemon: Object {
  dynamic var name: String?
  dynamic var level: Int = 1
  dynamic var pokeball:Pokeball?
  
  override static func primaryKey() -> String? {
    return "name"
  }
}
