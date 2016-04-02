//
//  FoundCachesListViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-12.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class FoundCachesListViewController: CacheListViewController {
    
    func getFoundLocations() {
        DataModelManager.sharedModel.updateCaches()
        let allCaches = DataModelManager.sharedModel.caches.map{ key, value in value }
        let foundCaches = allCaches.filter { cache in
            cache.found != nil
        }
        self.caches = foundCaches
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Found Caches"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        getFoundLocations()
    }
}
