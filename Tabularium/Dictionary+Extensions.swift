import Foundation

func +<Key, Value>(var lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    
    for (key, val) in rhs {
        lhs[key] = val
    }
    
    return lhs
}

extension Dictionary {
    
    func map<T>(f: Value throws -> T) rethrows -> [Key : T] {
        return try self.reduce([:]) { $0 + [$1.0: try f($1.1)] }
    }
}