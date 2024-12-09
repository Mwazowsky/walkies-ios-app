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
    @State private var linkActive = false
    
    var body: some View {
        MainView()
    }
    
    private func action(newFormData: newFormData) -> Void {
        print(newFormData)
    }
}

#Preview {
    MainView()
}
