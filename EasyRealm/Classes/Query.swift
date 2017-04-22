//
//  ER_Query.swift
//  Pods
//
//  Created by Allan Vialatte on 05/03/2017.
//
//

import Foundation
import RealmSwift

public extension EasyRealmStatic where T:Object {
  
  public func fromRealm<K>(with primaryKey:K) throws -> T {
    let realm = try Realm()
    if let object = realm.object(ofType: self.baseType, forPrimaryKey: primaryKey) {
      return object
    } else {
      throw EasyRealmError.ObjectWithPrimaryKeyNotFound
    }
  }
  
  public func all() throws -> Results<T> {
    let realm = try Realm()
    return realm.objects(self.baseType)
  }
}
