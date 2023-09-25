//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 01/06/2023.
//

import Foundation

/**
 A data structure representing a feed item.
 
 A `FeedItem` contains information about an item in a feed, such as its unique identifier, description, location, and image URL.
 
 - Parameters:
 - id: A universally unique identifier (UUID) representing the item.
 - description: An optional description for the item. It can be `nil` if no description is provided.
 - location: An optional location string indicating where the item was posted. It can be `nil` if no location is specified.
 - imageURL: The URL pointing to the image associated with the item.
 
 - Important: The `id` parameter must be a valid UUID.
 - Note: When `description` or `location` is `nil`, it means the corresponding information is not available.
 */
public struct FeedItem: Equatable {
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
