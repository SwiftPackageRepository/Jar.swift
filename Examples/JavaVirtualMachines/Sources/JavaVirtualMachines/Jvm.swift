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
