//
//  HoleNavigatorPopUp.swift
//  swindl03
//
//  Created by Philip Nye on 18/01/2023.
//

import SwiftUI

struct HoleNavigatorPopUp: View {
    @StateObject var scoreEntryVM: ScoreEntryViewModel
    @Binding var showHoleNavigator:Bool
//    init (show:Binding<Bool>){
//        self._show = show
//    }
    var body: some View {
        if showHoleNavigator {
            VStack(spacing:15){
                ForEach(0..<3){ j in
                    HStack(spacing:15){
                        ForEach(1..<7) {i in
                            Button {
                                scoreEntryVM.holeIndex = Int((i+(j*6))-1)
                                showHoleNavigator.toggle()

                            }
                           
                        label: {
                                Text((i+(j*6)).formatted())
                                    .frame(width:25, height:25)
                                    .font(.title3)
                                    .font(.footnote.weight(.semibold))
                                    .padding(6)
                                    .background(burntOrange)
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                            }
                        }
                    }//HStack
                }
            }
            
            .padding([.top, .bottom, .trailing, .leading], 10)
            .background(lightTeal)
            
            
            
        }
            
    }
}

struct HoleNavigatorPopUp_Previews: PreviewProvider {
    static var previews: some View {
        HoleNavigatorPopUp(scoreEntryVM: ScoreEntryViewModel(),showHoleNavigator: .constant(true))
            
    }
}
