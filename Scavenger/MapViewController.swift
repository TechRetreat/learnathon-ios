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
        
        let sfAnnotation = Annotation(title: "San Fran", subtitle: "Dream on Kid", coordinate: CLLocationCoordinate2D(latitude: 37.786996, longitude: -122.419281))
        let bridgeAnnotation = Annotation(title: "Bridge", subtitle: "Linking the dreams", coordinate: CLLocationCoordinate2D(latitude: 37.810000, longitude: -122.477450))
        let wharfAnnotation = Annotation(title: "Wharf", subtitle: "Fish or smthng", coordinate: CLLocationCoordinate2D(latitude: 37.808333, longitude: -122.415556))
        
        self.annotations += [sfAnnotation, bridgeAnnotation, wharfAnnotation]
        
        self.view.backgroundColor = UIColor.greenColor()
        self.allAction()
    }
    
    func allAction() {
        self.mapView.removeAnnotations(self.mapView.annotations)
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
        newRegion.center.latitude = 37.786996
        newRegion.center.longitude = -122.440100
        
        newRegion.span.latitudeDelta = 0.2
        newRegion.span.longitudeDelta = 0.2
        
        self.mapView.setRegion(newRegion, animated: true)
    }
    
    func goToByAnnotation(annotation: Annotation) {
        for a in self.annotations {
            if ((a.coordinate.latitude == annotation.coordinate.latitude) && (a.coordinate.longitude == annotation.coordinate.longitude)) {
                self.mapView .removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotation(annotation)
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