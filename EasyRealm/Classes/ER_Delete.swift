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


public extension EasyRealmStatic where T:Object {
  
  public func deleteAll() throws {
    let realm = try Realm()
    try realm.write {
      realm.delete(realm.objects(self.baseType))
    }
  }
  
}

public extension EasyRealm where T:Object {
  public func delete() throws {
    self.isManaged ? try managed_delete() : try unmanaged_delete()
  }
}



fileprivate extension EasyRealm where T: Object {
  
  fileprivate func managed_delete() throws {
    guard let rq = RealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    let ref = ThreadSafeReference(to: self.base)
    try rq.queue.sync {
      guard let object = rq.realm.resolve(ref) else { throw EasyRealmError.ObjectCantBeResolved }
      try rq.realm.write {
        rq.realm.delete(object)
      }
    }
  }
  
  fileprivate func unmanaged_delete() throws  {
    guard let rq = RealmQueue() else { throw EasyRealmError.RealmQueueCantBeCreate }
    guard let key = T.primaryKey() else { throw EasyRealmError.ObjectCantBeResolved }
  
    try rq.queue.sync {
      let value = self.base.value(forKey: key)
      if let object = rq.realm.object(ofType: T.self, forPrimaryKey: value) {
        try rq.realm.write {
          rq.realm.delete(object)
        }
      }
    }
  
  }
  
  
}

