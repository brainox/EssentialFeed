//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Obinna on 28/01/2025.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
