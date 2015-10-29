//import Tabularium
//
//struct TestModel {
//    let numerics: TestModelNumerics
//    let string: String
//    let bool: Bool
//    let array: [String]
//    let arrayOpt: [String]?
//    let dict: [String : String]
//    let dictOpt: [String : String]?
//    let userOpt: User?
//}
//
//extension TestModel: Archivable {
//    
//    static func compress(value: TestModel) -> Archive {
//        
//        let numerics: Archive = TestModelNumerics.compress(value.numerics)
//        let string: Archive = .String(value.string)
//        let bool: Archive = .Number(value.bool)
//        let array: Archive = Array<String>.compress(value.array)
//        let arrayOpt: Archive = {
//            if let arrayOpt = value.arrayOpt {
//                return Array<String>.compress(arrayOpt)
//            } else {
//                return .Null
//            }
//        }()
//        let dict: Archive = Dictionary<String, String>.compress(value.dict)
//        let dictOpt: Archive = {
//            if let dictOpt = value.dictOpt {
//                return Dictionary<String, String>.compress(dictOpt)
//            } else {
//                return .Null
//            }
//        }()
//        let userOpt: Archive = {
//            if let userOpt = value.userOpt {
//                return User.compress(userOpt)
//            } else {
//                return .Null
//            }
//        }()
//        
//        return .Object([
//            "numerics" : numerics,
//            "string" : string,
//            "bool" : bool,
//            "array" : array,
//            "arrayOpt" : arrayOpt,
//            "dict" : dict,
//            "dictOpt" : dictOpt,
//            "userOpt" : userOpt
//            ])
//    }
//    
//    static func decompress(archive: Archive) throws -> TestModel {
//        
//        if case .Object(let object) = archive {
//            
//            let numerics: TestModelNumerics = try .decompress(.fromOptional(object["numerics"]))
//            let string: String = try .decompress(.fromOptional(object["string"]))
//            let bool: Bool = try .decompress(.fromOptional(object["bool"]))
//            let array: [String] = try .decompress(.fromOptional(object["array"]))
//            let arrayOpt: [String]? = try? .decompress(.fromOptional(object["arrayOpt"]))
//            let dict: [String : String] = try .decompress(.fromOptional(object["dict"]))
//            let dictOpt: [String : String]? = try? .decompress(.fromOptional(object["dictOpt"]))
//            let userOpt: User? = try? .decompress(.fromOptional(object["userOpt"]))
//            
//            return TestModel(numerics: numerics, string: string, bool: bool, array: array, arrayOpt: arrayOpt, dict: dict, dictOpt: dictOpt, userOpt: userOpt)
//        } else {
//            throw ArchiveError.TypeMismatch(expected: "Object", actual: "\(archive)")
//        }
//    }
//}
//
//struct TestModelNumerics {
//    let int: Int
//    let uint: UInt
//    let int8: Int8
//    let uint8: UInt8
//    let int16: Int16
//    let uint16: UInt16
//    let int32: Int32
//    let uint32: UInt32
//    let int64: Int64
//    let uint64: UInt64
//    let float: Float
//    let double: Double
//    let intOpt: Int?
//}
//
//extension TestModelNumerics: Archivable {
//    
//    static func compress(value: TestModelNumerics) -> Archive {
//        
//        let int: Archive = .Number(value.int)
//        let uint: Archive = .Number(value.uint)
//        let int8: Archive = Int8.compress(value.int8)
//        let uint8: Archive = UInt8.compress(value.uint8)
//        let int16: Archive = Int16.compress(value.int16)
//        let uint16: Archive = UInt16.compress(value.uint16)
//        let int32: Archive = Int32.compress(value.int32)
//        let uint32: Archive = UInt32.compress(value.uint32)
//        let int64: Archive = Int64.compress(value.int64)
//        let uint64: Archive = UInt64.compress(value.uint64)
//        let float: Archive = .Number(value.float)
//        let double: Archive = .Number(value.double)
//        let intOpt: Archive = {
//            if let intOpt = value.intOpt {
//                return .Number(intOpt)
//            } else {
//                return .Null
//            }
//        }()
//        
//        return .Object([
//            "int" : int,
//            "uint" : uint,
//            "int8" : int8,
//            "uint8" : uint8,
//            "int16" : int16,
//            "uint16" : uint16,
//            "int32" : int32,
//            "uint32" : uint32,
//            "int64" : int64,
//            "uint64" : uint64,
//            "float" : float,
//            "double" : double,
//            "intOpt" : intOpt,
//            ])
//    }
//    
//    static func decompress(archive: Archive) throws -> TestModelNumerics {
//        
//        if case .Object(let object) = archive {
//            
//            let int: Int = try .decompress(.fromOptional(object["int"]))
//            let uint: UInt = try .decompress(.fromOptional(object["uint"]))
//            let int8: Int8 = try .decompress(.fromOptional(object["int8"]))
//            let uint8: UInt8 = try .decompress(.fromOptional(object["uint8"]))
//            let int16: Int16 = try .decompress(.fromOptional(object["int16"]))
//            let uint16: UInt16 = try .decompress(.fromOptional(object["uint16"]))
//            let int32: Int32 = try .decompress(.fromOptional(object["int32"]))
//            let uint32: UInt32 = try .decompress(.fromOptional(object["uint32"]))
//            let int64: Int64 = try .decompress(.fromOptional(object["int64"]))
//            let uint64: UInt64 = try .decompress(.fromOptional(object["uint64"]))
//            let float: Float = try .decompress(.fromOptional(object["float"]))
//            let double: Double = try .decompress(.fromOptional(object["double"]))
//            let intOpt: Int? = try? .decompress(.fromOptional(object["intOpt"]))
//            
//            return TestModelNumerics(int: int, uint: uint, int8: int8, uint8: uint8, int16: int16, uint16: uint16, int32: int32, uint32: uint32, int64: int64, uint64: uint64, float: float, double: double, intOpt: intOpt)
//        } else {
//            throw ArchiveError.TypeMismatch(expected: "Object", actual: "\(archive)")
//        }
//    }
//}
//
//struct User {
//    let id: Int
//    let name: String
//    let email: String?
//}
//
//extension User: Archivable {
//    
//    static func compress(value: User) -> Archive {
//        
//        let id: Archive = .Number(value.id)
//        let name: Archive = .String(value.name)
//        let email: Archive = {
//            if let email = value.email {
//                return .String(email)
//            } else {
//                return .Null
//            }
//        }()
//        
//        return .Object([
//            "id" : id,
//            "name" : name,
//            "email" : email
//            ])
//    }
//    
//    static func decompress(archive: Archive) throws -> User {
//        
//        if case .Object(let object) = archive {
//            
//            let id: Int = try .decompress(.fromOptional(object["id"]))
//            let name: String = try .decompress(.fromOptional(object["name"]))
//            let email: String? = try? .decompress(.fromOptional(object["email"]))
//            
//            return User(id: id, name: name, email: email)
//        } else {
//            throw ArchiveError.TypeMismatch(expected: "Object", actual: "\(archive)")
//        }
//    }
//}
