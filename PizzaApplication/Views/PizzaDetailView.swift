//
//  PizzaDetailView.swift
//  PizzaApplication
//
//  Created by Pasindu on 2022-03-30.
//

import SwiftUI

struct PizzaDetailView: View {
    
    let pizza: Pizza
    @State var image : Data = .init(count:0)
    @Environment(\.managedObjectContext) var context // Context tells us that we are trying to save data in "THIS" application
    @State private var isFavourite: Bool
    
    init(pizza: Pizza) {
        self.pizza = pizza
        self.isFavourite = pizza.isFavourite
    }
    
    var body: some View {
        ZStack {
            if(pizza.type?.lowercased() == "meat"){
                Color.brown.edgesIgnoringSafeArea(.all)
            }else if(pizza.type?.lowercased() == "vegetarian"){
                Color.green.edgesIgnoringSafeArea(.all)
            }
            GeometryReader { reader in // GeometryReader to get the the coordinate space/space of the entire view (screen)
                
                VStack(alignment: .leading) {
                    Image(uiImage: UIImage(data: pizza.imageD ?? self.image)!)
                        .resizable()
                        .frame(width: reader.size.width, height: 200)
                    Text(pizza.name ?? "")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .foregroundColor(Color.white)
                        .font(.custom("Helvetica Neue", size: 40, relativeTo: .headline))
                    Text(pizza.ingredients ?? "")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 0))
                        .foregroundColor(Color.white)
                    Button {
                        print("Object before isFavourite: ", pizza)
                        isFavourite.toggle()
                        pizza.isFavourite = isFavourite
                        try? context.save()
                        print("Object after saving: ", pizza)
                    } label: {
                        Text(isFavourite ? "Favourite" : "not Favourite")
                        Text(isFavourite ? Image(systemName:"star.fill") : Image(systemName:"star"))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color.black)
                }
            }
            
        }
    }
}

//struct PizzaDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PizzaDetailView(pizza: Pizza(name: "", ingredients: "", imageName: "", thumbnailName: "", type: .meat ))
//    }
//}
