# Jar.swift

## jar runner for macos

Jar.swift is **created and maintaned with ❥** by Sascha Muellner.

---
[![Swift](https://github.com/SwiftPackageRepository/Jar.swift/workflows/Swift/badge.svg)](https://github.com/SwiftPackageRepository/Jar.swift/actions?query=workflow%3ASwift)
[![codecov](https://codecov.io/gh/SwiftPackageRepository/Jar.swift/branch/main/graph/badge.svg)](https://codecov.io/gh/SwiftPackageRepository/Jar.swift)
[![License](https://img.shields.io/github/license/SwiftPackageRepository/Jar.swift)](https://github.com/SwiftPackageRepository/Jar.swift/blob/main/LICENSE)
![Version](https://img.shields.io/github/v/tag/SwiftPackageRepository/Jar.swift)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSwiftPackageRepository%2FJar.swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/SwiftPackageRepository/Jar.swift)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSwiftPackageRepository%2FJar.swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/SwiftPackageRepository/Jar.swift)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-orange.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![README](https://img.shields.io/badge/-README-lightgrey)](https://SwiftPackageRepository.github.io/Jar.swift)


## What?
This is a **Swift** package with support for macOS that allows to start Java Jar's with the default or a custom JVM. 

## Requirements

The latest version of Jar requires:

- Swift 5+
- macOS 10.12+
- Xcode 11+

## Installation

### Swift Package Manager
Using SPM add the following to your dependencies

``` 'Jar', 'main', 'https://github.com/SwiftPackageRepository/Jar.swift.git' ```

## How to use?

### Run a remote Jar

For running a remote Jar the only requirement is creating a Jar reference with the origin of the Jar and the locale name for the cache.
After creating a Java runtime reference the Jar can be just "executed".

```swift      
    let jar = Jar(origin: URL(string: "https://domain.com/your.jar"), filename: "your.jar")
    let java = Java()
    let (result, error) = java.run(jar: jar, args: [])
```

or more complete for running the HelloWorld.jar:

```swift
import Foundation
import Jar

struct HelloWorld {
    static func run() {
        let url = URL(string: "https://github.com/slaminatl/Helloworld/raw/master/out/artifacts/HelloWorld_jar/HelloWorld.jar")!
        let jar = Jar(origin: url, filename: "helloworld.jar")
        let java = Java()
        let (result, error) = java.run(jar: jar, args: [])
        if let result = result {
            print(result)
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
}
```
