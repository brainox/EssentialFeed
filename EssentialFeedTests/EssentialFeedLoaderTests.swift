//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Obinna Aguwa on 14/06/2023.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
    }
}

class HTTPClient {
    
    // Changing the shared instance a variable
    static var shared = HTTPClient()
    
    func get (from url: URL) {}
}

class HTTPClientSpy: HTTPClient {
    
    override func get(from url: URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()

        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {

        // Arrange or Given

        /// "Given a client and a sut"
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
        
        let sut = RemoteFeedLoader()

        // Act or When

        // "When we invoke`sut.load()`"
        sut.load()

        // Assert or Then

        // Then assert that a URL request was initiated in the client.
        XCTAssertNotNil(client.requestedURL)
    }
}
