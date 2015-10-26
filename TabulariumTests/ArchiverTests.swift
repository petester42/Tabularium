import XCTest
@testable import Tabularium

struct LoginInfo: Archivable {
    
    let password: String
    
    static func compress(value: LoginInfo) -> Archive {
        return .Object(["password" : .String(value.password)])
    }
    
    static func decompress(archive: Archive) throws -> LoginInfo {
        
        if case .Object(let object) = archive {
            
            let password: String = try .decompress(.fromOptional(object["password"]))
            return LoginInfo(password: password)
        
        } else {
            throw ArchiverError.NoValueFound
        }
    }
}

extension LoginInfo: Equatable { }

func ==(lhs: LoginInfo, rhs: LoginInfo) -> Bool {
    return lhs.password == rhs.password
}

struct User: Archivable {
    
    let name: String
    let loginInfo: LoginInfo
    
    static func compress(value: User) -> Archive {
        return .Object(["name" : .String(value.name), "login_info" : LoginInfo.compress(value.loginInfo)])
    }
    
    static func decompress(archive: Archive) throws -> User {
        
        if case .Object(let object) = archive {
            
            let name: String = try .decompress(.fromOptional(object["name"]))
            let loginInfo: LoginInfo = try .decompress(.fromOptional(object["login_info"]))

            return User(name: name, loginInfo: loginInfo)
            
        } else {
            throw ArchiverError.NoValueFound
        }
    }
}

extension User: Equatable { }

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name && lhs.loginInfo == rhs.loginInfo
}

class ArchiverTests: XCTestCase {
    
    var user: User!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        user = User(name: "Test Name", loginInfo: LoginInfo(password: "Super Secret"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArchiving() {
        
        class TestBundle { }
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        let path = documentsPath?.stringByAppendingString("/User") ?? ""
        
        print(path)
        
        do {
            try Archiver<User>.archive(user, toFile: path)
            let decompressed = try Archiver<User>.unarchive(objectWithFile: path)
            XCTAssert(decompressed == user)
        } catch {
            XCTFail()
        }
    }
}
