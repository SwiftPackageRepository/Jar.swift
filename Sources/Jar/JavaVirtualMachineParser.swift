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

public struct JavaVirtualMachineParser {
    public static let pattern = #"(?<version>.*) \((?<platform>.*)\) \"(?<distributor>.*)\" - \"(?<name>.*)\" (?<path>.*)"#
    public static let regex = NSRegularExpression(pattern)

    @available(macOS 10.13, *)
    public static func from(line: String) -> JavaVirtualMachine? {
        let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
        let nsrange = NSRange(trimmed.startIndex..<trimmed.endIndex,
                              in: trimmed)
        if let match = regex.firstMatch(in: trimmed,
                                        options: [],
                                        range: nsrange)
        {
            guard let version = match.find(trimmed, withName: "version") else {
                return nil
            }
            guard let platform = match.find(trimmed, withName: "platform") else {
                return nil
            }
            guard let distributor = match.find(trimmed, withName: "distributor") else {
                return nil
            }
            guard let name = match.find(trimmed, withName: "name") else {
                return nil
            }
            guard let path = match.find(trimmed, withName: "path") else {
                return nil
            }
            return JavaVirtualMachine(
                version: version,
                platform: platform,
                distributor: distributor,
                name: name,
                path: URL(fileURLWithPath: path)
            )
        }
        
        return nil
    }
}
