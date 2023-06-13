//
//  AddHandicapScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import SwiftUI

struct AddHandicapScreen: View {
    @Environment(\.presentationMode) var presentationMode
//    @StateObject private var playerListVM = PlayerListViewModel()
    @StateObject private var addHandicapVM = AddHandicapViewModel()
    @State private var newHandicapIndex: Double = 0.0
    let player: PlayerViewModel
    
//    private func updateHI(vm: PlayerViewModel) {
//        let player = CoreDataManager.shared.getPlayerById(id: vm.id)
//        addHandicapVM.handicapIndex = player?.handicapArray.currentHandicapIndex() ?? 0.0
//    }
    var body: some View {
        
        
        Form{
            Section{
                Stepper("New handicap index \(newHandicapIndex.formatted(.number))", value: $newHandicapIndex,  in: -5...54, step: 0.1)
        
        
                DatePicker(selection: $addHandicapVM.startDate, in: ...Date(),displayedComponents: .date) {
            Text("Handicap starts from")
            
        }
            }
            Section{
            
                Button( "Add handicap") {
                    addHandicapVM.handicapIndex = newHandicapIndex
                    addHandicapVM.addHandicapToPlayer(vm: player)
//                    playerListVM.getAllPlayers()
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(addHandicapVM.handicapIndex == 0.0)
            }
            
        }
    
        .navigationTitle("\(player.firstName.capitalized) \(player.lastName.capitalized)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform:{
            newHandicapIndex = player.player.handicapArray.currentHandicapIndex()
//            updateHI(vm: player)
        })
    }
}

struct AddHandicapScreen_Previews: PreviewProvider {
    static var previews: some View {
        let player = PlayerViewModel(player: Player(context: CoreDataManager.shared.viewContext))
        AddHandicapScreen(player: player)
    }
}
