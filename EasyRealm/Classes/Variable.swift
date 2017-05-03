//
//  ER_Variable.swift
//  Pods
//
//  Created by Allan Vialatte on 05/03/2017.
//

import Foundation
import Realm
import RealmSwift

extension EasyRealm where T: Object {
  
  public var isManaged: Bool {
    return (self.base.realm != nil)
  }
  
  public var managed: T? {
    guard let realm = try? Realm(), let key = T.primaryKey() else { return nil }
    let object = realm.object(ofType: T.self, forPrimaryKey: self.base.value(forKey: key))
    return object
  }
  
  public var unmanaged:T {
    return self.base.detached()
  }
}


fileprivate extension Object {
  fileprivate func detached() -> Self {
    let detached = type(of: self).init()
    for property in objectSchema.properties {
      guard let value = value(forKey: property.name) else { continue }
      if let detachable = value as? Object {
        detached.setValue(detachable.detached(), forKey: property.name)
      } else if let detachable = value as? EasyRealmList  {
        detached.setValue(detachable.children().flatMap { $0.detached() },forKey: property.name)
      } else {
        detached.setValue(value, forKey: property.name)
      }
    }
    return detached
  }
}
