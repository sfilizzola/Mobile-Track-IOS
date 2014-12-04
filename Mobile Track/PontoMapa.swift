//
//  PontoMapa.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 28/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import MapKit
import UIKit

class PontoMapa: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var title: String!
    var subtitle: String!
    var image:UIImage?
    var isCarro:Bool = true
    
    init(newCoordinate: CLLocationCoordinate2D, newTitle: String, newSubTitle: String) {
        self.coordinate = newCoordinate
        self.title = newTitle
        self.subtitle = newSubTitle
    }
    
}