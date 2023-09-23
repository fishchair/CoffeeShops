//
//  MapView.swift
//  CoffeeShops
//
//  Created by Luke Rohrer on 9/21/23.
//

import SwiftUI
import MapKit

// TODO: use Markers as coffee shop locations
// - can add name, systemImage, coordinate
// - will be balloon shape

// TODO: add a .onChange(of: <function>) {position = .automatic} once a search function has been added

// NOTE: Annotation is more customizable

extension CLLocationCoordinate2D {
    static let fish_house = CLLocationCoordinate2D(latitude: 32.81762, longitude: -117.16071)
}

struct MapView: View {
    
    // center map around the house with zoom view of 20k
    @State var position: MapCameraPosition = .region(
        MKCoordinateRegion(center: .fish_house, latitudinalMeters: 10000, longitudinalMeters: 10000)
    )
    
    // state here will capture results form binding in SearchButton
    @State private var searchResults: [MKMapItem] = []
    
    // capture text input
    @State private var searchText: String = ""
    
    var body: some View {
        VStack{
            // show the map
            Map (position: $position) {
                Annotation(
                    "Fish House",
                    coordinate:.fish_house,
                    anchor:.bottom) {
                        Image(systemName: "house.fill")
                            .padding(1)
                            .foregroundStyle(.white)
                            .background(Color.indigo)
                            .cornerRadius(4)
                            .font(.system(size: 8))
                    }
                    .annotationTitles(.hidden)
                
                // display all the search results from SearchButton
                ForEach(searchResults, id: \.self) { result in
                    // TODO: make marker look better
                    Marker(item: result)
                }
                
                UserAnnotation()  // add little blue location dot
            }
            .mapStyle(.standard(elevation: .realistic))  // 3d map
            .mapControls {
                MapUserLocationButton()  // arrow
                MapCompass()  // point north
                MapScaleView()  // distance bar on zoom
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    SearchButton(searchResults: $searchResults)
                        .padding(.bottom)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MapView()
}
