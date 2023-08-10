//
//  LocationDetailsView.swift
//  MapApp
//
//  Created by mido mj on 8/9/23.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    
    @EnvironmentObject private var vm :  LocationViewModel
    let location : Location

    var body: some View {
        ScrollView  {
            VStack{
                imageSection
                VStack(alignment: .leading ,spacing: 16){
                    titleSection
                    Divider()
                    DescriptionSection
                    Divider()
                    mapLayer
 
                }.frame(maxWidth: .infinity,   alignment: .leading)
                    .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(BackBoutton,alignment: .topLeading)
    }
}

struct LocationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailsView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationViewModel())

    }
}
extension LocationDetailsView {
    private var imageSection : some View {
        TabView{
            ForEach(location.imageNames , id:\.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil :UIScreen.main.bounds.width)
                    .clipped()
            }
            .shadow(color: Color.black.opacity(0.3)
                    ,  radius: 20, x: 0, y: 10)
            
             
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    private var titleSection : some View {
        VStack(alignment: .leading,spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
//                .foregroundColor(.p rimary)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    private var DescriptionSection : some View {
        VStack(alignment: .leading,spacing: 16 ){
            Text(location.description )
                .font(.subheadline )
                 .foregroundColor(.secondary)
            if let url  = URL(string : location.link){
                Link("Read More on Wikpedia",destination: url)
                    .font(.headline)
                    .tint (.blue)
            }
        }
    }
    
    private var mapLayer : some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span:MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))),
            annotationItems: [location]){location in
            MapAnnotation(coordinate: location.coordinates){
                LocationMapAnnotionView()
                    .shadow(radius: 10)
            }
            
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30 )
    }
    
    private var BackBoutton : some View {
        Button {
            vm.sheetLocation = nil
        } label: {
             Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background()
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }

    }
    }

