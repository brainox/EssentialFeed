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

        // Assert:
        // Then we expect the captured load error to be a connectivity error.
        expect(sut, toCompleteWithError: .connectivity) {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        }
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        // Arrange:
        // Given the sut and its HTTP client spy.
        let (sut, client) = makeSUT()

        // Act:
        // When we tell the sut to load and we complete the client's HTTP request with an error.
        let samples = [199, 201, 300, 400, 500]

        
        samples.enumerated().forEach { index, code in
            // Assert:
            // Then we expect the captured load error to be an invalidData error.
            expect(sut, toCompleteWithError: .invalidData) {
                client.complete(withStatusCode: code, at: index)
            }
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        // Assert:
        // Then we expect the captured load error to be a connectivity error
        expect(sut, toCompleteWithError: .invalidData) {
            let invalidJSON = Data("invalidJSON".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }

    private func expect(_ sut: RemoteFeedLoader,
                        toCompleteWithError error: RemoteFeedLoader.Error,
                        when action: () -> Void,
                        file: StaticString = #filePath,
                        line: UInt = #line) {
        var capturedErrors = [RemoteFeedLoader.Result]()
        sut.load { capturedErrors.append($0) }

        action()

        XCTAssertEqual(capturedErrors,
                       [.failure(error)],
                       file: file,
                       line: line)
    }

    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            messages[index].completion(.success(data, response))
        }
    }
}
