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
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let locationLabel = UILabel()
    
    private let foundButton = UIButton()
    
    func drawTitle() {
        self.titleLabel.text = cache.name
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        self.titleLabel.textColor = UIColor.blackColor()
        self.titleLabel.font = UIFont.systemFontOfSize(20)
        
        self.view.addSubview(self.titleLabel)
    }
    
    func drawDescription() {
        self.descriptionLabel.text = cache.description
        self.descriptionLabel.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        self.descriptionLabel.textColor = UIColor.blackColor()
        self.descriptionLabel.font = UIFont.systemFontOfSize(15)
        
        self.view.addSubview(self.descriptionLabel)
    }
    
    func drawLocation() {
        self.locationLabel.text = "Lat: \(cache.location.latitude), Lon: \(cache.location.longitude)"
        self.locationLabel.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50)
        self.locationLabel.textColor = UIColor.blackColor()
        self.locationLabel.font = UIFont.systemFontOfSize(12)
        
        self.view.addSubview(self.locationLabel)
    }
    
    func drawButton() {
        self.foundButton.titleLabel?.textColor = UIColor.whiteColor()
        self.foundButton.titleLabel?.textAlignment = .Center
        self.foundButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.foundButton.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.height, height: 100)
        
        if (self.cache.found != nil) { // found
            self.foundButton.backgroundColor = UIColor.greenColor()
            self.foundButton.titleLabel?.text = "Find"
        } else {
            self.foundButton.backgroundColor = UIColor.redColor()
            self.foundButton.titleLabel?.text = "Forget"
        }

        self.view.addSubview(self.foundButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.drawTitle()
        self.drawDescription()
        self.drawLocation()
        self.drawButton()
    }
    
    init(cache: Cache) {
        self.cache = cache
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
