public protocol Archivable {
    
    typealias ArchivedType = Self
    
    static func compress(value: ArchivedType) -> Archive
    static func decompress(archive: Archive) -> ArchiveResult<ArchivedType>
}
