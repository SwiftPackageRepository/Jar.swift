///
/// MIT License
///
/// Copyright (c) 2021 Sascha Müllner
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
///
/// Created by Sascha Müllner on 07.11.21.
///

import Foundation

public struct Java {
    public private(set) var current: JavaVirtualMachine?

    public init() {
        self.current = javaVirtualMachines.current
    }

    public init(jvm: JavaVirtualMachine) {
        self.current = jvm
    }

    public func run(_ jar: Jar, args: [String]?, _ completion: @escaping (String) -> Void, failed: @escaping (Error) -> Void) {
        guard let pathToJar = jar.pathToJar else {
            return
        }
        jar.bootstrap { url in
            do {
                let result = try run(pathToJar: pathToJar, args: args)
                completion(result)
            } catch {
                failed(error)
            }
        } failed: { error in
            failed(error)
        }
    }

    public func run(jar: Jar, args: [String]) -> (results: String?, error: Error?) {
        let (pathToJar, bootstrapError) = jar.bootstrap()
        if bootstrapError != nil {
            return (nil, bootstrapError)
        }
        guard let pathToJar = pathToJar else {
            return (nil, nil)
        }
        do {
            let result = try run(pathToJar: pathToJar, args: args)
            return (result, nil)
        } catch {
            return (nil, error)
        }
    }

    public func run(pathToJar: URL, args: [String]?) throws -> String {
        return try run(pathToJar: pathToJar.path, args: args)
    }

    public func run(pathToJar: String, args: [String]?) throws -> String {
        guard let current = current ?? javaVirtualMachines.current else {
            return ""
        }
        var jargs = ["-jar", pathToJar]
        if let args = args {
            jargs += args
        }
        let javaVirtualMachine = Executable(url: current.executable)
        return javaVirtualMachine.run(args: jargs)
    }

    public var javaVirtualMachines: (installed: [JavaVirtualMachine], current: JavaVirtualMachine?) {
        let javaHome = Executable(path: "/usr/libexec/java_home")
        let result = javaHome.run(args: ["-V"])
        var lines = result
            .components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
        _ = lines.removeFirst() // Matching Java Virtual Machines (2)
        let currentJvmPath = URL(fileURLWithPath: lines.removeLast())
        let jvms = lines.compactMap { line in
            if let jvm = JavaVirtualMachineParser.from(line: line) {
                return jvm
            }
            return nil
        } as [JavaVirtualMachine]
        let currentJvm = jvms.first(where: { $0.path == currentJvmPath })
        return (jvms, currentJvm)
    }
}
