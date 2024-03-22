//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Obinna on 30/08/2023.
//

import Foundation

/**
 An enumeration representing the result of an HTTP client operation.
 
 - `success`: Indicates a successful HTTP operation with associated data and an HTTPURLResponse.
 - `failure`: Indicates a failure in the HTTP operation with an associated `Error`.
 
 Use this enumeration to convey the outcome of HTTP client operations in your application.
 
 - Note: To handle the result of an HTTP client operation, use the associated values of this enumeration.
 
 */
public enum HTTPClientResult {
    /// Indicates a successful HTTP operation with associated data and an HTTPURLResponse.
    case success(Data, HTTPURLResponse)
    
    /// Indicates a failure in the HTTP operation with an associated `Error`.
    case failure(Error)
}

/**
 A protocol defining the contract for an HTTP client.
 
 An HTTP client is responsible for making HTTP requests asynchronously and providing the result via a completion closure.
 
 Implement this protocol to create custom HTTP client functionality within your application.
 
 */
public protocol HTTPClient {
    /**
     Performs an HTTP GET request to the specified URL asynchronously and provides the result via a completion closure.
     
     The completion handler can be invoked in any thread.
     Clients are responsible to dispatch to appropriate threads, if needed.
     
     - Parameter url: The URL to which the GET request should be made.
     - Parameter completion: A closure that takes an `HTTPClientResult` as its parameter. 
     - `HTTPClientResult`: The result of the HTTP GET request, either success or failure.
     
     Implementations of this method should make the HTTP GET request and call the `completion` closure when the request is complete.
     
     */
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
