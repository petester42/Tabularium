import Foundation

func +<Key, Value>(var lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    
    for (key, val) in rhs {
        lhs[key] = val
    }
    
    return lhs
}

extension Dictionary {
    func map<T>(f: Value -> T) -> [Key : T] {
        return self.reduce([:]) { $0 + [$1.0: f($1.1)] }
    }
}