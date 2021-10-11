//
//  AddGymView.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/24/21.
//

import SwiftUI

struct AddGymView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var gymName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Gym Name", text: $gymName)
                }
            }
            
            .navigationTitle("New Gym")
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
                        let newGym = Gym(context: self.moc)
                        newGym.gymName = gymName

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

struct AddGymView_Previews: PreviewProvider {
    static var previews: some View {
        AddGymView()
    }
}
