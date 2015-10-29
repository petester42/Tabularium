import Foundation

public enum ArchiverError: ErrorType {
    case ArchiveFailed
    case UnarchiveFailed
}

extension ArchiverError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .ArchiveFailed:
            return "ArchiveFailed"
        case .UnarchiveFailed:
            return "UnarchiveFailed"
        }
    }
}

public enum ArchiveError: ErrorType {
    case EmptyArchive
    case MissingKey(String)
    case TypeMismatch(expected: String, actual: String)
    case Custom(String)
}

extension ArchiveError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .EmptyArchive:
            return "EmptyArchive"
        case .MissingKey(let key):
            return "MissingKey(\(key))"
        case .TypeMismatch(expected: let expected, actual: let actual):
            return "TypeMismatch(Expected \(expected), Actual \(actual))"
        case .Custom(let custom):
            return "Custom(\(custom))"
        }
    }
}

