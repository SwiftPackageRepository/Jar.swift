import Foundation
import Jar

struct HelloWorld {
    static func run() {
        print("== Installed JVMs")
        let url = URL(string: "https://repo1.maven.org/maven2/org/vafer/helloworld/1.0/helloworld-1.0.jar")!
        let jar = Jar(origin: url, filename: "helloworld.jar")
        let java = Java()
        java.r
    }
}

