//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Obinna Aguwa on 14/06/2023.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {

        // Arrange or Given
        // "Given a url, a client and a sut"
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        // Act or When
        // "When we invoke`sut.load()`"
        sut.load { _ in }

        // Assert or Then
        // Then assert that a URL request was initiated in the client.
        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestsDataFromURLTwice() {

        // Arrange or Given
        // "Given a url, a client and a sut"
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        // Act or When
        // "When we invoke`sut.load()` twice"
        sut.load { _ in }
        sut.load { _ in }

        // Assert or Then
        // Then assert that a URL request was initiated in the client.
        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        // Arrange:
        // Given the sut and its HTTP client spy.
        let (sut, client) = makeSUT()
        
        // Act:
        // When we tell the sut to load and we complete the client's HTTP request with an error.
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        // Assert:
        // Then we expect the captured load error to be a connectivity error.
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        // Arrange:
        // Given the sut and its HTTP client spy.
        let (sut, client) = makeSUT()
        
        // Act:
        // When we tell the sut to load and we complete the client's HTTP request with an error.
        var samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            var capturedErrors = [RemoteFeedLoader.Error]()
            sut.load { capturedErrors.append($0) }
            
           
            client.complete(withStatusCode: code, at: index)
            
            // Assert:
            // Then we expect the captured load error to be a connectivity error.
            XCTAssertEqual(capturedErrors, [.invalidData])
        }
        
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (Error?, HTTPURLResponse?) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (Error?, HTTPURLResponse?) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(error, nil)
        }
        
        func complete(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )
            messages[index].completion(nil, response)
        }
    }
}
