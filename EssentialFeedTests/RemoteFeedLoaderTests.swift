//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Obinna Aguwa on 14/06/2023.
//

import XCTest

class RemoteFeedLoader {
    func load() {

    }
}

class HTTPClient {
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()

        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {

        // Arrange or Given

        /// "Given a client and a sut"
        let client = HTTPClient()
        let sut = RemoteFeedLoader()

        // Act or When

        // "When we invoke`sut.load()`"
        sut.load()

        // Assert or Then

        // Then assert that a URL request was initiated in the client.
        XCTAssertNotNil(client.requestedURL)
    }
}
