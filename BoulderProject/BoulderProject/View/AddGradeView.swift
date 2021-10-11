//
//  AddGradeView.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/24/21.
//

import SwiftUI

struct AddGradeView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var grade = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Grade", text: $grade)
                }
            }
            
            .navigationTitle("New Grade")
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
                        let newGrade = Grade(context: self.moc)
                        newGrade.gradeLevel = grade

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

struct AddGradeView_Previews: PreviewProvider {
    static var previews: some View {
        AddGradeView()
    }
}
