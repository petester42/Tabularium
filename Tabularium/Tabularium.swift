infix operator <| { associativity left precedence 150 }
infix operator <|? { associativity left precedence 150 }
infix operator <|| { associativity left precedence 150 }
infix operator <||? { associativity left precedence 150 }

// MARK: Values

// Pull value from JSON
public func <| <A where A: Archivable, A == A.ArchivedType>(archive: Archive, key: String) -> ArchiveResult<A> {
    return archive <| [key]
}

// Pull optional value from JSON
public func <|? <A where A: Archivable, A == A.ArchivedType>(archive: Archive, key: String) -> ArchiveResult<A?> {
    return .optional(archive <| [key])
}

// Pull embedded value from JSON
public func <| <A where A: Archivable, A == A.ArchivedType>(archive: Archive, keys: [String]) -> ArchiveResult<A> {
//    return flatReduce(keys, initial: archive, combine: decodedJSON) >>- A.decode
    //TODO:
//    let x: ArchiveResult<A> = keys.reduce(.Success(archive)) { acc, elem in
//        return decompressArchive(acc, forKey: elem)
//    }
    
    return .Failure(.EmptyArchive)
}

// Pull embedded optional value from JSON
public func <|? <A where A: Archivable, A == A.ArchivedType>(archive: Archive, keys: [String]) -> ArchiveResult<A?> {
    return .optional(archive <| keys)
}

// MARK: Arrays

// Pull array from JSON
public func <|| <A where A: Archivable, A == A.ArchivedType>(archive: Archive, key: String) -> ArchiveResult<[A]> {
    return archive <|| [key]
}

// Pull optional array from JSON
public func <||? <A where A: Archivable, A == A.ArchivedType>(archive: Archive, key: String) -> ArchiveResult<[A]?> {
    return .optional(archive <|| [key])
}

// Pull embedded array from JSON
public func <|| <A where A: Archivable, A == A.ArchivedType>(archive: Archive, keys: [String]) -> ArchiveResult<[A]> {
//    return keys.reduce(.Success(archive), combine: <#T##(T, String) throws -> T#>)
//    return flatReduce(keys, initial:archivejson, combine: decodedJSON) >>- Array<A>.decode

    //TODO:
    return .Failure(.EmptyArchive)
}

// Pull embedded optional array from JSON
public func <||? <A where A: Archivable, A == A.ArchivedType>(archive: Archive, keys: [String]) -> ArchiveResult<[A]?> {
    return .optional(archive <|| keys)
}
