//
//  EasyRealm.swift
//  Pods
//
//  Created by Allan Vialatte on 23/11/16.
//
//

import RealmSwift


public final class EasyRealm<T> {
  internal var base: T
  
  public init(_ instance: T) {
    self.base = instance
  }
}

public protocol EasyRealmCompatible {
  associatedtype CompatibleType = Object
  var er: CompatibleType { get }
}

public extension EasyRealmCompatible {
  public var er: EasyRealm<Self> {
    get { return EasyRealm(self) }
  }
}

extension Object:EasyRealmCompatible {}
