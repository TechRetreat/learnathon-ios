//
//  ClosestCachesViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-13.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit
import CoreLocation

class ClosestCachesViewController: CacheListViewController {
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    func getClosestLocations() {
        let allCaches = DataModelManager.sharedModel.caches.map{ $1 }
        let sortedCaches = allCaches.sort { a, b in
            let locationA = CLLocation(latitude: a.location.latitude, longitude: a.location.longitude)
            let locationB = CLLocation(latitude: b.location.latitude, longitude: b.location.longitude)
            
            if let here = self.currentLocation {
                let distanceToA = locationA.distanceFromLocation(here)
                let distanceToB = locationB.distanceFromLocation(here)
                
                return distanceToA < distanceToB
            } else {
                return a.name < b.name
            }
        }
        
        self.caches = sortedCaches
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Closest Caches"
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.startUpdatingLocation()
        getClosestLocations()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        locationManager.stopUpdatingLocation()
    }
    
}

extension ClosestCachesViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
        getClosestLocations()
    }
}

extension ClosestCachesViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath, withStyle: .Subtitle, andIdentifier: "closetCacheList")
        if let here = self.currentLocation { // If there is a current location
            let cache = self.caches[indexPath.row]
            let cacheLocation = CLLocation(latitude: cache.location.latitude, longitude: cache.location.longitude)
            let distance = cacheLocation.distanceFromLocation(here)/1000
            cell.detailTextLabel?.text = "Distance: \(Double(round(100*distance))/100) km"
        }
        return cell
    }
}