import Foundation

extension String: Archivable {
    
    public static func compress(value: String) -> Archive {
        return .String(value)
    }
    
    public static func decompress(archive: Archive) throws -> String {
        switch archive {
        case .String(let string):
            return string
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension UInt: Archivable {
    
    public static func compress(value: UInt) -> Archive {
        return .Number(NSNumber(unsignedInteger: value))
    }
    
    public static func decompress(archive: Archive) throws -> UInt {
        switch archive {
        case .Number(let number):
            return number.unsignedIntegerValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Int: Archivable {

    public static func compress(value: Int) -> Archive {
        return .Number(NSNumber(integer: value))
    }
    
    public static func decompress(archive: Archive) throws -> Int {
        switch archive {
        case .Number(let number):
            return number.integerValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension UInt8: Archivable {
    
    public static func compress(value: UInt8) -> Archive {
        return .Number(NSNumber(unsignedChar: value))
    }
    
    public static func decompress(archive: Archive) throws -> UInt8 {
        switch archive {
        case .Number(let number):
            return number.unsignedCharValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Int8: Archivable {
    
    public static func compress(value: Int8) -> Archive {
        return .Number(NSNumber(char: value))
    }
    
    public static func decompress(archive: Archive) throws -> Int8 {
        switch archive {
        case .Number(let number):
            return number.charValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension UInt16: Archivable {
    
    public static func compress(value: UInt16) -> Archive {
        return .Number(NSNumber(unsignedShort: value))
    }
    
    public static func decompress(archive: Archive) throws -> UInt16 {
        switch archive {
        case .Number(let number):
            return number.unsignedShortValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Int16: Archivable {
    
    public static func compress(value: Int16) -> Archive {
        return .Number(NSNumber(short: value))
    }
    
    public static func decompress(archive: Archive) throws -> Int16 {
        switch archive {
        case .Number(let number):
            return number.shortValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension UInt32: Archivable {
    
    public static func compress(value: UInt32) -> Archive {
        return .Number(NSNumber(unsignedInt: value))
    }
    
    public static func decompress(archive: Archive) throws -> UInt32 {
        switch archive {
        case .Number(let number):
            return number.unsignedIntValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Int32: Archivable {
    
    public static func compress(value: Int32) -> Archive {
        return .Number(NSNumber(int: value))
    }
    
    public static func decompress(archive: Archive) throws -> Int32 {
        switch archive {
        case .Number(let number):
            return number.intValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension UInt64: Archivable {
    
    public static func compress(value: UInt64) -> Archive {
        return .Number(NSNumber(unsignedLongLong: value))
    }
    
    public static func decompress(archive: Archive) throws -> UInt64 {
        switch archive {
        case .Number(let number):
            return number.unsignedLongLongValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Int64: Archivable {
    
    public static func compress(value: Int64) -> Archive {
        return .Number(NSNumber(longLong: value))
    }
    
    public static func decompress(archive: Archive) throws -> Int64 {
        switch archive {
        case .Number(let number):
            return number.longLongValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Float: Archivable {
    
    public static func compress(value: Float) -> Archive {
        return .Number(NSNumber(float: value))
    }
    
    public static func decompress(archive: Archive) throws -> Float {
        switch archive {
        case .Number(let number):
            return number.floatValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Double: Archivable {
    
    public static func compress(value: Double) -> Archive {
        return .Number(NSNumber(double: value))
    }
    
    public static func decompress(archive: Archive) throws -> Double {
        switch archive {
        case .Number(let number):
            return number.doubleValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

extension Bool: Archivable {
    
    public static func compress(value: Bool) -> Archive {
        return .Number(NSNumber(bool: value))
    }
    
    public static func decompress(archive: Archive) throws -> Bool {
        switch archive {
        case .Number(let number):
            return number.boolValue
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

public extension Optional where Wrapped: Archivable, Wrapped == Wrapped.ArchivedType {
    
    public static func compress(value: Wrapped?) -> Archive {
        switch value {
        case .Some(let value):
            return Wrapped.compress(value)
        case .None:
            return .Null
        }
    }
    
    public static func decompress(archive: Archive) throws -> Wrapped? {
        
        do {
            return try Wrapped.decompress(archive)
        } catch {
            throw ArchiverError.NoValueFound
        }
    }
}

public extension CollectionType where Generator.Element: Archivable, Generator.Element == Generator.Element.ArchivedType {
    
    public static func compress(value: [Generator.Element]) -> Archive {
        return .Array(value.map(Generator.Element.compress))
    }
    
    public static func decompress(archive: Archive) throws -> [Generator.Element] {
        switch archive {
        case .Array(let array):
            return try array.map(Generator.Element.decompress)
        default:
            throw ArchiverError.NoValueFound
        }
    }
}

public extension DictionaryLiteralConvertible where Value: Archivable, Value == Value.ArchivedType {

    public static func compress(value: [String : Value]) -> Archive {
        return .Object(value.map(Value.compress))
    }
    
    public static func decompress(archive: Archive) throws -> [String : Value] {
        switch archive {
        case .Object(let object):
            return try object.map(Value.decompress)
        default:
            throw ArchiverError.NoValueFound
        }
    }
}
