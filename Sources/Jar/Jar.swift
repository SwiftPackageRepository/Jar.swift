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

public struct Jar {

    private let jars = URL(fileURLWithPath:"/Users/Shared/.java/jars/")
    public private(set) var origin: URL?
    public private(set) var pathToJar: URL?

    public init(origin: URL, filename: String) {
        self.origin = origin
        self.pathToJar = jars.appendingPathComponent(filename)
    }

    public init(path: URL) {
        self.pathToJar = path
    }

    public func bootstrap(_ completion: @escaping (URL) -> Void, failed: @escaping (Error) -> Void) {
        guard let origin = self.origin else {
            return
        }
        guard let pathToJar = self.pathToJar else {
            return
        }
        if FileManager.default.fileExists(atPath: pathToJar.path) {
            completion(pathToJar)
            return
        }
        if !FileManager.default.fileExists(atPath: jars.path) {
            do {
                try FileManager.default.createDirectory(atPath: jars.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
                failed(error)
                return
            }
        }
        URLSession.shared.dataTask(with: origin) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                try data.write(to: pathToJar, options: [])
            } catch {
                print(error.localizedDescription)
                failed(error)
                return
            }
            DispatchQueue.main.async {
                completion(pathToJar)
            }
        }
        .resume()
    }

    public func bootstrap() -> (url: URL?, error: Error?) {
        let semaphore = DispatchSemaphore(value: 0)
        var resultURL: URL?
        var resultError: Error?
        bootstrap { url in
            resultURL = url
            semaphore.signal()
        } failed: { error in
            resultError = error
            semaphore.signal()
        }
        semaphore.wait()
        return (resultURL, resultError)
    }
}
