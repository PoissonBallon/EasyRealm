//
//  ER_Delete.swift
//  Pods
//
//  Created by Allan Vialatte on 23/11/16.
//
//

import Foundation
import Realm
import RealmSwift

public enum EasyRealmDeleteMethod {
  case simple
  case cascade
}

public extension EasyRealmStatic where T:Object {
  
  public func deleteAll() throws {
    let realm = try Realm()
    try realm.write {
      realm.delete(realm.objects(self.baseType))
    }
  }
  
}

public extension EasyRealm where T:Object {
  
  public func delete(with method:EasyRealmDeleteMethod = .simple) throws {
    switch method {
    case .simple:     self.isManaged ? try managedSimpleDelete() : try unmanagedSimpleDelete()
    case .cascade:    self.isManaged ? try managedCascadeDelete() : try unmanagedCascadeDelete()
    }
  }
  
}



//Normal Way
fileprivate extension EasyRealm where T: Object {
  
  fileprivate func managedSimpleDelete() throws {
    guard let rq = EasyRealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    let ref = ThreadSafeReference(to: self.base)
    try rq.queue.sync {
      guard let object = rq.realm.resolve(ref) else { throw EasyRealmError.ObjectCantBeResolved }
      try rq.realm.write {
        EasyRealm.simpleDelete(this: object, in: rq)
      }
    }
  }
  
  fileprivate func unmanagedSimpleDelete() throws  {
    guard let rq = EasyRealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    guard let key = T.primaryKey() else { throw EasyRealmError.ObjectCantBeResolved }
    
    try rq.queue.sync {
      let value = self.base.value(forKey: key)
      if let object = rq.realm.object(ofType: T.self, forPrimaryKey: value) {
        try rq.realm.write {
          EasyRealm.simpleDelete(this: object, in: rq)
        }
      }
    }
  }
  
  fileprivate static func simpleDelete(this object:Object, in queue:EasyRealmQueue) {
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
      if let list = value as? EasyRealmList {
        list.children().forEach {
          EasyRealm.cascadeDelete(this: $0, in: queue)
        }
      }
    }
    queue.realm.delete(object)
  }
  
}

