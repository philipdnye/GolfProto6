//
//  CourseHandicapCalcScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 18/04/2023.
//

import Foundation
import SwiftUI

struct CourseHandicapCalcScreen: View {
    
    @Binding var isPresentedHcap: Bool
    let competitor: Competitor
    
    var body: some View {
        
        VStack(spacing: 5){
           
            Text("Course handicap calc for")
            HStack{
                Text(competitor.FirstName())
                Text(competitor.LastName())
            }
            .font(.title3)
            .font(.footnote.weight(.semibold))
            .foregroundColor(burntOrange)

            HStack{


                Text("\(competitor.TeeBoxColour().capitalized) tees ->")


                Text("S.R. \(competitor.SlopeRating())")
                Text("C.R. \(String(format: "%.1f",competitor.CourseRating()))")
            }

            Text("Handicap Index (H.I.): \(String(format: "%.1f",competitor.handicapIndex))")
                .font(.title3)
                .font(.footnote.weight(.semibold))
                .foregroundColor(burntOrange)
            Text("Course Handicap = (H.I. * S.R.) / 113")
            Text("Course Handicap = (\(String(format: "%.1f",competitor.handicapIndex)) * \(competitor.SlopeRating())) / 113")

            Text("Course Handicap (exact) =  \(String(format: "%.4f",competitor.courseHandicap))")
            Text("Course handicap = \(round(competitor.courseHandicap).formatted())")
                .font(.title3)
                .font(.footnote.weight(.semibold))
                .foregroundColor(burntOrange)
        }
    }
}

struct CourseHandicapCalcScreen_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext))
        CourseHandicapCalcScreen(isPresentedHcap: .constant(true), competitor: competitor.competitor)
    }
}
