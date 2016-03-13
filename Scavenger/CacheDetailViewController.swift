//
//  CacheDetailViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-12.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class CacheDetailViewController: UIViewController {
    private let cache: Cache

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display cache information
        // Button for "Finding" a cache?
        // Toggle to delete?
    }

    
    init(cache:Cache) {
        self.cache = cache
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
