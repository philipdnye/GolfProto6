//
//  TeeBoxListRowItem.swift
//  GolfProto01
//
//  Created by Philip Nye on 17/03/2023.
//

import SwiftUI

struct TeeBoxListRowItem: View {
    @StateObject private var teeBoxListVM = TeeBoxListViewModel()
//    @StateObject private var holeListVM = HoleListViewModel()
   
    let teeBox: TeeBoxViewModel
    
    
    
    var body: some View {
//        let holes = holeListVM.holes
        
        
           
        
        HStack{
            
            HStack{
                
            }.frame(width:60, height:60)
                .background(Color(teeBox.teeBoxColor))
                .border(.black.opacity(0.2))
            Text(teeBox.colour)
            Group{
                VStack{
                    HStack{
                        TeeBoxDistancesSubScreen(teeBox: teeBox)
                       
                    }
                    HStack{
                        Text("Par \(teeBox.totalPar.formatted())")
                        Text("Par \(teeBox.totalParFront9.formatted())")
                        Text("Par \(teeBox.totalParBack9.formatted())")
                    }
//                    Text(holeListVM.holes.count.formatted())
                    HStack{
                        Text("Course rating:")
                        Text(teeBox.courseRating.formatted())
                    }
                    HStack{
                        Text("Slope rating:")
                        Text(teeBox.slopeRating.formatted())
                    }
                }
            }.foregroundColor(.orange)
                .font(.caption)
        }
//        .onAppear(perform: {
//            holeListVM.getHolesByTeeBox(vm: teeBox)
////            holeListVM.getTotalParByTeeBox(vm: teeBox)
////            holeListVM.getTotalDistanceByTeeBox(vm: teeBox)
////            holeListVM.getFront9DistanceByTeeBox(vm: teeBox)
////            holeListVM.getBack9DistanceByTeeBox(vm: teeBox)
////            holeListVM.getTotalFront9ParByTeeBox(vm: teeBox)
////            holeListVM.getTotalBack9ParByTeeBox(vm: teeBox)
//        })
        
        
        
        
        
    }
}
struct TeeBoxListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        let teeBox = TeeBoxViewModel(teeBox: TeeBox(context: CoreDataManager.shared.viewContext))
        TeeBoxListRowItem(teeBox: teeBox)
    }
}
