//
//  SettingsViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-27.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class SettingItem {

    enum SettingType {
        case Switch
    }
    
    let title: String;
    let type: SettingType;
    var action: (() -> Void)? = nil
    
    init(title: String, type: SettingType) {
        self.title = title
        self.type = type
    }
    
    init(title: String, type: SettingType, action: (() -> Void)) {
        self.title = title
        self.type = type
        self.action = action
    }
}

class SettingsViewController: UIViewController {
    static let metricDistanceKey = "metricDistances"
    
    private static let settingsCellIdentifier = "settingsCellIdentifier"
    
    private let tableView = UITableView()
    private var settings = [String:[SettingItem]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        self.view.backgroundColor = UIColor.greenColor()
        
        settings = ["Map":
            [
                SettingItem(title: "Distance in Metric", type: .Switch, action: self.toggleMetricDistance)
            ]
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: SettingsViewController.settingsCellIdentifier)
        
        self.view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = self.view.bounds
    }
    
    func toggleMetricDistance() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let isMetric = defaults.valueForKey(SettingsViewController.metricDistanceKey) as? Bool {
            defaults.setObject(!isMetric, forKey: SettingsViewController.metricDistanceKey)
        }
    }
}

extension SettingsViewController: UITableViewDelegate { }

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(settings.keys)[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(settings.values)[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SettingsViewController.settingsCellIdentifier, forIndexPath: indexPath)
        
        let setting = Array(settings.values)[indexPath.section][indexPath.row]
        cell.accessoryView = UISwitch()
        cell.textLabel?.text = setting.title
        cell.textLabel?.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        cell.textLabel?.textColor = UIColor.blackColor()
        
        return cell
    }
    
}
