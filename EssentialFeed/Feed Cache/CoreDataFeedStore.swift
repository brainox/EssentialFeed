//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Obinna on 01/04/2024.
//

import CoreData


public final class CoreDataFeedStore: FeedStore {
    
    public init() {}
    
    public func retrieve(completion: @escaping RetrievalCompletions) {
        completion(.empty)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
    }
}

private class ManagedCache: NSManagedObject {
    @NSManaged var timestamp: Date
    @NSManaged var feed: NSOrderedSet
}

private class ManagedFeedImage: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var imageDescription: String?
    @NSManaged var located: String?
    @NSManaged var url: URLRequest
    @NSManaged var cache: ManagedCache
}
