//
//  Test_Edit.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 12/03/2017.
//

import XCTest
import RealmSwift
import EasyRealm

class TestEdit: XCTestCase {
  
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
  
  func testEditUnmanaged() {
    let pokemons = HelpPokemon.pokemons(with: self.testPokemon)
    pokemons.forEach { try! $0.er.edit { $0.level = 42 } }
    pokemons.forEach { XCTAssertEqual($0.level, 42) }
  }
  
  func testSaveManaged() {
    HelpPokemon.pokemons(with: self.testPokemon).forEach { try! $0.er.save(update: true) }
    let pokemons = try! Pokemon.er.all()
    pokemons.forEach { try! $0.er.edit { $0.level = 42 } }
    pokemons.forEach {
      XCTAssertTrue($0.realm != nil)
      XCTAssertEqual($0.level, 42)
    }
  }
  
}
