import Foundation
import Jar

struct HelloWorld {
    static func run() {
        print("== Running helloworld.jar")
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

