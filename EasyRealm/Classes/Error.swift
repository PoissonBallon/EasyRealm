//
//  ER_Error.swift
//  Pods
//
//  Created by Allan Vialatte on 17/02/2017.
//
//

import Foundation

public enum EasyRealmError: Error {
  case RealmQueueCantBeCreate
  case ObjectCantBeResolved
  case ObjectHaveNotPrimaryKey
  case ObjectWithPrimaryKeyNotFound
  case ManagedVersionOfObjectDoesntExist
}
