//
//  EasyRealmCore.swift
//  Pods
//
//  Created by Allan Vialatte on 17/02/2017.
//
//

import Foundation
import RealmSwift


internal struct EasyRealmQueue {
  let realm:Realm
  let queue:DispatchQueue
  
  init?() {
    queue = DispatchQueue(label: UUID().uuidString)
    var tmp:Realm? = nil
    queue.sync { tmp = try? Realm() }
    guard let valid = tmp else { return nil }
    self.realm = valid
  }
}
