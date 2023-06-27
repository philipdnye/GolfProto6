//
//  ScoreSymbol.swift
//  GolfProto6
//
//  Created by Philip Nye on 27/06/2023.
//

import SwiftUI

struct ScoreSymbol: View {
    var grossScoreToPar: Int = 0
    
    var body: some View {
        switch grossScoreToPar {
            
        case _ where grossScoreToPar > 2:
            Image(systemName: "square")
                .font(.system(size: 38, weight: .ultraLight))
                .foregroundColor(burntOrange)
                .offset(x: 5, y: 2)
            
            Image(systemName: "square")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(burntOrange)
                .offset(x: 5, y: 2)
            
        case _ where grossScoreToPar == 2:
            Image(systemName: "square")
                .font(.system(size: 38, weight: .ultraLight))
                .foregroundColor(darkTeal)
                .offset(x: 5, y: 2)
            
            Image(systemName: "square")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(darkTeal)
                .offset(x: 5, y: 2)
            
        case _ where grossScoreToPar == 1:
            Image(systemName: "square")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(darkTeal)
                .offset(x: 5, y: 2)

        case _ where grossScoreToPar == -1:
            ZStack{
                Image(systemName: "circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(darkTeal)
                    .offset(x: 5, y: 2)
                    .zIndex(1)
                Image(systemName: "circle.fill")
                    .font(.system(size:44, weight: .ultraLight))
                    .foregroundColor(.orange)
                    .opacity(0.3)
                    .offset(x: 5, y: 2)
                    .zIndex(0)
                
            }
            
            
            

        case _ where grossScoreToPar == -2:
            Image(systemName: "circle")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(darkTeal)
                .offset(x: 5, y: 2)
                .zIndex(1)
            Image(systemName: "circle.fill")
                .font(.system(size:44, weight: .ultraLight))
                .foregroundColor(.orange)
                .opacity(0.7)
                .offset(x: 5, y: 2)
                .zIndex(0)
            
            Image(systemName: "circle")
                .font(.system(size: 38, weight: .ultraLight))
                .foregroundColor(darkTeal)
                .offset(x: 5, y: 2)
            
        case _ where grossScoreToPar < -2:
            Image(systemName: "circle")
                .font(.system(size: 38, weight: .ultraLight))
                .foregroundColor(burntOrange)
                .offset(x: 5, y: 2)
            
            Image(systemName: "circle")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(burntOrange)
                .offset(x: 5, y: 2)
        default:
            EmptyView()
        }
    }
}

struct ScoreSymbol_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSymbol()
    }
}
