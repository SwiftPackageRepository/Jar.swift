import XCTest
@testable import Jar

final class JarTests: XCTestCase {
    func testJavaVirtualMachines() throws {
        let java = Java()
        java.javaVirtualMachines.installed.forEach { javaVirtualMachine in
            XCTAssertNotNil(javaVirtualMachine.version)
            XCTAssertNotNil(javaVirtualMachine.platform)
            XCTAssertNotNil(javaVirtualMachine.name)
            XCTAssertNotNil(javaVirtualMachine.distributor)
            XCTAssertNotNil(javaVirtualMachine.path)
        }
    }

    func testJavaVirtualMachine() throws {
        let java = Java()
        if let executable = java.javaVirtualMachines.current?.executable {
            let fileExists = FileManager.default.fileExists(atPath: executable.path)
            XCTAssertTrue(fileExists)
        }
    }
}
