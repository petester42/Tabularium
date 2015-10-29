import Foundation

extension String: Archivable {
    
    public static func compress(value: String) -> Archive {
        return .String(value)
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<String> {
        switch archive {
        case .String(let string):
            return .Success(string)
        default:
            return .typeMismatch("String", actual: archive)
        }
    }
}

extension UInt: Archivable {
    
    public static func compress(value: UInt) -> Archive {
        return .Number(NSNumber(unsignedInteger: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<UInt> {
        switch archive {
        case .Number(let number):
            return .Success(number.unsignedIntegerValue)
        default:
            return .typeMismatch("UInt", actual: archive)
        }
    }
}

extension Int: Archivable {

    public static func compress(value: Int) -> Archive {
        return .Number(NSNumber(integer: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Int> {
        switch archive {
        case .Number(let number):
            return .Success(number.integerValue)
        default:
            return .typeMismatch("Int", actual: archive)
        }
    }
}

extension UInt8: Archivable {
    
    public static func compress(value: UInt8) -> Archive {
        return .Number(NSNumber(unsignedChar: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<UInt8> {
        switch archive {
        case .Number(let number):
            return .Success(number.unsignedCharValue)
        default:
            return .typeMismatch("UInt8", actual: archive)
        }
    }
}

extension Int8: Archivable {
    
    public static func compress(value: Int8) -> Archive {
        return .Number(NSNumber(char: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Int8> {
        switch archive {
        case .Number(let number):
            return .Success(number.charValue)
        default:
            return .typeMismatch("Int8", actual: archive)
        }
    }
}

extension UInt16: Archivable {
    
    public static func compress(value: UInt16) -> Archive {
        return .Number(NSNumber(unsignedShort: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<UInt16> {
        switch archive {
        case .Number(let number):
            return .Success(number.unsignedShortValue)
        default:
            return .typeMismatch("UInt16", actual: archive)
        }
    }
}

extension Int16: Archivable {
    
    public static func compress(value: Int16) -> Archive {
        return .Number(NSNumber(short: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Int16> {
        switch archive {
        case .Number(let number):
            return .Success(number.shortValue)
        default:
            return .typeMismatch("Int16", actual: archive)
        }
    }
}

extension UInt32: Archivable {
    
    public static func compress(value: UInt32) -> Archive {
        return .Number(NSNumber(unsignedInt: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<UInt32> {
        switch archive {
        case .Number(let number):
            return .Success(number.unsignedIntValue)
        default:
            return .typeMismatch("UInt32", actual: archive)
        }
    }
}

extension Int32: Archivable {
    
    public static func compress(value: Int32) -> Archive {
        return .Number(NSNumber(int: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Int32> {
        switch archive {
        case .Number(let number):
            return .Success(number.intValue)
        default:
            return .typeMismatch("Int32", actual: archive)
        }
    }
}

extension UInt64: Archivable {
    
    public static func compress(value: UInt64) -> Archive {
        return .Number(NSNumber(unsignedLongLong: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<UInt64> {
        switch archive {
        case .Number(let number):
            return .Success(number.unsignedLongLongValue)
        default:
            return .typeMismatch("UInt64", actual: archive)
        }
    }
}

extension Int64: Archivable {
    
    public static func compress(value: Int64) -> Archive {
        return .Number(NSNumber(longLong: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Int64> {
        switch archive {
        case .Number(let number):
            return .Success(number.longLongValue)
        default:
            return .typeMismatch("Int64", actual: archive)
        }
    }
}

extension Float: Archivable {
    
    public static func compress(value: Float) -> Archive {
        return .Number(NSNumber(float: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Float> {
        switch archive {
        case .Number(let number):
            return .Success(number.floatValue)
        default:
            return .typeMismatch("Float", actual: archive)
        }
    }
}

extension Double: Archivable {
    
    public static func compress(value: Double) -> Archive {
        return .Number(NSNumber(double: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Double> {
        switch archive {
        case .Number(let number):
            return .Success(number.doubleValue)
        default:
            return .typeMismatch("Double", actual: archive)
        }
    }
}

extension Bool: Archivable {
    
    public static func compress(value: Bool) -> Archive {
        return .Number(NSNumber(bool: value))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<Bool> {
        switch archive {
        case .Number(let number):
            return .Success(number.boolValue)
        default:
            return .typeMismatch("Bool", actual: archive)
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
    
    public static func decompress(archive: Archive) -> ArchiveResult<Wrapped?> {
        return .optional(Wrapped.decompress(archive))
    }
}

public extension CollectionType where Generator.Element: Archivable, Generator.Element == Generator.Element.ArchivedType {
    
    public static func compress(value: [Generator.Element]) -> Archive {
        return .Array(value.map(Generator.Element.compress))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<[Generator.Element]> {
        switch archive {
        case .Array(let array):
            return array.reduce(ArchiveResult<[Generator.Element]>.Success([])) { acc, elem in
                print(Generator.Element.decompress(elem))
                return acc
            }
        default:
            return .typeMismatch("Array", actual: archive)
        }
    }
}

public extension DictionaryLiteralConvertible where Value: Archivable, Value == Value.ArchivedType {

    public static func compress(value: [String : Value]) -> Archive {
        return .Object(value.map(Value.compress))
    }
    
    public static func decompress(archive: Archive) -> ArchiveResult<[String : Value]> {
        switch archive {
        case .Object(let object):
            return object.reduce(ArchiveResult<[String : Value]>.Success([:])) { acc, elem in
                print( Value.decompress(elem.1))
                return acc
            }
        default:
            return .typeMismatch("Object", actual: archive)
        }
    }
}

public func decompressArchive(archive: Archive, forKey key: String) -> ArchiveResult<Archive> {
    
    switch archive {
    case .Object(let object):
        return guardNull(key, archive: object[key] ?? .Null)
    default:
        return .typeMismatch("Object", actual: archive)
    }
}

private func guardNull(key: String, archive: Archive) -> ArchiveResult<Archive> {
    switch archive {
    case .Null:
        return .missingKey(key)
    default:
        return .Success(archive)
    }
}
