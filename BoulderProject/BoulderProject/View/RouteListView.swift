//
//  RouteListView.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/9/21.
//

import SwiftUI
import CoreData



struct RouteListView: View {
    
    @Environment(\.managedObjectContext) var moc
    

    @FetchRequest(
        entity: Route.entity(),
        sortDescriptors: [])
    var routes: FetchedResults<Route>
    
    var body: some View {
        List {
            ForEach(routes, id: \.self) { route in
                RouteRow(route: route)
            }
            .onDelete(perform: removeRoute)
        }
    }
    func removeRoute(at offsets: IndexSet) {
        for index in offsets {
            let route = routes[index]
            moc.delete(route)
            PersistenceController.shared.delete(route)
        }
    }
}

struct RouteListView_Previews: PreviewProvider {
    static var previews: some View {
        RouteListView()
    }
}
