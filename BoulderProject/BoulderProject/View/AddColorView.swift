//
//  AddColorView.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/24/21.
//

import SwiftUI

struct AddColorView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var colorName = ""
    @State private var routeColor = Color(.white)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Color name", text: $colorName)
                    ColorPicker("Choose a Color", selection: $routeColor, supportsOpacity: false)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(routeColor)
                    
                }
            }.background(routeColor)
            
            .navigationTitle("New Color")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "trash")
                            Text("Discard")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newColor = RouteColor(context: self.moc)
                        let colorData = ColorUtils.ColorToData(swiftuiColor: routeColor)
                        
                        newColor.colorName = colorName
                        newColor.colorData = colorData

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text("Save")
                            Image(systemName: "square.and.arrow.down")
                        }
                    }
                }
            }

        }
    }
}

struct AddColorView_Previews: PreviewProvider {
    static var previews: some View {
        AddColorView()
    }
}
