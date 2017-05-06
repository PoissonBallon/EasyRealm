//
//  TestQuery.swift
//  EasyRealm
//
//  Created by Allan Vialatte on 06/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import RealmSwift
import EasyRealm

class TestQuery: XCTestCase {
    
  override func setUp() {
    super.setUp()
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
  }
  
  override func tearDown() {
    super.tearDown()
    let realm = try! Realm()
    try! realm.write { realm.deleteAll() }
  }
  
  func testQueryError() {
    if let firstPokemonName = HelpPokemon.allPokemonName.first {
      do {
        _ = try Pokemon.er.fromRealm(with: firstPokemonName)
      } catch EasyRealmError.ObjectWithPrimaryKeyNotFound {
        XCTAssertTrue(true)
        print("ObjectWithPrimaryKeyNotFound")
      } catch {
        print(error)
        XCTAssertTrue(false)
      }
    }
  }
  
  
}
