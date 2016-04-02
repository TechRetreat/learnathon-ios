//
//  MapViewController.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-02-28.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    private var annotations: [Annotation] = []
    private let caches = Array(DataModelManager.sharedModel.caches.values)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map"
        
        // Set up the background colour to avoid lag
        self.view.backgroundColor = UIColor.blackColor()
        
        // Set up the map
        self.mapView.frame = self.view.bounds
        self.mapView.showsUserLocation = true
        self.view.addSubview(self.mapView)
        self.mapView.delegate = self
        
        // TODO: To consider
//        for (_, cache) in caches {
//            annotations.append(Annotation(cache: cache))
//        }
        
        // Create the annotations from those caches
        annotations = caches.map { cache in
            //Annotation(cache: cache)
            let annot = Annotation(title: cache.name, subtitle: cache.description, coordinate: cache.location)
            annot.cache = cache
            return annot
        }
        
        // Add the annotations to the map
        self.mapView.addAnnotations(self.annotations)
        
        // Start off at the default location
        self.goToDefaultLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = true
    }
    
    func goToDefaultLocation() {
        let defaultScale = 0.02
        
        var newRegion = MKCoordinateRegion()
        
        // TODO, to consider
        // Get all of the latitudes and longitudes
        // This is the functional way... should the for-loop method be shown?
        let latitudes = self.annotations.map { $0.coordinate.latitude }
        let longitudes = self.annotations.map { $0.coordinate.longitude }
        
        newRegion.center.latitude = average(latitudes)
        newRegion.center.longitude = average(longitudes)
        
        newRegion.span.latitudeDelta = defaultScale
        newRegion.span.longitudeDelta = defaultScale
        
        self.mapView.setRegion(newRegion, animated: true)
    }
    
    func goToDetail(button: UIButton) {
        let cacheIndex = button.tag
        let cache = self.caches[cacheIndex]
        let VC = CacheDetailViewController(cache: cache)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

// Break this off into an extension of [Double]
extension MapViewController {
    func average(array: [Double]) -> Double { // TODO: Make as an extension of array
        var sum = 0.0
        for element in array {
            sum += element
        }
        return sum / Double(array.count)
    }
    
    func fancyAverage(array: [Double]) -> Double {
        return array.reduce(0, combine: +) / Double(array.count)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(MKUserLocation.self) { return nil }
        
        let returnedAnnotationView = Annotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
        
        let notFoundFlag = UIImage(named: "flag")
        let foundFlag = UIImage(named: "foundFlag")
        
        if let annot = annotation as? Annotation {
            let detailButton = UIButton(type: .DetailDisclosure)
            if let cache = annot.cache {
                if (cache.found == nil) {
                    returnedAnnotationView.image = notFoundFlag
                } else {
                    returnedAnnotationView.image = foundFlag
                }
                
                if let cacheIndex = self.caches.indexOf( {$0 == cache} ) {
                    detailButton.tag = cacheIndex
                    detailButton.addTarget(self, action: #selector(MapViewController.goToDetail(_:)), forControlEvents: .TouchUpInside)
                    returnedAnnotationView.rightCalloutAccessoryView = detailButton
                }
            }
        }
        
        
        
        return returnedAnnotationView
    }
}