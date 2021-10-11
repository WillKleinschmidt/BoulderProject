//
//  EditRouteView.swift
//  CCA
//
//  Created by William Kleinschmidt on 10/4/21.
//

import SwiftUI

struct EditRouteView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(
        entity: Gym.entity(),
        sortDescriptors: [])
    var gyms: FetchedResults<Gym>
    
    @FetchRequest(
        entity: RouteColor.entity(),
        sortDescriptors: [])
    var colors: FetchedResults<RouteColor>
    
    @FetchRequest(
        entity: Grade.entity(),
        sortDescriptors: [])
    var grades: FetchedResults<Grade>
    
    @State private var showingImagePicker = false
    @State private var showingAddGym = false
    @State private var showingAddColor = false
    @State private var showingAddGrade = false
    
    @ObservedObject var route: Route
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var imageData: Data?
    
    @State private var desc = ""
    
    
    @State private var completed = false
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    HStack {
                        Picker("Select a gym", selection: $route.gym) {
                            ForEach(gyms, id: \.self) { gym in
                                Text(gym.gymName!).tag(gym as Gym?)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        Button {
                            self.showingAddGym = true
                        } label: {
                            Image(systemName: "doc.badge.plus")
                        }
                        .buttonStyle(BorderlessButtonStyle())

                    }
                    HStack {
                        Picker("Select a color", selection: $route.color) {
                            ForEach(colors, id: \.self) { color in
                                Text(color.colorName!).tag(color as RouteColor?)

                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        Button {
                            self.showingAddColor = true
                        } label: {
                            Image(systemName: "doc.badge.plus")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    HStack {
                        Picker("Select a grade", selection: $route.grade) {
                            ForEach(grades, id: \.self) { grade in
                                Text(grade.gradeLevel!).tag(grade as Grade?)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        Button {
                            self.showingAddGrade = true
                        } label: {
                            Image(systemName: "doc.badge.plus")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    
                }
                Section {
                    imageFromData()
                        .resizable()
                        .scaledToFit()

                    Button("Pick Image") {
                        self.showingImagePicker = true
                    }
                }
                Section {
                    TextField("Description", text: $desc)
                }
                
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .sheet(isPresented: $showingAddGym) {
                AddGymView().environment(\.managedObjectContext, self.moc)
            }
            .sheet(isPresented: $showingAddColor) {
                AddColorView().environment(\.managedObjectContext, self.moc)
            }
            .sheet(isPresented: $showingAddGrade) {
                AddGradeView().environment(\.managedObjectContext, self.moc)
            }
            .navigationTitle("Edit Route")
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
                        route.desc = desc
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
    func imageFromData() -> Image {
        if route.imageData == nil {
            return Image(systemName: "questionmark")
        }
        let imageData = route.imageData
        let outputImage = UIImage(data: imageData!)
        let image = Image(uiImage: outputImage!)
        return image
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        imageData = inputImage.jpegData(compressionQuality: 1.0)
        image = Image(uiImage: inputImage)
        route.imageData = imageData
    }
}

