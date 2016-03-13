//
//  MenuViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-02-28.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    private let tableView = UITableView()
    private let menus = ["Map", "My Found Locations", "Nearby", "Settings"]
    private let controllers = [MapViewController(), FoundCachesListViewController(), ClosestCachesViewController()]
    private let menuCellIdentifier = "menuCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Menu"
        
        self.view.backgroundColor = UIColor.greenColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.frame = self.view.bounds
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: menuCellIdentifier)
        
        self.view.addSubview(tableView)
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.row < controllers.count) {
            let VC = controllers[indexPath.row]
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(menuCellIdentifier, forIndexPath: indexPath)
        
        let menuTitle = menus[indexPath.row]
        cell.textLabel?.text = menuTitle
        cell.textLabel?.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
}
