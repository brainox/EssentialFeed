//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 01/06/2023.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

/**
 A protocol defining the contract for a feed loader.
 
 A feed loader is responsible for loading feed data asynchronously and providing the result via a completion closure.
 
 Implement this protocol to create custom feed loading functionality within your application.
 
 */

public protocol FeedLoader {
    /**
     Loads feed data asynchronously and provides the result via a completion closure.
     
     - Parameter completion: A closure that takes a `LoadFeedResult` as its parameter.
     - `LoadFeedResult`: The result of the feed loading operation, either success or failure.
     
     Implementations of this method should call the `completion` closure when the feed loading operation is complete.
     
     */
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
