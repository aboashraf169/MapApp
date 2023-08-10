//
//  LocationsView.swift
//  MapApp
//
//  Created by mido mj on 8/8/23.
//

import SwiftUI
import MapKit
  struct LocationsView: View {
    @EnvironmentObject private var vm :  LocationViewModel
      let maxWidthForIpad : CGFloat = 700
    var body: some View {
        ZStack {
            
            mapLayer
                VStack(spacing: 0){
            header
            .frame(maxWidth: maxWidthForIpad)

                Spacer()
            locationPreviewStack
            }
              
            }
        .sheet(item: $vm.sheetLocation,
               onDismiss: nil) { location in
            LocationDetailsView(location: location)
        }
        }
} 

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationViewModel() )
    }
}
extension LocationsView {
    private var header : some View {
        
            VStack {
                Button(action: vm.toggleLocationsList){
                    
                    Text(vm.maplocation.name + ",  " + vm.maplocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: vm.maplocation)
                        .overlay(alignment: .leading) {
                           Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                        }
                }
                if vm.showLocationList{
                    LocationsListView()
                    
                }
            }
            .background(.thinMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20,x: 0,y: 15)
            .padding()
            
            
       
    }
    private var mapLayer : some View {
        Map(coordinateRegion:$vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: {location in
            MapAnnotation(coordinate: location.coordinates){
                LocationMapAnnotionView()
                    .scaleEffect(vm.maplocation  == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location:  location)
                    }
            }
        })  .ignoresSafeArea()
    }
    
    private var locationPreviewStack : some View {
        ZStack{
            ForEach(vm.locations) { location in
                if vm.maplocation == location{
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)

                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
                
            }
        }
    }
}
