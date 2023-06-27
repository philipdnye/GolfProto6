//
//  ShotsRecdDots.swift
//  GolfProto6
//
//  Created by Philip Nye on 27/06/2023.
//

import SwiftUI

struct ShotsRecdDots: View {
    var shotsReceived: Int = 3

    var body: some View {
        HStack(spacing:0.75){
            ForEach(0..<shotsReceived, id: \.self){i in
                Image(systemName: "circle.fill")
                    .font(.system(size: 3, weight: .thin))
                    .foregroundColor(.blue)
            }
        }
        .frame(width: 15, height: 6, alignment: .leading)
        
    }
}

struct ShotsRecdDots_Previews: PreviewProvider {
    static var previews: some View {
        ShotsRecdDots()
    }
}
