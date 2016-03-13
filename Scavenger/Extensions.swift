//
//  Extensions.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-12.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import Foundation
import MapKit

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

