//
//  ContentView.swift
//  PizzaApplication
//
//  Created by Pasindu on 2022-03-30.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.gray
    }
    var body: some View {
        TabView{
            PizzaList()
                .tabItem{
                    Label("PizzaList", systemImage: "list.dash")
                }
            FavouriteList()
                .tabItem{
                    Label("Fav", systemImage: "star.fill")
                    
                }
        }.accentColor(.white)
        //ZStack
        //VStack
        //HStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
