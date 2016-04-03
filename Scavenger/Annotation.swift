//
//  Annotation.swift
//  Scavenger
//
//  Created by Paul Bardea on 2016-03-08.
//  Copyright © 2016 Techretreat. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    private static let annotationReuseIdentifier = "annotationReuseIdentifier"
    
    var cache: Cache? {
        didSet {
            self.title = cache?.name
            self.subtitle = cache?.description
            if let loc = cache?.location {
                self.coordinate = loc
            } else {
                self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            }
        }
    }
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    init(cache: Cache) {
        self.cache = cache
        self.title = cache.name
        self.subtitle = cache.description
        self.coordinate = cache.location
    }
    
    static func createViewAnnotationForMapView(mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        var returnedAnnotationView: MKAnnotationView
        if let annotView = mapView.dequeueReusableAnnotationViewWithIdentifier(Annotation.annotationReuseIdentifier) {
            returnedAnnotationView = annotView
            returnedAnnotationView.annotation = annotation
        } else {
            returnedAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Annotation.annotationReuseIdentifier)
            returnedAnnotationView.canShowCallout = true
        }
        return returnedAnnotationView
    }
}