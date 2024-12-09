//
//  ContentView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 25/04/24.
//

import SwiftUI

struct ResultView: View {
    @State private var isShowingSheet = false
    @ObservedObject var vm: FormData
    @State var modalPresented = false
    
    let processor = ProcessInput() // Create an instance of ProcessInput
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, content: {
                Section(
                ) {
                    CardView(vm: vm)
                }
                
                VStack(alignment: .center, content: {
                    ZStack {
                        RingShape(percent: 100, startAngle: -90, drawnClockwise: false)
                            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .fill(.bgTwo)
                            .frame(width: 180, height: 180)
                        
                        RingShape(percent: 80, startAngle: -90, drawnClockwise: false)
                            .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingTwo, .buttonRingOne]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 180, height: 180)
                        
                        
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                            Text("\(calculateCalories()) cal")
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
                                RingShape(percent: 100, startAngle: -90, drawnClockwise: false)
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingThree, .buttonRingThree]), startPoint: .top, endPoint: .bottom))
                                
                                Text("\(calculateTime() * 60)")
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
                                RingShape(percent: 100, startAngle: -90, drawnClockwise: false)
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
                                RingShape(percent: 100, startAngle: -90, drawnClockwise: false)
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .fill(LinearGradient(gradient: Gradient(colors: [.buttonRingTwo, .buttonRingTwo]), startPoint: .top, endPoint: .bottom))
                                
                                Text("\(calculateTime()) min")
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
    
    func calculateCalories() -> Int {
        // Use the calculateCaloriesBurned function
        let age = Double(vm.savedFormData.physicalDetails.age) ?? 0
        let weight = Double(vm.savedFormData.physicalDetails.weight) ?? 0
        let heartRate = Double(vm.savedFormData.physicalDetails.bpm) ?? 0
        let distance = Double(vm.savedFormData.activityDetails.distance) ?? 0
        let activityTypeString: String

        switch vm.savedFormData.activityDetails.activityType {
        case .running:
            activityTypeString = "running"
        case .jogging:
            activityTypeString = "jogging"
        case .hiking:
            activityTypeString = "hiking"
        case .walking:
            activityTypeString = "walking"
        }

        let actType = activityTypeString
        let metersPerMinute = processor.estimateRunningSpeed(age: Int(age), weight: weight, heartRate: Int(heartRate)) ?? 0
        let timeInMinutes = (distance * 1000) / metersPerMinute
        let fractionalGrade = 0.0 // Assuming no grade specified
        
        return Int(processor.calculateCaloriesBurnedv2(age: age, weight: weight, heartRate: heartRate, timeInMinutes: timeInMinutes, metersPerMinute: metersPerMinute, fractionalGrade: fractionalGrade, activityType: actType))
    }
    
    func calculateTime() -> Int {
        // Use the calculateCaloriesBurned function
        let age = Double(vm.savedFormData.physicalDetails.age) ?? 0
        let weight = Double(vm.savedFormData.physicalDetails.weight) ?? 0
        let heartRate = Double(vm.savedFormData.physicalDetails.bpm) ?? 0
        let distance = Double(vm.savedFormData.activityDetails.distance) ?? 0
        let metersPerMinute = processor.estimateRunningSpeed(age: Int(age), weight: weight, heartRate: Int(heartRate)) ?? 0
        let timeInMinutes = (distance * 1000) / metersPerMinute
        
        return Int(timeInMinutes)
    }
}

struct CardView: View {
    @ObservedObject var vm: FormData
    
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
                Text("\(vm.savedFormData.physicalDetails.age) yo")
                    .fontWeight(.semibold)
                    .foregroundColor(.bgOne)
            }
            HStack() {
                Text("Weight")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                Text("\(vm.savedFormData.physicalDetails.weight) Kg")
                    .fontWeight(.semibold)
                    .foregroundColor(.bgOne)
            }
            HStack() {
                Text("Resting Heart Rate")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                Text("\(vm.savedFormData.physicalDetails.bpm) bpm")
                    .fontWeight(.semibold)
                    .foregroundColor(.bgOne)
            }
            HStack() {
                Text("Activity Type")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                Text("\(vm.savedFormData.activityDetails.activityType)")
                    .fontWeight(.semibold)
                    .foregroundColor(.bgOne)
            }
            Toggle(isOn: $vm.savedFormData.activityDetails.isOnTreadmill) {
                Text("On Treadmill")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
            }
            .disabled(true)
            HStack() {
                Text("Run Distance")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                Text("\(vm.savedFormData.activityDetails.distance) Km")
                    .fontWeight(.semibold)
                    .foregroundColor(.bgOne)
            }
            HStack() {
                Text("Surface Grade")
                    .fontWeight(.semibold)
                    .foregroundColor(.textSecondary)
                Spacer()
                Text("\(vm.savedFormData.activityDetails.surfGrade) %")
                    .fontWeight(.semibold)
                    .foregroundColor(.bgOne)
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
