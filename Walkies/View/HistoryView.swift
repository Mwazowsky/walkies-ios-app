//
//  HistoryView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 01/05/24.
//

import Foundation
import SwiftUI

struct SheetView: View {
    let title: String
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<30) { item in
                    Text("Item \(item)")
                }
            }
            .listStyle(.plain)
            .navigationTitle(title)
        }
    }
}

struct HistoryView: View {
    @State private var currentDrag: CGFloat = 0
    @State private var stateDrag: CGFloat = -300
    
    let minDrag: CGFloat = -UIScreen.main.bounds.height + 120
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, content: {
                    VStack(alignment: .center, content: {
                        ZStack {
                            RingShape(percent: 80, startAngle: -90, drawnClockwise: false)
                                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                                .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingTwo, .buttonRingOne]), startPoint: .top, endPoint: .bottom))
                                .frame(width: 180, height: 180)
                            
                            
                            VStack(alignment: .center, content: {
                                Text("320 cal")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                Text("Active calories")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            })
                            
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 30)
                        
                        HStack(alignment: .center, content: {
                            VStack(alignment: .center, content: {
                                ZStack(content: {
                                    RingShape(percent: 80, startAngle: -90, drawnClockwise: false)
                                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                        .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingThree, .buttonRingThree]), startPoint: .top, endPoint: .bottom))
                                    
                                    Text("6540")
                                        .font(.subheadline)
                                        .fontWeight(.heavy)
                                })
                                .padding(.bottom, 10)
                                
                                Text("Steps")
                                    .fontWeight(.semibold)
                            })
                            Spacer()
                            
                            VStack(alignment: .center, content: {
                                ZStack(content: {
                                    RingShape(percent: 80, startAngle: -90, drawnClockwise: false)
                                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                        .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingOne, .buttonRingOne]), startPoint: .top, endPoint: .bottom))
                                    
                                    VStack(content: {
                                        Text("720")
                                            .font(.callout)
                                            .fontWeight(.heavy)
                                        
                                        Text("bpm")
                                            .font(.callout)
                                            .fontWeight(.heavy)
                                    })
                                    
                                })
                                .padding(.bottom, 10)
                                
                                Text("Heart Rate")
                                    .fontWeight(.semibold)
                            })
                            Spacer()
                            
                            VStack(alignment: .center, content: {
                                ZStack(content: {
                                    RingShape(percent: 80, startAngle: -90, drawnClockwise: false)
                                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                        .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingTwo, .buttonRingTwo]), startPoint: .top, endPoint: .bottom))
                                    
                                    Text("12 min")
                                        .font(.callout)
                                        .fontWeight(.heavy)
                                })
                                
                                .padding(.bottom, 10)
                                
                                Text("Time")
                                    .fontWeight(.semibold)
                            })
                        })
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 10)
                    })
                    
                    Section(
                    ) {
                        CardView()
                    }
                    
                    HStack(alignment: .center, content: {
                        Button {
                            
                        } label: {
                            Text("Share")
                                .fontWeight(.semibold)
                                .fontWeight(.regular)
                                .foregroundColor(.buttonRingTwo)
                                .multilineTextAlignment(.center)
                            Image(systemName: "square.and.arrow.up.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(.buttonRingTwo)
                        }
                        .buttonStyle(.bordered)
                        .background(.black)
                        .cornerRadius(25)
                        
                        Button {
                            
                        } label: {
                            Text("Pin")
                                .fontWeight(.semibold)
                                .fontWeight(.regular)
                                .foregroundColor(.buttonRingThree)
                                .multilineTextAlignment(.center)
                            Image(systemName: "pin.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(.buttonRingThree)
                        }
                        .buttonStyle(.bordered)
                        .background(.black)
                        .cornerRadius(25)
                        
                        Button {
                            
                        } label: {
                            Text("Delete")
                                .fontWeight(.semibold)
                                .foregroundColor(.buttonRingOne)
                                .multilineTextAlignment(.center)
                            Image(systemName: "trash.slash.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.bordered)
                        .background(.black)
                        .cornerRadius(25)
                    })
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                })
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, 20)
            }
        }
        .safeAreaInset(edge: .top) {
            HistoryCardView()
                .edgesIgnoringSafeArea(.top)
            
        }
    }
    
}

#Preview {
    MainView()
}
