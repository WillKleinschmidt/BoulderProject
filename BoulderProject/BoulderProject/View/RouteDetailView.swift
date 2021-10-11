//
//  RouteDetailView.swift
//  CCA
//
//  Created by William Kleinschmidt on 10/4/21.
//

import SwiftUI



struct RouteDetailView: View {
    
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var route: Route
    
    @State private var showingEdit = false
    
    
    
    var body: some View {
        VStack {
            Button {
                showingEdit = true
            } label: {
                HStack {
                    Spacer()
                    Text("Edit")
                    Image(systemName: "square.and.pencil")
                    Spacer()
                        .frame(maxWidth: 20)
                }
            }
            imageFromData()
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            ZStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Spacer()
                            .frame(maxWidth: 10)
                        VStack(alignment: .leading) {
                            ZStack {
                                Capsule()
                                    .fill(getColor()!)
                                    .frame(width: 70, height: 30)
                                    .opacity(0.8)
                                Text(route.grade?.gradeLevel ?? "V?")
                                    .bold()
                            }
                            Text(route.gym?.gymName ?? "NO GYM")

                        }
                        Spacer()
                        Button {
                            route.completed = !route.completed
                            try? self.moc.save()
                        } label: {
                            ZStack{
                                Capsule()
                                    .fill(getCompletedColor()!)
                                    .frame(width: 100, height: 30)
                                getCompletedText()
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                            .frame(maxWidth: 10)
                    }
                    .frame(height: 75)
                    .padding()
                    HStack {
                        Spacer()
                            .frame(maxWidth: 10)
                        Text(route.desc ?? "no description")
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $showingEdit) {
                EditRouteView(route: route).environment(\.managedObjectContext, self.moc)
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
    func getColor() -> Color? {
        let defColorData = ColorUtils.ColorToData(swiftuiColor: .white)
        return ColorUtils.ColorFromData(data: route.color?.colorData ?? defColorData!)
    }
    func getCompletedColor() -> Color? {
        if route.completed == true {
            return Color.green
        } else {
            return Color.red
        }
    }
    func getCompletedText() -> Text? {
        if route.completed == true {
            return Text("completed")
        } else {
            return Text("incomplete")
        }
    }
}

