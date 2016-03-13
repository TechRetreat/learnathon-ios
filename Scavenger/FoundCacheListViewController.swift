//
//  FoundCacheListViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-12.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class FoundCacheListViewController: CacheListViewController {
    
    func getFoundLocations() {
        DataModel.sharedModel.updateCaches()
        let allCaches = DataModel.sharedModel.caches.map{ $1 }
        let foundCaches = allCaches.filter {
            $0.found != nil
        }
        self.caches = foundCaches
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        getFoundLocations()
    }
}
