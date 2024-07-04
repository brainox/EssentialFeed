//
//  FakeRefreshControl.swift
//  EssentialFeediOS
//
//  Created by Obinna on 04/07/2024.
//

import UIKit

public class FakeRefreshControl: UIRefreshControl {
    private var _isRefreshing = false
    
    public override var isRefreshing: Bool { _isRefreshing }
    
    public override func beginRefreshing() {
        _isRefreshing = true
    }
    
    public override func endRefreshing() {
        _isRefreshing = false
    }
}
