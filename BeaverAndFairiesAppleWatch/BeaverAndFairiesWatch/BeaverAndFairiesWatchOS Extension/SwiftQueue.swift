//
//  SwiftQueue.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/9/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import Foundation

public struct Queue<T> {
    var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}
