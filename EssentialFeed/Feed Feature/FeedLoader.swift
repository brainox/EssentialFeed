//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 01/06/2023.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
