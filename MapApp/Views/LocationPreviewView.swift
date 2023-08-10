//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by mido mj on 8/9/23.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm :  LocationViewModel
 
    var location : Location
    var body: some View {
        
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                 
                imageSection
                NamelocationSection
            }
            VStack(spacing: 8.0){
                
                learnMoreButton
                NextButton

            }
        }.padding(20)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:65)
            ).cornerRadius(10)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green .ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationViewModel() )
    }
}
extension LocationPreviewView{
    
    private  var imageSection : some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
                    .cornerRadius(10)
                
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    private var NamelocationSection : some View {
          
        VStack(alignment: .leading, spacing: 4.0){
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold )
            Text(location.cityName)
                .font(.subheadline)

        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var learnMoreButton : some View {
        Button {
            vm.sheetLocation = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125,height: 35)
            
        }.buttonStyle(.borderedProminent)
    }
    private var NextButton : some View {
            Button {
                vm.nextButtonPressed()
            } label: {
                Text("Next")
                    .font(.headline)
                    .frame(width: 125,height: 35)
                
            }.buttonStyle(.bordered)
    }
    
}
