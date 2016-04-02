//
//  SettingsViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-27.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    private static let settingsCellIdentifier = "settingsCellIdentifier"
    
    private let tableView = UITableView()
    private let settings = ["Distance Unit (km/m)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        self.view.backgroundColor = UIColor.greenColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.frame = self.view.bounds
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: SettingsViewController.settingsCellIdentifier)
        
        self.view.addSubview(tableView)
    }
}

extension SettingsViewController: UITableViewDelegate { }

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SettingsViewController.settingsCellIdentifier, forIndexPath: indexPath)
        
        let settingsTitle = settings[indexPath.row]
        cell.textLabel?.text = settingsTitle
        cell.textLabel?.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        cell.textLabel?.textColor = UIColor.blackColor()
        
        return cell
    }
    
}
