//
//  Location.swift
//  MapApp
//
//  Created by mido mj on 8/8/23.
//
import Foundation
import MapKit

import Foundation
struct Location  : Identifiable , Equatable {

    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames : [String]
    let link : String
    var id : String {
        name + cityName 
    }
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
