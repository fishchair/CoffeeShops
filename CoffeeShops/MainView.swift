//
//  MainView.swift
//  CoffeeShops
//
//  Created by Luke Rohrer on 9/21/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home", systemImage:"house.fill")
                }
            MapView()
                .tabItem{
                    Label("Map",systemImage:"map")
                }
            AddView()
                .tabItem{
                    Label("Add", systemImage:"plus.app")
                }
            ListView()
                .tabItem{
                    Label("List", systemImage:"list.bullet")
                }
        }
    }
}

#Preview {
    MainView()
}
