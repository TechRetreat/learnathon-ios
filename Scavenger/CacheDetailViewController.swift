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
        self.titleLabel.textColor = UIColor.blackColor()
        self.titleLabel.font = UIFont.systemFontOfSize(20)
        
        self.view.addSubview(self.titleLabel)
    }
    
    func drawDescription() {
        self.descriptionLabel.text = cache.description
        self.descriptionLabel.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        self.descriptionLabel.textColor = UIColor.blackColor()
        
        self.view.addSubview(self.descriptionLabel)
    }
    
    func drawLocation() {
        self.locationLabel.text = "Lat: \(cache.location.latitude), Lon: \(cache.location.longitude)"
        self.locationLabel.textColor = UIColor.blackColor()
        self.locationLabel.font = UIFont.systemFontOfSize(20)
        
        self.view.addSubview(self.locationLabel)
    }
    
    func toggleFound(button: UIButton) {
        if (self.cache.found != nil) {
            self.cache.loseItem()
            button.backgroundColor = UIColor.greenColor()
            button.setTitle("Find", forState: .Normal)
        } else { // if it is not found
            self.cache.foundItem(atTime: NSDate())
            button.backgroundColor = UIColor.redColor()
            button.setTitle("Forget", forState: .Normal)
        }
    }
    
    func drawButton() {
        self.foundButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.foundButton.titleLabel?.font = UIFont.systemFontOfSize(40)
        self.foundButton.addTarget(self, action: #selector(CacheDetailViewController.toggleFound(_:)), forControlEvents: .TouchUpInside)
        
        if (self.cache.found == nil) { // not found yet
            self.foundButton.backgroundColor = UIColor.greenColor()
            self.foundButton.setTitle("Find", forState: .Normal)
        } else {
            self.foundButton.backgroundColor = UIColor.redColor()
            self.foundButton.setTitle("Forget", forState: .Normal)
        }

        self.view.addSubview(self.foundButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        self.descriptionLabel.font = UIFont.systemFontOfSize(15)
        self.locationLabel.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50)
        self.foundButton.frame = CGRect(x: 0, y: self.view.frame.height - 80, width: self.view.frame.width, height: 80)
        self.foundButton.titleLabel?.frame = self.foundButton.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = self.cache.name
        
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
