<h3 align="center">
  <a href="https://github.com/PoissonBallon/EasyRealm">
    <img src="Ressources/easy_realm_logo.png" width="200" />
    <br />
    EasyRealm
  </a>
</h3>

------

# EasyRealm

[![Version](https://img.shields.io/cocoapods/v/EasyRealm.svg?style=flat)](http://cocoapods.org/pods/EasyRealm)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/EasyRealm.svg?style=flat)](http://cocoapods.org/pods/EasyRealm)

[![Build Status](https://travis-ci.org/PoissonBallon/EasyRealm.svg?branch=master)](https://travis-ci.org/PoissonBallon/EasyRealm)
[![Swift 3](https://img.shields.io/badge/Language-Swift%203-orange.svg)](https://developer.apple.com/swift/)
[![Coverage Status](https://coveralls.io/repos/github/PoissonBallon/EasyRealm/badge.svg?branch=master)](https://coveralls.io/github/PoissonBallon/EasyRealm?branch=master)
[![License](https://img.shields.io/cocoapods/l/EasyRealm.svg?style=flat)](http://cocoapods.org/pods/EasyRealm)

EasyRealm is a micro-framework (less than 200 LOC) that helps you use Realm.

## Promise

EasyRealm make 4 promises :

* EasyRealm never transform secretly an unmanaged Object to a managed Object and vice-versa.
* EasyRealm let you use managed and unmanaged objects identically.
* EasyRealm never manipulate thread behind your back, you keep full control of your process flow.
* EasyRealm never handle Error for you.

## Features

### Using

* No inheritance.
* No protocol.
* Import Framework
* Enjoy

### Save

To save an object :

```swift
let pokemon = Pokemon()
try! pokemon.er.save(update: true)
//OR
let managed = try! pokemon.mr.saved(update: true)
```

### Edit

To edit an object :

```swift
let pokemon = Pokemon()

try! pokemon.er.edit {
  $0.level = 42
}
```


### Delete

To delete an object :

```swift
let pokemon = Pokemon(name: "Pikachu")

try! pokemon.er.delete()
```

To delete all objects :
```swift
try! Pokemon.er.deleteAll()
```

### Queries

To query all objects of one type :
```swift
let pokemons = try! Pokemon.er.all()
```

To query one object by its primaryKey :
```swift
let pokemon = Pokemon.er.fromRealm(with: "Pikachu")
```

### Helping Variables

* isManaged :
```swift
pokemon.er.isManaged // Return true if realm != nil and return false if realm == nil
```

* managed :
```swift
pokemon.er.managed // Return the managed version of the object if one exist in Realm Database
```

* unmanaged :
```swift
pokemon.er.unmanaged // Return an unmanaged version of the object
```


## Installation

EasyRealm is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

#### CocoaPods
```ruby
use_frameworks!
pod "EasyRealm", '~> 1.0.0'
```

#### Carthage
```ruby
github 'PoissonBallon/EasyRealm'
```

## Author



## License

EasyRealm is available under the MIT license. See the LICENSE file for more info.

## Other

* Thanks to [@error32](http://savinien.net/) for logo 
* Thanks to [@trpl](https://github.com/trpl) for text review
