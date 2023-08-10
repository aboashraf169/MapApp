//
//  LocationViewModel.swift
//  MapApp
//
//  Created by mido mj on 8/8/23.
//

import Foundation
import MapKit
import SwiftUI
 
class LocationViewModel : ObservableObject {
    @Published var locations : [Location]
    @Published var maplocation : Location{
        didSet{
            updateMapRegion(location: maplocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
      
    @Published var showLocationList: Bool = false
    
    @Published var sheetLocation  : Location? = nil  
    

    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.maplocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location : Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span : mapSpan)
        }
        
    }
     func toggleLocationsList (){
        withAnimation(.easeInOut){
            showLocationList = !showLocationList 
        }
    }
    func showNextLocation(location : Location){
        withAnimation(.easeInOut){
             maplocation = location
            showLocationList = false 
        }
    }
    func nextButtonPressed(){
         // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == maplocation }) else{
            print("Cloud not found current index in locations array! Should never happen.")
            return
        }
        // check if the currentIndex is Volid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index in Not volid
            // Restart from 0
            guard let firstLocation = locations.first else { return  }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index Is Valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
}
