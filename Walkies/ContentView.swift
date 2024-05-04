//
//  ContentView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSheet = false
    
    @State var modalPresented = false
    
    @State private var showAlert = false
    @State private var linkActive = false // Declare linkActive as State
    
    var body: some View {
        VStack {
            RingButton(
                label: "Estimate",
                icon: "flame.fill",
                percent: 80,
                size: 150.0,
                strokeWidth: 15,
                fillColor: LinearGradient(gradient: Gradient(colors: [.buttonRingTwo, .buttonRingOne]), startPoint: .top, endPoint: .bottom),
                isShowingSheet: $isShowingSheet,
                linkActive: $linkActive,
                showAlert: $showAlert
            )
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
