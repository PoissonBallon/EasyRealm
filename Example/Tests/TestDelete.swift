//
//  Test_Delete.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 10/03/2017.
//


import XCTest
import RealmSwift
import EasyRealm

class TestDelete: XCTestCase {
    
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
  
  func testDeleteAll() {
    HelpPokemon.pokemons(with: self.testPokemon).forEach { try! $0.er.save(update: true) }
    try! Pokemon.er.deleteAll()
    let count = try! Pokemon.er.all().count
    XCTAssertEqual(count, 0)
  }
  
  
  func testDeleteUnmanaged() {
    let pokemons = HelpPokemon.pokemons(with: self.testPokemon)
    pokemons.forEach {
      try! $0.er.save(update: true)
    }
    pokemons.forEach { pokemon in
      XCTAssert(pokemon.realm == nil)
      try! pokemon.er.delete()
    }
    let count = try! Pokemon.er.all().count
    XCTAssertEqual(count, 0)
  }
  
  func testDeleteManaged() {
    HelpPokemon.pokemons(with: self.testPokemon).forEach {
      try! $0.er.save(update: true)
    }
    
    let pokemons = try! Pokemon.er.all()
    pokemons.forEach {
      XCTAssert($0.realm != nil)
      try! $0.er.delete()
    }
    
    let count = try! Pokemon.er.all().count
    XCTAssertEqual(count, 0)
  }
  
  func testDeleteCascadeComplexManagedObject() {
    let trainer = Trainer()
    let pokedex = Pokedex()
    trainer.pokemons.append(HelpPokemon.generateCapturedRandomPokemon())
    trainer.pokedex = pokedex
    try! trainer.er.save(update: true)


    XCTAssertEqual(try! Trainer.er.all().count, 1)
    XCTAssertEqual(try! Pokedex.er.all().count, 1)
    XCTAssertEqual(try! Pokemon.er.all().count, HelpPokemon.allPokedex().count)

    let managed = trainer.er.managed!
    try! managed.er.delete(with: .cascade)
    
    XCTAssertEqual(try! Trainer.er.all().count, 0)
    XCTAssertEqual(try! Pokedex.er.all().count, 0)
    XCTAssertEqual(try! Pokemon.er.all().count, 0)
  }

  func testDeleteCascadeComplexUnManagedObject() {
    let trainer = Trainer()
    let pokedex = Pokedex()
    trainer.pokemons.append(HelpPokemon.generateCapturedRandomPokemon())
    trainer.pokedex = pokedex
    try! trainer.er.save(update: true)
    
    
    XCTAssertEqual(try! Trainer.er.all().count, 1)
    XCTAssertEqual(try! Pokedex.er.all().count, 1)
    XCTAssertEqual(try! Pokemon.er.all().count, HelpPokemon.allPokedex().count)
    
    try! trainer.er.delete(with: .cascade)
    
    XCTAssertEqual(try! Trainer.er.all().count, 0)
    XCTAssertEqual(try! Pokedex.er.all().count, 0)
    XCTAssertEqual(try! Pokemon.er.all().count, 0)
  }
  
}
