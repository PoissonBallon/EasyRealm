//
//  TestUpdate.swift
//  EasyRealm_Example
//
//  Created by Allan Vialatte on 15/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
import EasyRealm

class TestUpdate: XCTestCase {
  
  let testPokemon = ["Bulbasaur", "Ivysaur", "Venusaur","Charmander","Charmeleon","Charizard"]
  
  override func setUp() {
    super.setUp()
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
  }
  
  override func tearDown() {
    super.tearDown()
    let realm = try! Realm()
    try! realm.write { realm.deleteAll() }
  }
  
  func testUpdateUnmanaged() {
    HelpPokemon.pokemons(with: self.testPokemon).forEach { try! $0.er.save(update: true) }
    HelpPokemon.pokemons(with: self.testPokemon).forEach { try! $0.er.save(update: true) }
    let pokemons = try! Pokemon.er.all()
    let unmanaged = Array(pokemons).map { $0.er.unmanaged }
    unmanaged.forEach { $0.level = 42 }
    unmanaged.forEach { try! $0.er.update() }

    let pikachus = try! Pokemon.er.all()
    pikachus.forEach { XCTAssertEqual($0.level, 42) }
  }
}
