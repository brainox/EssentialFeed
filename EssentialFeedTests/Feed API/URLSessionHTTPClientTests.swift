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
        session.dataTask(with: url) { _, _, _ in
            
        }
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_creaesDataTaskWithURL() {
        // Arrange (setup)
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClent(session: session)

        // Act
        // `get` is invoked with the url.
        sut.get(from: url)
        
        // Assert (Expectation)
        // Expect SUT to create a dataTask from the session with the received URL
        XCTAssertEqual(session.receivedURLs, [url])
    }
    
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        
        var receivedURLs = [URL]()
        
        /// Everytime we invoke the dataTask(with urL: ), we capture the URL in the receivedURLs array.
        /// - Parameters:
        ///   - url: The url we pass into the data task.
        ///   - completionHandler: The completion handler that is called after the request have completed.
        /// - Returns: A mock implementation of the dataTask.
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(url)
            return FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {}
}


