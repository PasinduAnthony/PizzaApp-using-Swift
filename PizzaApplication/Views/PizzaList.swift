//
//  PizzaList.swift
//  PizzaApplication
//
//  Created by Pasindu on 2022-03-30.
//

import SwiftUI

struct PizzaList: View {
    @State private var selection = 0
    @State private var isSheetShowing = false
    @State var image : Data = .init(count:0)
    @State var isFavourite = false
    @State var name = ""
    @State var nameSep = [String]()
    @State var imageName : String = "background_multiple"
    @Environment(\.managedObjectContext) var context // Context tells us that we are trying to save data in "THIS" application
 
    
    @FetchRequest(entity: Pizza.entity(), sortDescriptors: []) var pizzas: FetchedResults<Pizza>//get data from coredata
    init() {//styling
         UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
                   .font : UIFont(name:"Helvetica Neue", size: 40)!]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().backgroundColor = .black
        UISegmentedControl.appearance().selectedSegmentTintColor = .lightGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
         
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                    .onChange(of: selection) { sel in
                        if selection == 1 {
                            imageName = "background_cut"
                        }else if selection == 0 {
                            imageName = "background_multiple"
                        }else if selection == 2 {
                            imageName = "background_vege2"
                        }
                    }
                if(selection == 0){
                    Color.black.edgesIgnoringSafeArea(.all)
                        .opacity(0.2)
                }else if(selection == 1){
                    Color.brown.edgesIgnoringSafeArea(.all)
                        .opacity(0.2)
                    //Color.brown
                }else if(selection == 2){
                    Color.green.edgesIgnoringSafeArea(.all)
                        .opacity(0.2)
                    //Color.green
                }
            
            VStack{
                Picker("Pizzas", selection:$selection){
                    Text("All🍕").tag(0)
                    Text("Meat🍗").tag(1)
                    Text("Veggies🥬").tag(2)
                }
                .pickerStyle(.segmented)
                .frame(width: UIScreen.main.bounds.width - 20)
               
                List(pizzas, id: \.name){ pizza in
                    
                    if(selection == 0){
                        NavigationLink {
                            PizzaDetailView(pizza: pizza)
                        } label: {
                            HStack{
                                Image(uiImage: UIImage(data: pizza.imageD ?? self.image)!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text(pizza.name ?? "")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Helvetica Neue", size: 20, relativeTo: .headline))
                                Text(pizza.isFavourite ? Image(systemName:"star.fill") : Image(systemName:"star"))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(Color.blue)
                                        
                                }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                context.delete(pizza)
                                try? context.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                            
                        }
                    }
                    if(selection == 1 &&  pizza.type?.lowercased() == "meat"){
                        NavigationLink {
                            PizzaDetailView(pizza: pizza)
                        } label: {
                            HStack{
                                Image(uiImage: UIImage(data: pizza.imageD ?? self.image)!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text(pizza.name ?? "")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Helvetica Neue", size: 20, relativeTo: .headline))
                                Text(pizza.isFavourite ? Image(systemName:"star.fill") : Image(systemName:"star"))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(Color.blue)
                                        
                                }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                context.delete(pizza)
                                try? context.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                    if(selection == 2 && pizza.type?.lowercased() == "vegetarian"){
                        NavigationLink {
                            PizzaDetailView(pizza: pizza)
                        } label: {
                            HStack{
                                Image(uiImage: UIImage(data: pizza.imageD ?? self.image)!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text(pizza.name ?? "")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Helvetica Neue", size: 20, relativeTo: .headline))
                                Text(pizza.isFavourite ? Image(systemName:"star.fill") : Image(systemName:"star"))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(Color.blue)
                                        
                                }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                context.delete(pizza)
                                try? context.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
                
            .background(
                    Image(imageName)
                        .resizable()
                        .background(.black)
                        .opacity(0.4)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .clipped()
                )
            }
            .navigationBarTitle(Text("PIZZAS"))
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isSheetShowing,
                   content: {
                   NewPizzaView()
            })
            .toolbar{
                ToolbarItem{
                    Button{
                        isSheetShowing.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}




struct PizzaList_Previews: PreviewProvider {
    static var previews: some View {
        PizzaList()
.previewInterfaceOrientation(.portrait)
    }
}
