//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Obinna on 08/09/2023.
//

import XCTest

class URLSessionHTTPClent {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        // Arrange (setup)
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        let sut = URLSessionHTTPClent(session: session)

        // Act
        // `get` is invoked with the url.
        sut.get(from: url)
        
        // Expect task to call resume we invoke the get method with the right URL.
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        
        private var stubs = [URL: URLSessionDataTask]()
        
        func stub(url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
        
        /// Everytime we invoke the dataTask(with urL: ), we capture the URL in the receivedURLs array.
        /// - Parameters:
        ///   - url: The url we pass into the data task.
        ///   - completionHandler: The completion handler that is called after the request have completed.
        /// - Returns: A mock implementation of the dataTask.
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount = 0
        
        override func resume() {
            resumeCallCount += 1
        }
    }
}


