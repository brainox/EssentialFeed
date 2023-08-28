//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Obinna Aguwa on 01/06/2023.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
