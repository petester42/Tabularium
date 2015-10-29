import XCTest
@testable import Tabularium

class TypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //    func testAllTheTypes() {
    //
    //        let numerics = TestModelNumerics(int: 5, uint: 5, int8: 127, uint8: 255, int16: 32767, uint16: 65535, int32: 2147483647, uint32: 4294967295, int64: 9223372036854775807, uint64: 18446744073709551615, float: 5.5, double: 1.1, intOpt: 5)
    //        let user = User(id: 6, name: "Cool User", email: nil)
    //        let model: TestModel = TestModel(numerics: numerics, string: "test", bool: true, array: ["cool", "array"], arrayOpt: nil, dict: ["cool" : "user"], dictOpt: nil, userOpt: user)
    //
    //        do {
    //
    //            try archive(object: model, toFile: testPath())
    //            let decompressed: TestModel = try unarchive(objectWithFile: testPath())
    //
    //            XCTAssert(decompressed.numerics.int == 5)
    //            XCTAssert(decompressed.numerics.uint == 5)
    //            XCTAssert(decompressed.numerics.int8 == 127)
    //            XCTAssert(decompressed.numerics.uint8 == 255)
    //            XCTAssert(decompressed.numerics.int16 == 32767)
    //            XCTAssert(decompressed.numerics.uint16 == 65535)
    //            XCTAssert(decompressed.numerics.int32 == 2147483647)
    //            XCTAssert(decompressed.numerics.uint32 == 4294967295)
    //            XCTAssert(decompressed.numerics.int64 == 9223372036854775807)
    //            XCTAssert(decompressed.numerics.uint64 == 18446744073709551615)
    //            XCTAssert(decompressed.numerics.float == 5.5)
    //            XCTAssert(decompressed.numerics.double == 1.1)
    //            XCTAssert(decompressed.numerics.intOpt == 5)
    //            XCTAssert(decompressed.string == "test")
    //            XCTAssert(decompressed.bool == true)
    //            XCTAssert(decompressed.array == ["cool", "array"])
    //            XCTAssert(decompressed.arrayOpt == nil)
    //            XCTAssert(decompressed.dict == ["cool" : "user"])
    //            XCTAssert(decompressed.dictOpt == nil)
    //            XCTAssert(decompressed.userOpt?.id == 6)
    //
    //        } catch {
    //            XCTFail()
    //        }
    //    }
    
    func testUser() {
        
        let user = User(id: 6, name: "Cool User", email: nil)
        
        do {
            try archive(object: user, toFile: testPath())
            let decompressed: User = try unarchive(objectWithFile: testPath()).dematerialize()
            
            XCTAssert(decompressed.id == 6)
            XCTAssert(decompressed.name == "Cool User")
            XCTAssert(decompressed.email == nil)
        } catch {
            XCTFail()
        }
    }
}

struct User {
    let id: Int
    let name: String
    let email: String?
}

extension User: Archivable {
    
    static func compress(value: User) -> Archive {
        
        let id: Archive = .Number(value.id)
        let name: Archive = .String(value.name)
        let email: Archive = {
            if let email = value.email {
                return .String(email)
            } else {
                return .Null
            }
        }()
        
        return .Object([
            "id" : id,
            "name" : name,
            "email" : email
            ])
    }
    
    static func decompress(archive: Archive) -> ArchiveResult<User> {
        
        let id: ArchiveResult<Int> = archive <| "id"
        let name: ArchiveResult<String> = archive <| "name"
        let email: ArchiveResult<String?> = archive <|? "email"
        
        do {
            return .Success(try User(id: id.dematerialize(), name: name.dematerialize(), email: email.dematerialize()))
        } catch {
            return .Failure(error as! ArchiveError)
        }
    }
}
