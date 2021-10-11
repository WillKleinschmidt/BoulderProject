//
//  RouteView.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/9/21.
//

import SwiftUI

struct RouteView: View {
    
    @ObservedObject var route: Route


    
    var body: some View {
        ZStack {
            imageFromData()
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .colorInvert()
                    .frame(height: 75)
                    .opacity(0.5)
                    .padding()
            }
            VStack {
                Spacer()
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
                    ZStack{
                        Capsule()
                            .fill(getCompletedColor()!)
                            .frame(width: 100, height: 30)
                        getCompletedText()
                            .foregroundColor(.white)
                    }
                    Spacer()
                        .frame(maxWidth: 10)
                }
                .frame(height: 75)
                .padding()
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

