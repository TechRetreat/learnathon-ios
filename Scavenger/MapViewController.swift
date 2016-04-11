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
    private var caches = [Cache]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the background colour to avoid lag
        self.view.backgroundColor = UIColor.blackColor()
        
        // Set up the map
        self.mapView.showsUserLocation = true
        self.view.addSubview(self.mapView)
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.caches = Array(DataModelManager.sharedModel.caches.values)
        self.mapView.removeAnnotations(self.mapView.annotations) // clear all annotations
        // Create the annotations from those caches
        annotations = caches.map { cache in
            return Annotation(cache: cache)
        }
        
        // TODO: To consider
//        for (_, cache) in caches {
//            annotations.append(Annotation(cache: cache))
//        }
        
        // Add the annotations to the map
        self.mapView.addAnnotations(self.annotations)
        
        // Start off at the default location
        self.goToDefaultLocation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.mapView.frame = self.view.bounds
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

extension MapViewController {
    func average(array: [Double]) -> Double {
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