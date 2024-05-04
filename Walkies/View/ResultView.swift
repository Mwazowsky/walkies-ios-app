//
//  ContentView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 25/04/24.
//

import SwiftUI

struct ResultView: View {
    @State private var isShowingSheet = false
    
    @State var modalPresented = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, content: {
                Section(
                ) {
                    CardView()
                }
                
                VStack(alignment: .center, content: {
                    ZStack {
                        RingShape(percent: 80, startAngle: -90, drawnClockwise: false)
                            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingTwo, .buttonRingOne]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 180, height: 180)
                        
                        
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                            Text("320 cal")
                                .font(.title)
                                .fontWeight(.heavy)
                            Text("Active calories")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        })
                        
                    }
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
                    .padding(.bottom, 30)
                    
                    HStack(alignment: .center, content: {
                        Button {
                            
                        } label: {
                            Text("Save Result")
                                .fontWeight(.semibold)
                                .fontWeight(.regular)
                                .foregroundColor(.buttonRingTwo)
                                .multilineTextAlignment(.center)
                            Image(systemName: "bookmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(.buttonRingTwo)
                        }
                        .buttonStyle(.bordered)
                        .background(.black)
                        .cornerRadius(25)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Re-estimate")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                            Image(systemName: "arrow.counterclockwise.circle.fill")
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
            })
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .padding(.top, 5)
        
    }
}

struct CardView: View {
    
    @StateObject var vm = FormData()
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        GroupBox{
            HStack() {
                Text("Age")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                Text(vm.newFormData.physicalDetails.age)
                    .fontWeight(.semibold)
                    .foregroundColor(.bgOne)
            }
            HStack() {
                Text("Weight")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                TextField("Kg", value: $vm.newFormData.physicalDetails.weight, formatter: Self.formatter)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            HStack() {
                Text("Resting Heart Rate")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                TextField("Beat per minute", value: $vm.newFormData.physicalDetails.bpm, formatter: Self.formatter)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            Toggle(isOn: $vm.newFormData.activityDetails.isOnTreadmill) {
                Text("On Treadmill")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
            }
            HStack() {
                Text("Run Distance")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                TextField("", value: $vm.newFormData.activityDetails.distance, formatter: Self.formatter)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            HStack() {
                Text("Surface Grade")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                TextField("", value: $vm.newFormData.activityDetails.surfGrade, formatter: Self.formatter)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
        }
        .padding()
        .padding(.bottom, 20)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

struct BlankCardView: View {
    
    var body: some View {
        GroupBox{
            Spacer()
                .frame(width: 360, height: 200)
        }
    }
}

#Preview {
    MainView()
}
