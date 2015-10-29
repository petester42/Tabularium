public enum ArchiveResult<T> {
    case Success(T)
    case Failure(ArchiveError)
    
    public var value: T? {
        switch self {
        case let .Success(value): return value
        default: return .None
        }
    }
    
    public var error: ArchiveError? {
        switch self {
        case let .Failure(error): return error
        default: return .None
        }
    }
}

public extension ArchiveResult {
    
    static func optional<T>(x: ArchiveResult<T>) -> ArchiveResult<T?> {
        switch x {
        case .Success(let value):
            return .Success(.Some(value))
        case .Failure(.EmptyArchive):
            return .Success(.None)
        case .Failure(.MissingKey):
            return .Success(.None)
        case .Failure(.TypeMismatch(let x)):
            return .Failure(.TypeMismatch(x))
        case .Failure(.Custom(let x)):
            return .Failure(.Custom(x))
        }
    }
    
    static func fromOptional<T>(x: T?) -> ArchiveResult<T> {
        switch x {
        case let .Some(value):
            return .Success(value)
        case .None:
            return .typeMismatch(".Some(\(T.self))", actual: ".None")
        }
    }
}

public extension ArchiveResult {
    
    static func typeMismatch<T, U: CustomStringConvertible>(expected: String, actual: U) -> ArchiveResult<T> {
        return .typeMismatch(expected, actual: "\(actual)")
    }
    
    static func typeMismatch<T>(expected: String, actual: String) -> ArchiveResult<T> {
        return .Failure(.TypeMismatch(expected: expected, actual: actual))
    }
    
    static func missingKey<T>(name: String) -> ArchiveResult<T> {
        return .Failure(.MissingKey(name))
    }
    
    static func customError<T>(message: String) -> ArchiveResult<T> {
        return .Failure(.Custom(message))
    }
}

extension ArchiveResult: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case let .Success(value): return "Success(\(value))"
        case let .Failure(error): return "Failure(\(error))"
        }
    }
}

public extension ArchiveResult {
    
    func dematerialize() throws -> T {
        switch self {
        case let .Success(value): return value
        case let .Failure(error): throw error
        }
    }
    
    func materialize(f: () throws -> T) -> ArchiveResult<T> {
        do {
            return .Success(try f())
        } catch {
            return .customError("\(error)")
        }
    }
}
