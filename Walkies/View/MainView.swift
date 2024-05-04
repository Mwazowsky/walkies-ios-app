//
//  MainView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 30/04/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("Estimate")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                    }
                }
            
            HistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar.xaxis")
                        Text("History")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.heavy)
                    }
                }
        }
        .preferredColorScheme(.dark)
    }
}
