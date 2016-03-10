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
    
    static func createViewAnnotationForMapView(mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        var returnedAnnotationView: MKAnnotationView?
        if let _ = mapView.dequeueReusableAnnotationViewWithIdentifier("test") {
            returnedAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("test")!
            returnedAnnotationView!.annotation = annotation
        } else {
            returnedAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            returnedAnnotationView!.canShowCallout = true
        }
        return returnedAnnotationView!
    }
    
    
}