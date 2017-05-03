//
//  ER_Delete.swift
//  Pods
//
//  Created by Allan Vialatte on 23/11/16.
//
//

import UIKit
import Realm
import RealmSwift

public enum EasyRealmDeleteMethod {
  case normal
  case cascade
}

public extension EasyRealmStatic where T:Object {
  
  public func deleteAll(with method:EasyRealmDeleteMethod = .normal) throws {
    let realm = try Realm()
    try realm.write {
      realm.delete(realm.objects(self.baseType))
    }
  }
  
}

public extension EasyRealm where T:Object {
  
  public func delete(with method:EasyRealmDeleteMethod = .normal) throws {
    switch method {
    case .normal:     self.isManaged ? try managedNormalDelete() : try unmanagedNormalDelete()
    case .cascade:    self.isManaged ? try managedCascadeDelete() : try unmanagedCascadeDelete()
    }
  }
  
}



//Normal Way
fileprivate extension EasyRealm where T: Object {
  
  fileprivate func managedNormalDelete() throws {
    guard let rq = EasyRealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    let ref = ThreadSafeReference(to: self.base)
    try rq.queue.sync {
      guard let object = rq.realm.resolve(ref) else { throw EasyRealmError.ObjectCantBeResolved }
      try rq.realm.write {
        EasyRealm.normalDelete(this: object, in: rq)
      }
    }
  }
  
  fileprivate func unmanagedNormalDelete() throws  {
    guard let rq = EasyRealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    guard let key = T.primaryKey() else { throw EasyRealmError.ObjectCantBeResolved }
    
    try rq.queue.sync {
      let value = self.base.value(forKey: key)
      if let object = rq.realm.object(ofType: T.self, forPrimaryKey: value) {
        try rq.realm.write {
          EasyRealm.normalDelete(this: object, in: rq)
        }
      }
    }
  }
  
  fileprivate static func normalDelete(this object:Object, in queue:EasyRealmQueue) {
    queue.realm.delete(object)
  }
  
  
}

//Cascade Way
fileprivate extension EasyRealm where T: Object {
  
  fileprivate func managedCascadeDelete() throws {
    guard let rq = EasyRealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    let ref = ThreadSafeReference(to: self.base)
    try rq.queue.sync {
      guard let object = rq.realm.resolve(ref) else { throw EasyRealmError.ObjectCantBeResolved }
      try rq.realm.write {
        EasyRealm.cascadeDelete(this: object, in: rq)
      }
    }
  }
  
  fileprivate func unmanagedCascadeDelete() throws  {
    guard let rq = EasyRealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    guard let key = T.primaryKey() else { throw EasyRealmError.ObjectCantBeResolved }
    
    try rq.queue.sync {
      let value = self.base.value(forKey: key)
      if let object = rq.realm.object(ofType: T.self, forPrimaryKey: value) {
        try rq.realm.write {
          EasyRealm.cascadeDelete(this: object, in: rq)
        }
      }
    }
  }
  
  
  fileprivate static func cascadeDelete(this object:Object, in queue:EasyRealmQueue) {
    for property in object.objectSchema.properties {
      guard let value = object.value(forKey: property.name) else { continue }
      if let object = value as? Object {
        EasyRealm.cascadeDelete(this: object, in: queue)
      }
    }
    queue.realm.delete(object)
  }
  
}

