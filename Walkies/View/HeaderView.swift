//
//  HeaderView.swift
//  Walkies
//
//  Created by Saifulloh Fadli on 09/12/24.
//

import SwiftUI

struct HeaderView: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    var bgColor: Color
    @EnvironmentObject var orientationModel: OrientationModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Ellipse()
                    .fill(self.bgColor)
                    .frame(width: geometry.size.width * 1.4,
                           height: self.orientationModel.landscape ? geometry.size.height * 0.5 : geometry.size.height * 0.4)
                    .position(x: geometry.size.width / 2.35,
                              y: geometry.size.height * 0.025)
                    .clipShape(Rectangle())
                    .shadow(radius: 3)
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    Ellipse()
                    .fill(self.bgColor)
                    .frame(width: geometry.size.width * 1.4,
                           height: geometry.size.height * 0.45)
                    .position(x: geometry.size.width / 2.35,
                              y: geometry.size.height * 0.105)
                    .clipShape(Rectangle())
                    .shadow(radius: 3)
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text(self.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Text(self.subtitle)
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)

                        Spacer()
                    }
                    .padding(.leading,
                             self.orientationModel.landscape ?
                                geometry.size.width * 0.03 :
                                (UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width * 0.075 : geometry.size.width * 0.04))
                    .padding(.top, UIDevice.current.userInterfaceIdiom == .phone ?
                                geometry.size.height * 0.135 :
                                geometry.size.height * 0.08)

                    Spacer()
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "groups", subtitle: "chooseGroupToConnect", bgColor: Color.primaryColor).environmentObject(OrientationModel(isLandscape: false))
    }
}
