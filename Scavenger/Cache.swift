//
//  Location.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-12.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import Foundation
import MapKit

class Cache {
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
    
    init(json: [String:AnyObject]) {
        if let name = json["name"] as? String,
           let desc = json["description"] as? String,
           let diff = json["difficulty"] as? Int,
           let location = json["location"] as? [String:AnyObject],
           let long = location["longitude"] as? Double,
           let lat = location["latitude"] as? Double {
            
            self.name = name
            self.description = desc
            self.difficulty = diff
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            assert(false, "JSON FORMAT IS BAD") // stop right here
            self.name = ""
            self.description = ""
            self.difficulty = 0
            self.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
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


class DataModel {
    static let sharedModel = DataModel()
    
    var caches = [String:Cache]()
    
    init() {
        self.updateCaches()
    }
    
    enum DataModelError: ErrorType {
        case InvalidFormat
    }
    
    func updateCaches() { // Returns a dictionary of String ids to the cache object
        do {
            if let path = NSBundle.mainBundle().pathForResource("caches", ofType: "json") {
                if let jsonData = NSData(contentsOfFile: path) {
                    guard let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? [String:[String:AnyObject]] else {
                        print("We gucci")
                        throw DataModelError.InvalidFormat
                    }
                    caches = [String:Cache]() // clear out old caches
                    for (id, object) in jsonResult {
                        let cache = Cache(json: object)
                        caches[id] = cache
                    }
                }
            }
        } catch {
            print("Something went wrong...")
        }
    }
    
    func findCache(id: String) {
        if let cache = self.caches[id] { // if the cache exists
            cache.foundItem(atTime: NSDate())
        }
    }
}