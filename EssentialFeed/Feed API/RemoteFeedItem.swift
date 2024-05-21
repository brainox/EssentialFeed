//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Obinna on 18/02/2024.
//

import Foundation

 struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
