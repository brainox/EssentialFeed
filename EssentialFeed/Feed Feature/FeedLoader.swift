//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 01/06/2023.
//

import Foundation

/**
 An enumeration representing the result of loading a feed.
 
 - `success`: Indicates a successful feed loading operation with an associated array of `FeedItem` instances.
 - `failure`: Indicates a failure in the feed loading operation with an associated `Error`.
 
 Use this enumeration to convey the outcome of loading a feed in your application.
 
 - Note: To handle the result of a feed loading operation, use the associated values of this enumeration.
 
 */
public enum LoadFeedResult {
    /// Indicates a successful feed loading operation with an associated array of `FeedItem` instances.
    case success([FeedItem])
    
    /// Indicates a failure in the feed loading operation with an associated `Error`.
    case failure(Error)
}

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
