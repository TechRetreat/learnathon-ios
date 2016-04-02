//
//  CacheListViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-12.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit

class CacheListViewController: UIViewController {
    private let tableView = UITableView()
    private let cacheListIdentifier = "cacheListIdentifier"
    
    var caches = [Cache]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.frame = self.view.bounds
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cacheListIdentifier)
        
        self.view.addSubview(tableView)
    }
}

extension CacheListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.row < caches.count) {
            let VC = CacheDetailViewController(cache: caches[indexPath.row])
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

extension CacheListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caches.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cacheListIdentifier, forIndexPath: indexPath)
        
        let cacheTitle = caches[indexPath.row].name
        
        cell.textLabel?.text = cacheTitle
        cell.textLabel?.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        cell.textLabel?.textColor = UIColor.blackColor()
        
        cell.detailTextLabel?.text = "Test?"
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        cell.detailTextLabel?.textColor = UIColor.blackColor()
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, withStyle style: UITableViewCellStyle, andIdentifier id: String) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(id)
        
        if cell == nil {
            cell = UITableViewCell(style: style, reuseIdentifier: id)
        }
        
        let cacheTitle = caches[indexPath.row].name
        
        cell?.textLabel?.text = cacheTitle
        cell?.textLabel?.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell!
    }
    
}
