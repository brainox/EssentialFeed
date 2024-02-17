//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 18/01/2024.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void

    func deleteCachedFeed(completion: @escaping DeletionCompletion)

    func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}

public struct LocalFeedItem: Equatable {
    /// A universally unique identifier (UUID) representing the item.
    public let id: UUID
    
    /// An optional description for the item. It can be `nil` if no description is provided.
    public let description: String?
    
    /// An optional location string indicating where the item was posted. It can be `nil` if no location is specified.
    public let location: String?
    
    /// The URL pointing to the image associated with the item.
    public let imageURL: URL
    
    /**
     Initializes a new `FeedItem` instance.
     
     - Parameters:
        - id: A universally unique identifier (UUID) representing the item.
        - description: An optional description for the item. It can be `nil` if no description is provided.
        - location: An optional location string indicating where the item was posted. It can be `nil` if no location is specified.
        - imageURL: The URL pointing to the image associated with the item.
     
     - Important: The `id` parameter must be a valid UUID.
     
     - Returns: A new `FeedItem` instance initialized with the provided values.
     */
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
