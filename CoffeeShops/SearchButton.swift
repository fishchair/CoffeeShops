//
//  SearchButton.swift
//  CoffeeShops
//
//  Created by Luke Rohrer on 9/22/23.
//

import SwiftUI
import MapKit

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button (
                    action: {self.text = ""},
                    label: {
                        Image(systemName: "x.circle")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

struct SearchButton: View {
    
    // binding variable to hold search results
    @Binding var searchResults: [MKMapItem]
    
    // hold search text
    @State private var searchText: String = ""
    @FocusState private var isFieldFocused: Bool

    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .fish_house,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        )
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
    
    func executeSearch(for query: String) {
        // TODO display some info about search results
        search(for: query)
    }

    var body: some View {
        HStack{
            
            Spacer()
            
            TextField ("", 
                       text: $searchText,
                       prompt: Text("Search for a coffee shop").foregroundColor(.gray))
                .modifier(TextFieldClearButton(text: $searchText))
                .padding()
                .background(Color.white).cornerRadius(20)
                .foregroundColor(.black)
                .onSubmit {
                    executeSearch(for: searchText)
                }
                .focused($isFieldFocused)
            
            Button {
                isFieldFocused = false
                executeSearch(for: searchText)
            } label: {
                Label("Coffee Shops", systemImage:"cup.and.saucer.fill")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .labelStyle(.iconOnly) // remove this when above is implemented
    }
}

#Preview {
    MapView()
}
