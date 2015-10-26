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
        case let v as [AnyObject]:
            return .Array(v.map(decode))
        case let v as [Swift.String: AnyObject]:
            return .Object(v.map(decode))
        case let v as Swift.String:
            return .String(v)
        case let v as NSNumber:
            return .Number(v)
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
    
    public static func decompress(archive: Archive) throws -> Archive {
        return archive
    }
}

extension Archive: CustomStringConvertible {
   
    public var description: Swift.String {
        switch self {
        case let .String(v): return "String(\(v))"
        case let .Number(v): return "Number(\(v))"
        case let .Array(a): return "Array(\(a.description))"
        case let .Object(o): return "Object(\(o.description))"
        case .Null: return "Null"
        }
    }
}

extension Archive: Equatable { }

public func == (lhs: Archive, rhs: Archive) -> Bool {
    switch (lhs, rhs) {
    case let (.String(l), .String(r)):
        return l == r
    case let (.Number(l), .Number(r)):
        return l == r
    case let (.Array(l), .Array(r)):
        return l == r
    case let (.Object(l), .Object(r)):
        return l == r
    case (.Null, .Null): return true
    default:
        return false
    }
}
