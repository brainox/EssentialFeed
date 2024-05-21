//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 01/06/2023.
//

import Foundation

/**
 A protocol defining the contract for a feed loader.
 
 A feed loader is responsible for loading feed data asynchronously and providing the result via a completion closure.
 
 Implement this protocol to create custom feed loading functionality within your application.
 
 */
public protocol FeedLoader {
    
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
