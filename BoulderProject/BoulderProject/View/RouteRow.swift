//
//  RouteRow.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/9/21.
//

import SwiftUI

struct RouteRow: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var route: Route
    @State private var showingDetail = false
    
    var body: some View {
        if showingDetail {
            Button(action: {
                showingDetail = false
            }) {
                RouteDetailView(route: route)
            }
        } else {
            Button(action: {
                showingDetail = true
            }) {
                RouteView(route: route)
            }
        }
        
    }
}
