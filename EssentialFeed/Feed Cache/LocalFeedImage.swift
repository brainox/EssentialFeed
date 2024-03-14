//
//  LocalFeedImage.swift
//  EssentialFeed
//
//  Created by Obinna on 18/02/2024.
//

import Foundation

public struct LocalFeedImage: Equatable, Codable {
    /// A universally unique identifier (UUID) representing the item.
    public let id: UUID
    
    /// An optional description for the item. It can be `nil` if no description is provided.
    public let description: String?
    
    /// An optional location string indicating where the item was posted. It can be `nil` if no location is specified.
    public let location: String?
    
    /// The URL pointing to the image associated with the item.
    public let url: URL
    
    /**
     Initializes a new `LocalFeedImage` instance.
     
     - Parameters:
        - id: A universally unique identifier (UUID) representing the item.
        - description: An optional description for the item. It can be `nil` if no description is provided.
        - location: An optional location string indicating where the item was posted. It can be `nil` if no location is specified.
        - url: The URL pointing to the image associated with the item.
     
     - Important: The `id` parameter must be a valid UUID.
     
     - Returns: A new `LocalFeedImage` instance initialized with the provided values.
     */
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}
