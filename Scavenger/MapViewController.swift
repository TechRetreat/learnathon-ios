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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.frame = self.view.bounds
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        
        let caches: [String:Cache] = DataModel.sharedModel.caches
        
        for (_, cache) in caches {
            annotations.append(Annotation(title: cache.name, subtitle: cache.description, coordinate: cache.location))
        }
        
        self.view.backgroundColor = UIColor.blackColor()
        self.mapView.addAnnotations(self.annotations)
        
        self.goToDefaultLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = true
    }
    
    func goToDefaultLocation() {
        var newRegion = MKCoordinateRegion()
        let latitudes = self.annotations.map { $0.coordinate.latitude }
        let longitudes = self.annotations.map { $0.coordinate.longitude }
        let avgLat = Int(latitudes.reduce(0, combine: +))/latitudes.count
        let avgLon = Int(longitudes.reduce(0, combine: +))/longitudes.count
        newRegion.center.latitude = Double(avgLat)
        newRegion.center.longitude = Double(avgLon)
        
        newRegion.span.latitudeDelta = 0.2
        newRegion.span.longitudeDelta = 0.2
        
        self.mapView.setRegion(newRegion, animated: true)
    }
    
    func goToByAnnotation(destAnnot: Annotation) {
        for a in self.annotations {
            if ((a.coordinate.latitude == destAnnot.coordinate.latitude) && (a.coordinate.longitude == destAnnot.coordinate.longitude)) {
                self.mapView .removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotation(destAnnot)
                self.goToDefaultLocation()
            }
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation
        print(annotation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var returnedAnnotationView: MKAnnotationView? = nil
        
        if (!annotation.isKindOfClass(MKUserLocation.self)) {
            returnedAnnotationView = Annotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
            
            returnedAnnotationView?.image = UIImage(named: "flag")
            let sfIconView = UIImageView(image: UIImage(named: "SFIcon"))
            returnedAnnotationView?.leftCalloutAccessoryView = sfIconView
        }
        return returnedAnnotationView
    }
}