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
        sut.load()

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
        sut.load()
        sut.load()

        // Assert or Then
        // Then assert that a URL request was initiated in the client.
        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        // Arrange:
        // Given the sut and its HTTP client that will always fail with a given error (stubbed behaviour).
        let (sut, client) = makeSUT()
        client.error = NSError(domain: "Test", code: 0)
        
        // Act:
        // When we tell the sut to load.
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        // Assert:
        // Then we expect the captured load error to be a connectivity error.
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var error: Error?
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            if let error = error {
                completion(error)
            }
            requestedURLs.append(url)
        }
    }
}
