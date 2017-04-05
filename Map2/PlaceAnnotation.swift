//
//  PlaceAnotation.swift
//  Map2
//
//  Created by Admin on 11/01/1939 Saka.
//  Copyright © 1939 Saka Admin. All rights reserved.
//
import UIKit
import Foundation
import MapKit
import CoreLocation

class PlaceAnnotation:NSObject,MKAnnotation{
    
    var title:String?="";
    var coordinate:CLLocationCoordinate2D =
        CLLocationCoordinate2D()
    
    var type:String="";
    var distance:Float=0.0;
    var color:UIColor
    init(pinColor: UIColor) {
        self.color = pinColor
        super.init()
    }
 
    
}
