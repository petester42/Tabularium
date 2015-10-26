import Foundation

public enum ArchiverError: ErrorType {
    case ArchiveFailed
    case UnarchiveFailed
    case NoValueFound
    case KeyNotFound(String)
}

public class Archiver<T: Archivable>: NSObject, NSCoding {
    
    private typealias Value = T.ArchivedType
    private let value: Value?
    
    private init(_ _value: Value) {
        value = _value
        super.init()
    }
    
    // MARK - NSCoding
    
    required public init?(coder aDecoder: NSCoder) {
        
        guard let decompressedObject = aDecoder.decodeObject() else {
            value = nil
            super.init()
            return
        }

        do {
            value = try T.decompress(Archive.decode(decompressedObject))
        } catch {
            value = nil
        }
        
        super.init()
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        
        guard let value = value else {
            // This should never happen
            return
        }
        
        aCoder.encodeObject(Archive.encode(T.compress(value)))
    }
    
//    // MARK - NSSecureCoding
//    
//    public static func supportsSecureCoding() -> Bool {
//        return true
//    }
    
    static public func archive(object: Value, toFile path: String) throws  {
        
        guard NSKeyedArchiver.archiveRootObject(Archiver(object), toFile: path) else {
            throw ArchiverError.ArchiveFailed
        }
    }
    
    static public func unarchive(objectWithFile path: String) throws -> Value {
        
        guard let unarchived = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? Archiver else {
            throw ArchiverError.UnarchiveFailed
        }
        
        guard let value = unarchived.value else {
            throw ArchiverError.NoValueFound
        }
        
        return value
    }
}
