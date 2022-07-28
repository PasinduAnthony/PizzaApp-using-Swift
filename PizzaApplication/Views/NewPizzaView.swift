//
//  NewPizzaView.swift
//  PizzaApplication
//
//  Created by Pasindu on 2022-03-30.
//

import SwiftUI

struct NewPizzaView: View {
    
    @Environment(\.presentationMode) var presentationMode // Used to close the sheet
    @Environment(\.managedObjectContext) var context // Context tells us that we are trying to save data in "THIS" application
    
    // State variables for storing the user entered data
    @State private var name = ""
    @State private var ingredients = ""
    @State private var type = ""
    @State private var imageD = ""
    @State var image : Data = .init(count:0)
    @State var show = false
    @State var showAction = false
    @State var active = true
    @State private var selection = "Meat"
    @FocusState private var isTextFieldFocused: Bool
    let allTypes = ["Meat", "Vegetarian", "Other"]
    
    @State var sourceType : UIImagePickerController.SourceType = .camera
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red.edgesIgnoringSafeArea(.all)
                Color.black
                GeometryReader { reader in // GeometryReader to get the the coordinate space/space of the entire view (screen)
                    VStack {
                        ScrollView(.vertical) {
                            if self.image.count != 0{
                                Button(action: {
                                    self.showAction.toggle()
                                }){
                                    Image(uiImage: UIImage(data: self.image)!)
                                        .resizable()
                                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                        .frame(height: 210)
                                    
                                }
                            }else{
                                Button(action:{
                                    self.showAction.toggle()
                                }){
                                    Image(systemName: "photo.fill")
                                        .font(.system(size: 200))
                                        .foregroundColor(.white)
                                }
                            }
                            TextField("Enter Pizza Name", text: $name) /// `.constant()` can be used as a placeholder
                                .textFieldStyle(.roundedBorder)
                                .frame(width: reader.size.width - 34)
                                .focused($isTextFieldFocused)
                            if isTextFieldFocused {
                                //                        Button("Keyboard is up!") {
                                //                            isTextFieldFocused = false
                                //                        }
                            }
                            TextEditor(text: $ingredients)
                                .frame(height: 200)
                                .frame(width: reader.size.width - 34)
                            
                            Picker("Select Pizza Type", selection: $type) {
                                ForEach(allTypes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: type){sel in
                                if(type == "Other"){
                                    active = false
                                    type = ""
                                }
                            }
                            
                            TextField("Selected Pizza Type", text: $type)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: reader.size.width - 34)
                                .disabled(active)
                            Spacer()
                            
                                .actionSheet(isPresented: self.$showAction){
                                    ActionSheet(title: Text("Select Photo"), message: Text("Please select a photo from the library"), buttons:
                                                    [.default(Text("Camera")){
                                        self.show.toggle()
                                        self.sourceType = .camera
                                    },
                                                     .default(Text("Photo Library")){
                                                         self.show.toggle()
                                                         self.sourceType = .photoLibrary
                                                     }
                                                    ])
                                }
                            
                                .sheet(isPresented: self.$show){
                                    ImagePicker(show: self.$show, image:self.$image, sourceType: sourceType)
                                }
                        }
                        .padding()
                    }
                    .navigationTitle("New Pizza") // Setting the title bar
                    .navigationBarTitleDisplayMode(.inline) // Making the title small
                    .toolbar {
                        ToolbarItem {
                            Button {
                                // By passing context we are telling Swift that the pizza object below will be saved for/under this application
                                if(name.count > 0 && (ingredients.count != 0) && (!self.image.isEmpty) && (!type.isEmpty)){
                                    let pizza = Pizza(context: context)
                                    // Assigning the data to the object properties
                                    pizza.name = name
                                    pizza.ingredients = ingredients
                                    pizza.type = type
                                    pizza.imageD = image
                                    
                                    try? context.save() // asking core data to save the pizza object. An error can occur if values to all parameters are not provided
                                    print(pizza)
                                    presentationMode.wrappedValue.dismiss() // Closing the sheet
                                }
                                
                            } label: {
                                Text("Save")
                                    .foregroundColor((name.count > 0 && (ingredients.count != 0) && (!self.image.isEmpty) && (!type.isEmpty)) ? Color.blue : Color.black)
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                
                                presentationMode.wrappedValue.dismiss() // Closing the sheet
                            } label: {
                                Text("Cancel")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct NewPizzaView_Previews: PreviewProvider {
    static var previews: some View {
        NewPizzaView()
    }
}
