import Foundation

extension String: Archivable {
    
    public static func compress(value: String) -> Archive {
        return Archive.String(value)
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
