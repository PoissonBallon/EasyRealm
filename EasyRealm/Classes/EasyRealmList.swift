//
//  EasyRealmList.swift
//  Pods
//
//  Created by Allan Vialatte on 01/05/2017.
//
//

import Foundation
import RealmSwift


internal protocol EasyRealmList {
  func children() -> [Object]
}

extension List:EasyRealmList {
  internal func children() -> [Object] {
    return self.compactMap { return $0 as? Object }
  }
}
