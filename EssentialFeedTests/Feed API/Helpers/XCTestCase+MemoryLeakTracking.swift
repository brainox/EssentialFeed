
//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Obinna on 18/09/2023.
//

import XCTest

extension XCTestCase {
    /// Tracks an instance for potential memory leaks by adding a teardown block to check if the instance has been deallocated.
    /// - Parameters:
    ///   - instance: The object to track for memory leaks.
    ///   - file: The source file where the method is called. Default value is the file where the method is used.
    ///   - line: The line number in the source file where the method is called. Default value is the line number where the method is used.
    func trackForMemoryLeaks(_ instance: AnyObject,
                                     file: StaticString = #filePath,
                                     line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
