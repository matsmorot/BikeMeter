//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Robert Karlsson on 05/02/16.
//  Copyright © 2016 Your School. All rights reserved.
//

import Foundation

class Stopwatch {
    
    fileprivate var startTime: Date?
    var isRunning: Bool {
        return startTime != nil
    }
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        }
        else {
            return 0
        }
    }
    
    func start() {
        startTime = Date()
    }
    
    func stop() {
        startTime = nil
    }
    
    func changeDirection() {
        
    }
}
