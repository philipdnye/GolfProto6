//
//  HoleListScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct HoleListScreen: View {
    
    let teeBox: TeeBoxViewModel

    @State private var isPresentedEdit: Bool = false
    @StateObject private var holeListVM = HoleListViewModel()
    @StateObject private var addHoleVM = AddHoleViewModel()
    @State var holeValues: [[String]] = Array(repeating: ["","","",""], count: 18)
   
    private func onAdd() {
        addHoleVM.addRandomHolesToTeeBox(vm: teeBox)
        
        holeListVM.getHolesByTeeBox(vm: teeBox)
    }
    private func onEdit() {
        holeListVM.getHolesByTeeBox2(vm: teeBox)
        for hole in (holeListVM.holes2){
            
            holeValues[Int(hole.number)-1][0] = String(hole.distance)
          
            holeValues[Int(hole.number)-1][1] = String(hole.par)
            holeValues[Int(hole.number)-1][2] = String(hole.strokeIndex)
            holeValues[Int(hole.number)-1][3] = String(hole.name ?? "")
        }
        isPresentedEdit = true
    }
    private var addButton: some View {
       AnyView(Button(action: onAdd) {Image(systemName: "plus")})
        }
    private var editButton: some View {
        AnyView(Button(action:onEdit){Text("Edit")})
    }
    
    
    var body: some View {
        VStack{

            HStack(spacing:25){
                HolesLayout9(teeBox: teeBox, holes: teeBox.front9Holes)
                HolesLayout9(teeBox: teeBox, holes: teeBox.back9Holes)
            }
            HStack(spacing:25){
                HolesLayoutTotals(teeBox: teeBox, distance: teeBox.totalDistanceFront9, par: teeBox.totalParFront9,description: "OUT")
                HolesLayoutTotals(teeBox: teeBox, distance: teeBox.totalDistanceBack9, par: teeBox.totalParBack9,description: "IN")
            }
            HStack(spacing:25) {
                Spacer()
                    .frame(width:170)
                HolesLayoutTotals(teeBox: teeBox, distance: teeBox.totalDistanceFront9, par: teeBox.totalParFront9,description: "OUT")
            }
            HStack(spacing:25) {
                Spacer()
                    .frame(width:170)
                HolesLayoutTotals(teeBox: teeBox, distance: teeBox.totalDistance, par: teeBox.totalPar,description: "TOT")
            }
        }
        .navigationTitle("\(teeBox.colour) tees")
        
        
        
//        .navigationBarItems(trailing: addButton)
//        .disabled(holeListVM.holes.count != 0)
//        .navigationBarItems(trailing: editButton)
        
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                editButton
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton
                    .disabled(holeListVM.holes.count != 0)
            }
                    
            
                    
        }
        
        
        
        
        .sheet(isPresented: $isPresentedEdit, onDismiss: {
            holeListVM.getHolesByTeeBox(vm: teeBox)
        }, content: {
            EditTeeBoxScreen(teeBox: teeBox, holeValues2: $holeValues)
        })
        .onAppear(perform: {
            holeListVM.getHolesByTeeBox2(vm: teeBox)
        })
    }
}

struct HoleListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let teeBox = TeeBoxViewModel(teeBox: TeeBox(context: CoreDataManager.shared.viewContext))
        HoleListScreen(teeBox: teeBox)//.embedInNavigationView()
    }
}

