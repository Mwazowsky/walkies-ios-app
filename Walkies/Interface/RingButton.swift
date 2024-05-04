//
//  RingButton.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 30/04/24.
//

import Foundation
import SwiftUI

struct RingShape: Shape {
    // 1. Helper function to convert percent values to angles in degrees
    static func percentToAngle(percent: Double, startAngle: Double) -> Double {
        (percent / 100 * 360) + startAngle
    }
    private var percent: Double
    private var startAngle: Double
    private let drawnClockwise: Bool
    
    // 2. This allows animations to run smoothly for percent values
    var animatableData: Double {
        get {
            return percent
        }
        set {
            percent = newValue
        }
    }
    
    init(percent: Double = 100, startAngle: Double = -90, drawnClockwise: Bool = false) {
        self.percent = percent
        self.startAngle = startAngle
        self.drawnClockwise = drawnClockwise
    }
    
    // 3. This draws a simple arc from the start angle to the end angle
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius = min(width, height) / 2
        let center = CGPoint(x: width / 2, y: height / 2)
        let endAngle = Angle(degrees: RingShape.percentToAngle(percent: self.percent, startAngle: self.startAngle))
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: endAngle, clockwise: drawnClockwise)
        }
    }
}

struct RingButton: View {
    var label: String
    var icon: String
    var percent: Double
    var size: Double
    var strokeWidth: Double
    var fillColor: LinearGradient
    
    @Binding var isShowingSheet: Bool
    
    @StateObject var vm = FormData()
    
    @Binding var linkActive : Bool
    @Binding var showAlert : Bool
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            Button(action: {
                isShowingSheet.toggle()
            }) {
                
                VStack {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                        .padding()
                        .foregroundColor(.fgFlame)
                    Text(label)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.heavy)
                }
                .frame(width: size, height: size)
                .padding()
                .background(
                    RingShape(percent: percent, startAngle: -90, drawnClockwise: false)
                        .stroke(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                        .fill(fillColor)
                )
                .foregroundColor(.white)
                .navigationDestination(
                    isPresented: $linkActive) {
                        ResultView()
                    }
            }
            
        }
        .sheet(isPresented: $isShowingSheet,
               onDismiss: didDismiss) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.bgOne)
                    }
                    
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                
                Form {
                    Section(header:
                                Text("Physical Details")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    ) {
                        HStack() {
                            Text("Age")
                                .fontWeight(.semibold)
                                .foregroundColor(.textSecondary)
                            Spacer()
                            TextField("Years", text: $vm.newFormData.physicalDetails.age)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        HStack() {
                            Text("Weight")
                                .fontWeight(.semibold)
                                .foregroundColor(.textSecondary)
                            Spacer()
                            TextField("Kg", text: $vm.newFormData.physicalDetails.weight)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        HStack() {
                            Text("Resting Heart Rate")
                                .fontWeight(.semibold)
                                .foregroundColor(.textSecondary)
                            Spacer()
                            TextField("Beat per minute", text: $vm.newFormData.physicalDetails.bpm)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                    }
                    //
                    Section(header:
                                Text("Activity Details")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    ) {
                        DisclosureGroup(
                            content: { PickerView(vm: vm) },
                            label: { HStack {
                                Text("Activity Type: ")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.textSecondary)
                                Spacer()
                                Text(activityTypeString())
                                    .foregroundColor(.blue)
                            } }
                        )
                        .frame(width: 300)
                        
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
                            TextField("Km", text: $vm.newFormData.activityDetails.distance)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                        HStack() {
                            Text("Surface Grade")
                                .fontWeight(.semibold)
                                .foregroundColor(.textSecondary)
                            Spacer()
                            TextField("%", text: $vm.newFormData.activityDetails.surfGrade)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                        }
                    }
                    
                    Section {
                        VStack {
                            Button {
                                isShowingSheet.toggle()
                                self.linkActive = true
                            } label: {
                                Spacer()
                                Text("Estimate")
                                    .fontWeight(.regular)
                                    .foregroundColor(.buttonRingTwo)
                                    .multilineTextAlignment(.center)
                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.buttonRingTwo)
                                Spacer()
                            }
                            .buttonStyle(.bordered)
                            .padding(.bottom, 5)
                            
                            Button {
                                resetForm()
                            } label: {
                                Spacer()
                                Text("Reset Input")
                                    .fontWeight(.regular)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .buttonStyle(.bordered)
                            
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are you sure you want to close?"),
                    message: Text("Closing will discard any changes."),
                    primaryButton: .destructive(Text("Close")) {
                        isShowingSheet.toggle()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    
    
    func activityTypeString() -> String {
        switch vm.newFormData.activityDetails.activityType {
        case .running:
            return "Running"
        case .walking:
            return "Walking"
        case .jogging:
            return "Jogging"
        case .hiking:
            return "Hiking"
        }
    }
    //
    func didDismiss() {
        showAlert = false
        vm.newFormData = newFormData.empty
    }
    
    func resetForm() {
        vm.newFormData = newFormData.empty
    }
}
