//
//  EasyRealm.swift
//  Pods
//
//  Created by Allan Vialatte on 23/11/16.
//
//

import RealmSwift


public final class EasyRealmStatic<T> {
  internal var baseType:T.Type

  public init(_ instance: T.Type) {
    self.baseType = instance
  }
}

public protocol EasyRealmStaticCompatible {
  associatedtype CompatibleType
  static var er: CompatibleType { get }
}

public extension EasyRealmStaticCompatible {
  public static var er: EasyRealmStatic<Self> {
    get { return EasyRealmStatic(Self.self) }
  }
}

extension Object:EasyRealmStaticCompatible {}
