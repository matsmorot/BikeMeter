//
//  extensions.swift
//  BikeMeter
//
//  Created by Mattias Almén on 2017-03-30.
//  Copyright © 2017 pixlig.se. All rights reserved.
//

import Foundation

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d:%02d:%03d", hour, minute, second, millisecond)
    }
    var hour: Int {
        return Int(self / 3600) % 3600
    }
    var minute: Int {
        return Int(self / 60) % 60
    }
    var second: Int {
        return Int(self) % 60
    }
    var millisecond: Int {
        return Int(self * 1000) % 1000
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}
