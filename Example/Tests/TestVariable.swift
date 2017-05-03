//
//  Test_Variable.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 10/03/2017.
//


import XCTest
import RealmSwift
import EasyRealm

class TestVariable: XCTestCase {
  
  
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
  
  func testIsManaged() {
    HelpPokemon.pokemons(with: self.testPokemon).forEach { try! $0.er.save(update: true) }
    var pokemon = HelpPokemon.pokemons(with: [self.testPokemon[0]]).first!
    XCTAssertFalse(pokemon.er.isManaged)
    if let pok = pokemon.er.managed {
      pokemon = pok
    }
    XCTAssertTrue(pokemon.er.isManaged)
  }
  
  func testManaged() {
    let pokemon = HelpPokemon.generateCapturedRandomPokemon()
    try! pokemon.er.edit {
      $0.pokeball?.branding = "Masterball"
    }
    try! pokemon.er.save(update: true)

    let managed = pokemon.er.managed
    XCTAssertNotNil(managed)
    XCTAssertTrue(managed?.er.isManaged ?? false)
    XCTAssertEqual(managed?.pokeball?.branding, "Masterball")

  }
  
  func testUnManaged() {
    let pokemon = HelpPokemon.generateCapturedRandomPokemon()
    try! pokemon.er.edit {
      $0.pokeball?.branding = "Masterball"
    }
    try! pokemon.er.save(update: true)
    
    let managed = pokemon.er.managed
    XCTAssertNotNil(managed)
    XCTAssertTrue(managed?.er.isManaged ?? false)
    XCTAssertEqual(managed?.pokeball?.branding, "Masterball")

    let unmnaged = pokemon.er.unmanaged
    XCTAssertNotNil(unmnaged)
    XCTAssertFalse(unmnaged.er.isManaged)
    XCTAssertEqual(unmnaged.pokeball?.branding, "Masterball")
  }
  
  func testComplexObject() {
    let trainer = Trainer()
    let pokedex = Pokedex()
    trainer.pokemons.append(HelpPokemon.generateCapturedRandomPokemon())
    trainer.pokedex = pokedex

    try! trainer.er.save(update: true)
    let managed = trainer.er.managed!
    XCTAssertTrue(managed.er.isManaged)
    XCTAssertTrue(managed.pokedex!.er.isManaged)
    XCTAssertFalse(managed.pokemons.isEmpty)
    managed.pokemons.forEach {
      XCTAssertTrue($0.er.isManaged)
    }
    
    let unmanaged = managed.er.unmanaged
    XCTAssertFalse(unmanaged.er.isManaged)
    XCTAssertFalse(unmanaged.pokedex!.er.isManaged)
    XCTAssertFalse(unmanaged.pokemons.isEmpty)
    unmanaged.pokemons.forEach {
      XCTAssertFalse($0.er.isManaged)
    }
  }
  
  
}
