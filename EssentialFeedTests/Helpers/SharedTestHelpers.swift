//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Obinna on 09/03/2024.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
