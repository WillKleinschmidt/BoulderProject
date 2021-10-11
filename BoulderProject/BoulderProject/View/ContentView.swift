//
//  ContentView.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/7/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    

    @FetchRequest(
        entity: Route.entity(),
        sortDescriptors: [])
    var routes: FetchedResults<Route>
    
    

    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            RouteListView()

                .navigationBarItems(trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    HStack{
                        Text("New Route")
                        Image(systemName: "doc.badge.plus")
                    }
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddRouteView().environment(\.managedObjectContext, self.moc)
                }
                
                .navigationBarTitle("Routes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
