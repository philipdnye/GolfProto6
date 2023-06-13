//
//  ClubDetailsHolesFrontTotalView.swift
//  swindl01
//
//  Created by Philip Nye on 03/01/2023.
//

import SwiftUI

struct HolesLayoutTotals: View {
    
    @StateObject private var holeListVM = HoleListViewModel()
    let teeBox: TeeBoxViewModel
    var distance: Int16
    var par: Int16
    var description: String
    
    var body: some View {
        HStack(spacing: 6){
            Text(description)
                .frame(width: 37, alignment: .center)
                .font(.caption)
            Text(String(distance))
                .frame(width: 50, alignment: .center)
            Text(String(par))
                .frame(width: 30, alignment: .center)
            Text(description)
                .frame(width: 36, alignment: .center)
                .font(.caption)
            
        }
        .font(.callout)
        .font(.footnote.weight(.semibold))
        .foregroundColor(.orange)
//        .onAppear(perform: {
//            holeListVM.getFront9DistanceByTeeBox(vm: teeBox)
//            holeListVM.getTotalFront9ParByTeeBox(vm: teeBox)
//        })
        
    }
}

struct HolesLayoutTotals_Previews: PreviewProvider {
    static var previews: some View {
        let teeBox = TeeBoxViewModel(teeBox: TeeBox(context: CoreDataManager.shared.viewContext))
        HolesLayoutTotals(teeBox: teeBox, distance: 3210, par: 35,description: "OUT")
    }
}
