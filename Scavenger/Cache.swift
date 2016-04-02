//
//  Location.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-12.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import Foundation
import MapKit

typealias CacheListJSONFormat = [String:CacheJSONFormat]
typealias CacheJSONFormat = [String:AnyObject]

typealias LocationJSON = [String:Double]

class Cache: Equatable {
    let name: String
    let description: String
    let difficulty: Int
    var found: Double?
    let location: CLLocationCoordinate2D
    
    init(name: String, description: String, difficulty: Int, location: CLLocationCoordinate2D) {
        self.name = name
        self.description = description
        self.difficulty = difficulty
        self.location = location
    }
    
    // We add the question mark to this initializer, because it could fail if the input format is incorrect
    init?(json: CacheJSONFormat) {
        // This large if statment makes sure everything is of proper format
        if let name = json["name"] as? String,
           let desc = json["description"] as? String,
           let diff = json["difficulty"] as? Int,
           let location = json["location"] as? LocationJSON,
           let long = location["longitude"],
           let lat = location["latitude"] {
            
            self.name = name
            self.description = desc
            self.difficulty = diff
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else { // This code runs if the JSON input format is bad
            print("JSON FORMAT IS INVALID")
            
            // Initialize all of the properties
            self.name = ""
            self.description = ""
            self.difficulty = 0
            self.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            
            return nil
        }
    }
    
    func foundItem(atTime time: Double) {
        self.found = time
    }
    
    func foundItem(atTime time: NSDate) {
        self.found = time.timeIntervalSince1970
    }
    
    func loseItem() {
        self.found = nil
    }
    
    func getDistanceFrom(origin: CLLocationCoordinate2D) -> Int {
        let originLocaiton = CLLocation(latitude: origin.latitude, longitude: origin.longitude)
        
        let distance = originLocaiton.distanceFromLocation(CLLocation(latitude: self.location.latitude, longitude: self.location.longitude))
        
        return Int(distance)
    }
}

func ==(lhs: Cache, rhs: Cache) -> Bool {
    return lhs.name == rhs.name && lhs.description == rhs.description && lhs.difficulty == rhs.difficulty && lhs.found == rhs.found && lhs.location.latitude == rhs.location.latitude && lhs.location.longitude == rhs.location.longitude
}