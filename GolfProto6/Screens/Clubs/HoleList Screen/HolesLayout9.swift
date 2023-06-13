//
//  ClubDetailHolesView.swift
//  swindl01
//
//  Created by Philip Nye on 03/01/2023.
// holeListVM.holes.sorted(by: {$0.number < $1.number}).prefix(9)

import SwiftUI

struct HolesLayout9: View {
    
    @StateObject private var holeListVM = HoleListViewModel()
    let teeBox: TeeBoxViewModel //is this needed? - yes for the teeBox call and to accept from parent
    let holes: [Hole]
    var body: some View {
        let DMI = teeBox.teeBox.course?.club?.dist_metric.stringValue().capitalizingFirstLetter() ?? ""
        VStack{
            HStack(spacing: 6){
                Text("Hole")
                    .frame(width: 36, alignment: .center)
                Text(DMI)
                    .frame(width: 50, alignment: .center)
                Text("Par")
                    .frame(width: 30, alignment: .center)
                Text("SI")
                    .frame(width: 36, alignment: .center)
                
            }
            .font(.caption)
            ForEach(holes) {hole in
                HStack(spacing: 6){
                    Text(hole.number.formatted())
                        .frame(width: 36, alignment: .center)
                       
                    Text(hole.distance.formatted())
                        .frame(width: 50, alignment: .center)
                    Text(hole.par.formatted())
                        .frame(width: 30, alignment: .center)
                    Text(hole.strokeIndex.formatted())
                        .frame(width: 36, alignment: .center)
                        .foregroundColor(.orange)
                }
                .font(.callout)
            }
            
            
            
            
        }
        .onAppear(perform: {
            holeListVM.getHolesByTeeBox(vm: teeBox)
        })
    }
}

struct HolesLayout9_Previews: PreviewProvider {
    static var previews: some View {
        let teeBox = TeeBoxViewModel(teeBox: TeeBox(context: CoreDataManager.shared.viewContext))
        HolesLayout9(teeBox: teeBox, holes: teeBox.front9Holes)
    }
}
