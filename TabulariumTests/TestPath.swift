import Foundation

public func testPath() -> String {
    
    class TestBundle { }
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
    let path = documentsPath?.stringByAppendingString("/Test") ?? ""

    return path
}