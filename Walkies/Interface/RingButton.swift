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
    
    @State private var age: Int?
    @State private var weight: Double?
    @State private var bpm: Int?
    @State private var distance: Double?
    @State private var surfGrade: Int?
    
    @State private var activityType: ActivityType = .running
    
    @State var isOnTreadmill: Bool = false
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
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
            
        }
        .sheet(isPresented: $isShowingSheet,
               onDismiss: didDismiss) {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            
                        } label: {
                            Text("Done")
                                .fontWeight(.bold)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Button {
                            isShowingSheet.toggle()
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
                                TextField("Years", value: $age, formatter: Self.formatter)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                            }
                            HStack() {
                                Text("Weight")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.textSecondary)
                                Spacer()
                                TextField("Kg", value: $weight, formatter: Self.formatter)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                            }
                            HStack() {
                                Text("Resting Heart Rate")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.textSecondary)
                                Spacer()
                                TextField("Beat per minute", value: $bpm, formatter: Self.formatter)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                            }
                        }
                        
                        Section(header:
                                    Text("Activity Details")
                            .fontWeight(.bold)
                            .font(.subheadline)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        ) {
                            NavigationLink(destination: PickerView(activityType: $activityType)) {
                                HStack {
                                    Text("Activity Type: ")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.textSecondary)
                                    Spacer()
                                    Text(activityTypeString())
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            Toggle(isOn: $isOnTreadmill) {
                                Text("On Treadmill")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.textSecondary)
                            }
                            HStack() {
                                Text("Run Distance")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.textSecondary)
                                Spacer()
                                TextField("Km", value: $distance, formatter: Self.formatter)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                            }
                            HStack() {
                                Text("Surface Grade")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.textSecondary)
                                Spacer()
                                TextField("%", value: $surfGrade, formatter: Self.formatter)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                            }
                        }
                        
                        Section() {
                            Button {
                                
                            } label: {
                                Text("Reset Input")
                                    .fontWeight(.regular)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(.plain)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        
                    }
                }
            }
        }
    }
    
    func activityTypeString() -> String {
        switch activityType {
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
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}
