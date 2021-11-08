///
/// Jvm.swift
/// 
/// 
/// Created by Sascha Müllner on 08.11.21.
/// Unauthorized copying or usage of this file, via any medium is strictly prohibited.
/// Proprietary and confidential.
/// Copyright © 2021 Webblazer EG. All rights reserved.

import Foundation
import Jar

struct Jvm {
    static func printAll() {
        print("== Installed JVMs")
        Java().javaVirtualMachines.installed.forEach { javaVirtualMachine in
            print(javaVirtualMachine)
        }
    }

    static func printCurrent() {
        print("== Current JVM")
        if let current = Java().javaVirtualMachines.current {
            print(current)
        }
    }
}
