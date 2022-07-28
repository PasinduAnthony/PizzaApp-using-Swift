//
//  FavouriteList.swift
//  PizzaApplication
//
//  Created by Pasindu on 2022-05-13.
//

import SwiftUI

struct FavouriteList: View {
    @State var image : Data = .init(count:0)
    @FetchRequest(entity: Pizza.entity(), sortDescriptors: [], predicate: NSPredicate(format: "isFavourite = %d", true)) var favourites: FetchedResults<Pizza>
     
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
                .foregroundColor: UIColor.black,
                       .font : UIFont(name:"Helvetica Neue", size: 40)!]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                List(favourites) { favourite in
                    HStack {
                        Image(uiImage: UIImage(data: favourite.imageD ?? self.image)!)
                            .resizable()
                            .frame(width: 100, height: 100)
                        VStack{
                        Text(favourite.name ?? "")
                            .foregroundColor(Color.black)
                            .font(.custom("Helvetica Neue", size: 20, relativeTo: .headline))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(favourite.type ?? "")
                            .foregroundColor(Color.black)
                            .font(.custom("Helvetica Neue", size: 15, relativeTo: .headline))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }

                }
                    .background(
                            Image("background")
                                .background(.black)
                                .opacity(0.4)
                        )
            }.navigationBarTitle(Text("FAVOURITE"))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
       
}

struct FavouriteList_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteList()
    }
}
