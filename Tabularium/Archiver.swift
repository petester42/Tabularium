import Foundation

public protocol KeyedArchiver {
    static func archive(rootObject: AnyObject, toFile path: String) -> Bool
}

extension NSKeyedArchiver: KeyedArchiver {
    public static func archive(rootObject: AnyObject, toFile path: String) -> Bool {
        return self.archiveRootObject(rootObject, toFile: path)
    }
}

public protocol KeyedUnarchiver {
    static func unarchive(objectWithFile path: String) -> AnyObject?
}

extension NSKeyedUnarchiver: KeyedUnarchiver {
    public static func unarchive(objectWithFile path: String) -> AnyObject? {
        return self.unarchiveObjectWithFile(path)
    }
}

public func archive<Value: Archivable where Value == Value.ArchivedType>(keyedArchived: KeyedArchiver.Type = NSKeyedArchiver.self, object: Value, toFile path: String) throws  {
    
    guard keyedArchived.archive(Encoder<Value>(object), toFile: path) else {
        throw ArchiverError.ArchiveFailed
    }
}

public func unarchive<Value: Archivable where Value == Value.ArchivedType>(keyedUnarchiver: KeyedUnarchiver.Type = NSKeyedUnarchiver.self, objectWithFile path: String) throws -> ArchiveResult<Value> {
    
    guard let unarchived = keyedUnarchiver.unarchive(objectWithFile: path) as? Encoder<Value> else {
        throw ArchiverError.UnarchiveFailed
    }
    
    return unarchived.value
}

internal class Encoder<Value: Archivable where Value == Value.ArchivedType>: NSObject, NSCoding {
    
    private let value: ArchiveResult<Value>
    
    private init(_ _value: Value) {
        value = .Success(_value)
        super.init()
    }
    
    // MARK - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let decompressedObject = aDecoder.decodeObject() else {
            value = .Failure(.EmptyArchive)
            super.init()
            return
        }
        
 
        value = Value.decompress(Archive.decode(decompressedObject))
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        guard case .Success(let value) = value else {
            // This should never happen
            return
        }
        
        aCoder.encodeObject(Archive.encode(Value.compress(value)))
    }
}
