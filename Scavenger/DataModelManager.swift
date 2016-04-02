//
//  DataModelManager.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-27.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import Foundation

class DataModelManager {
    // This is a special way so that we can use the same instance of the data model everywhere
    static let sharedModel = DataModelManager()
    
    var caches = [String:Cache]()
    
    init() {
        self.updateCaches()
    }
    
    enum DataModelError: ErrorType {
        case InvalidFormat
    }
    
    func updateCaches() {
        self.loadCaches()
        self.updateFoundStates()
    }
    
    func findCache(id: String) {
        if let cache = self.caches[id] { // if the cache exists
            cache.foundItem(atTime: NSDate())
        }
    }
}


// This extension of the DataModelManager allows use to parse our JSON input
extension DataModelManager {
    func loadCaches() { // Returns a dictionary of String ids to the cache object
        do {
            if let path = NSBundle.mainBundle().pathForResource("caches", ofType: "json") {
                if let jsonData = NSData(contentsOfFile: path) {
                    guard let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? CacheListJSONFormat else {
                        print("We gucci")
                        throw DataModelError.InvalidFormat
                    }
                    caches = [String:Cache]() // clear out old caches
                    for (id, cacheObject) in jsonResult {
                        let cache = Cache(json: cacheObject)
                        caches[id] = cache
                    }
                }
            }
        } catch {
            print("Something went wrong...")
        }
    }
    
    func updateFoundStates() {
        do {
            if let path = NSBundle.mainBundle().pathForResource("found", ofType: "json") {
                if let jsonData = NSData(contentsOfFile: path) {
                    guard let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? [String:[String:Double]] else {
                        print("We gucci")
                        throw DataModelError.InvalidFormat
                    }
                    
                    if let cacheEntry = jsonResult["found_times"] {
                        for (id, time) in cacheEntry {
                            if let cache = self.caches[id] {
                                cache.found = time
                            }
                        }
                    }
                }
            }
        } catch {
            print("Something went wrong...")
        }
        
    }
}