//
//  TestMeasure.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 01/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
import EasyRealm

class TestMeasure: XCTestCase {
    
  override func setUp() {
    super.setUp()
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
  }
  
  override func tearDown() {
    super.tearDown()
    let realm = try! Realm()
    try! realm.write { realm.deleteAll() }
  }
  
  // Traditional Way

  func testCreateAndSave() {

    self.measure {
      let realm = try! Realm()
      let trainer = Trainer()
      let pokedex = Pokedex()
      trainer.pokemons.append(HelpPokemon.generateCapturedRandomPokemon())
      trainer.pokedex = pokedex
      try! realm.write {
        realm.add(trainer, update: true)
      }
    }
  }
  
  // Easy Realm Way
  
  func testERCreateAndSave() {
    self.measure {
      let trainer = Trainer()
      let pokedex = Pokedex()
      trainer.pokemons.append(HelpPokemon.generateCapturedRandomPokemon())
      trainer.pokedex = pokedex
      try! trainer.er.save(update: true)
    }
  }
  
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
