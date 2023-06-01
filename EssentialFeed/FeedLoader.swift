//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 01/06/2023.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
