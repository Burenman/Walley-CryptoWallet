//
//  ContentView.swift
//  Walley
//
//  Created by Viktor on 2023-11-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {

            Dashboard()
                .tabItem() {
                    Label("Dashboard", systemImage: "dollarsign.square.fill")
                }
                .tag("Dashboard")
            
            Assets()
                .tabItem{
                    Label("Assets", systemImage: "creditcard.circle")
                }
                    .tag("Assets")
                
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag("Profile")
                
            }
            
        }
    }
    


#Preview {
    ContentView()
}
