import Foundation

public enum Archive {
    case Object([Swift.String : Archive])
    case Array([Archive])
    case String(Swift.String)
    case Number(NSNumber)
    case Null
}

public extension Archive {
    
    static func decode(object: AnyObject) -> Archive {
        switch object {
        case let array as [AnyObject]:
            return .Array(array.map(decode))
        case let dictionary as [Swift.String : AnyObject]:
            return .Object(dictionary.map(decode))
        case let string as Swift.String:
            return .String(string)
        case let number as NSNumber:
            return .Number(number)
        default:
            return .Null
        }
    }
    
    static func encode(archive: Archive) -> AnyObject {
        switch archive {
        case .Object(let object):
            return object.map(encode)
        case .Array(let array):
            return array.map(encode)
        case .String(let string):
            return string
        case .Number(let number):
            return number
        case .Null:
            return NSNull()
        }
    }
}

extension Archive: Archivable {
    
    public static func compress(value: Archive) -> Archive {
        return value
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Archive> {
        return .Success(archive)
    }
}

//public extension CollectionType where Generator.Element == Archive {
//
//    public static func fromOptional(optional: [Archive]?) throws -> [Archive] {
//        switch optional {
//        case .Some(let value):
//            return value
//        case .None:
//            throw ArchiveError.EmptyArchive
//        }
//    }
//}

extension Archive: CustomStringConvertible {
   
    public var description: Swift.String {
        switch self {
        case .Object(let object):
            return "Object(\(object.description))"
        case .Array(let array):
            return "Array(\(array.description))"
        case .String(let string):
            return "String(\(string))"
        case .Number(let number):
            return "Number(\(number))"
        case .Null:
            return "Null"
        }
    }
}

extension Archive: Equatable { }

public func == (lhs: Archive, rhs: Archive) -> Bool {
    switch (lhs, rhs) {
    case let (.Object(l), .Object(r)):
        return l == r
    case let (.Array(l), .Array(r)):
        return l == r
    case let (.String(l), .String(r)):
        return l == r
    case let (.Number(l), .Number(r)):
        return l == r
    case (.Null, .Null):
        return true
    default:
        return false
    }
}
