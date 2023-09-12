//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Obinna on 08/09/2023.
//

import XCTest
import EssentialFeed

protocol HTTPSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask
}

protocol HTTPSessionTask {
    func resume()
}

class URLSessionHTTPClent {
    private let session: HTTPSession
    
    init(session: HTTPSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { _, _, error in
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        // Arrange (setup)
        let url = URL(string: "http://any-url.com")!
        let session = HTTPSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
         
        let sut = URLSessionHTTPClent(session: session)

        // Act
        // `get` is invoked with the url.
        sut.get(from: url) { _ in }
        
        // Expect task to call resume we invoke the get method with the right URL.
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    func test_getFromURL_failsOnRequestError() {
        let url = URL(string: "http://any-url.com")!
        let error = NSError(domain: "any error", code: 1)
        let session = HTTPSessionSpy()
        session.stub(url: url, error: error)
        
        let sut = URLSessionHTTPClent(session: session)

        // Act
        // `get` is invoked with the url and a completion.
        let exp = expectation(description: "Wait for completion")
        sut.get(from: url) { result in
            switch result {
            case let .failure(receivedError as NSError):
                XCTAssertEqual(receivedError, error)
            default:
                XCTFail("Expected failure with error \(error), got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private class HTTPSessionSpy: HTTPSession {
        
        private var stubs = [URL: Stub]()
        
        private struct Stub {
            let task: HTTPSessionTask
            let error: Error?
        }
        
        func stub(url: URL,
                  task: HTTPSessionTask = FakeURLSessionDataTask(),
                  error: Error? = nil) {
            stubs[url] = Stub(task: task, error: error)
        }
        
        /// Everytime we invoke the dataTask(with urL: ), we capture the URL in the receivedURLs array.
        /// - Parameters:
        ///   - url: The url we pass into the data task.
        ///   - completionHandler: The completion handler that is called after the request have completed.
        /// - Returns: A mock implementation of the dataTask.
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask {
            
            guard let stub = stubs[url] else {
                fatalError("Couldn't find stub for \(url)")
            }
            completionHandler(nil, nil, stub.error)
            return stub.task
        }
    }
    
    private class FakeURLSessionDataTask: HTTPSessionTask {
        func resume() {}
    }
    
    private class URLSessionDataTaskSpy: HTTPSessionTask {
        var resumeCallCount = 0
        
        func resume() {
            resumeCallCount += 1
        }
    }
}


