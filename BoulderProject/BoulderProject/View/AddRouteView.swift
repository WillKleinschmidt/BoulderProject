//
//  AddRouteView.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/9/21.
//

import SwiftUI
import CoreData
import CoreML

struct AddRouteView: View {

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
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var imageData: Data?
    
    @State private var color: RouteColor?
    @State private var grade: Grade?
    @State private var gym: Gym?
    
    @State private var routeName = ""
    @State private var gymName = ""
    @State private var completed = false
    @State private var desc = ""
    
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    HStack {
                        Picker("Select a gym", selection: $gym) {
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
                        Picker("Select a color", selection: $color) {
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
                        Picker("Select a grade", selection: $grade) {
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
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    Button("Pick image") {
                        self.showingImagePicker = true
                    }
                }
                Section {
                    TextField("Description", text: $desc)
                }
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
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            
            .navigationTitle("New Route")
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
                        let newRoute = Route(context: self.moc)
                        newRoute.gym = self.gym
                        newRoute.color = self.color
                        newRoute.grade = self.grade
                        newRoute.completed = self.completed
                        newRoute.imageData = self.imageData
                        newRoute.desc = self.desc

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
            
            .onAppear(perform: loadDefGrades)
            .onAppear(perform: loadDefColors)
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        imageData = inputImage.jpegData(compressionQuality: 1.0)
        image = Image(uiImage: inputImage)
    }
    
    func loadDefGrades() {
        if grades.isEmpty {
            let v1 = Grade(context: moc)
            v1.gradeLevel = "V1"
            let v2 = Grade(context: moc)
            v2.gradeLevel = "V2"
            let v3 = Grade(context: moc)
            v3.gradeLevel = "V3"
            let v4 = Grade(context: moc)
            v4.gradeLevel = "V4"
            let v5 = Grade(context: moc)
            v5.gradeLevel = "V5"
            let v6 = Grade(context: moc)
            v6.gradeLevel = "V6"
            let v7 = Grade(context: moc)
            v7.gradeLevel = "V7"
            let v8 = Grade(context: moc)
            v8.gradeLevel = "V8"
            let v9 = Grade(context: moc)
            v9.gradeLevel = "V9"
            let v10 = Grade(context: moc)
            v10.gradeLevel = "V10"
            try? self.moc.save()
        }
    }
    func loadDefColors() {
        if colors.isEmpty {
            let red = RouteColor(context: moc)
            red.colorName = "red"
            red.colorData = ColorUtils.ColorToData(swiftuiColor: Color.red)
            
            let orange = RouteColor(context: moc)
            orange.colorName = "orange"
            orange.colorData = ColorUtils.ColorToData(swiftuiColor: Color.orange)
            
            let yellow = RouteColor(context: moc)
            yellow.colorName = "yellow"
            yellow.colorData = ColorUtils.ColorToData(swiftuiColor: Color.yellow)
            
            let green = RouteColor(context: moc)
            green.colorName = "green"
            green.colorData = ColorUtils.ColorToData(swiftuiColor: Color.green)
            
            let blue = RouteColor(context: moc)
            blue.colorName = "blue"
            blue.colorData = ColorUtils.ColorToData(swiftuiColor: Color.blue)
            
            let purple = RouteColor(context: moc)
            purple.colorName = "purple"
            purple.colorData = ColorUtils.ColorToData(swiftuiColor: Color.purple)
            
            let pink = RouteColor(context: moc)
            pink.colorName = "pink"
            pink.colorData = ColorUtils.ColorToData(swiftuiColor: Color.pink)
            
            let white = RouteColor(context: moc)
            white.colorName = "white"
            white.colorData = ColorUtils.ColorToData(swiftuiColor: Color.white)
            
            let black = RouteColor(context: moc)
            black.colorName = "black"
            black.colorData = ColorUtils.ColorToData(swiftuiColor: Color.black)
            try? self.moc.save()
        }
    }
    
    
}

