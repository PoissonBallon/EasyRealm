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

public final class EasyRealmStatic<T> {
  internal var baseType:T.Type
  
  public init(_ instance: T.Type) {
    self.baseType = instance
  }
}

public protocol EasyRealmCompatible {
  associatedtype CompatibleType
  var er: EasyRealm<CompatibleType> { get }
  static var er: EasyRealmStatic<CompatibleType> { get }
}

public extension EasyRealmCompatible {
  public var er: EasyRealm<Self> {
    get { return EasyRealm(self) }
  }
  public static var er: EasyRealmStatic<Self> {
    get { return EasyRealmStatic(Self.self) }
  }
}


extension Object:EasyRealmCompatible {}
