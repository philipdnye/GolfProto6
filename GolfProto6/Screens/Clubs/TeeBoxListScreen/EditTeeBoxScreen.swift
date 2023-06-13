//
//  EditTeeBoxScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 21/03/2023.
//

import SwiftUI
import Foundation

struct EditTeeBoxScreen: View {
    
    let manager = CoreDataManager.shared
    let teeBox: TeeBoxViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var teeBoxListVM = TeeBoxListViewModel()
    @StateObject private var editTeeBoxVM = EditTeeBoxViewModel()
    @StateObject private var holeListVM = HoleListViewModel()
    @State private var teeBoxColorEdit: UIColor = UIColor()
    


    @Binding var holeValues2: [[String]]

    
    
    private func loadDefaultValues() {
        if !teeBox.colour.isEmpty {
            self.editTeeBoxVM.colour = teeBox.colour
        }
        if String(teeBox.slopeRating) != "0" {
            self.editTeeBoxVM.slopeRating = String(teeBox.slopeRating)
        }
        if String(teeBox.courseRating) != "0.0" {
            self.editTeeBoxVM.courseRating = String(teeBox.courseRating)
        }
        self.editTeeBoxVM.teeBoxColor = Color(teeBox.teeBoxColor)
        

        
    }

    
    
    var body: some View {
        Form{
            TextField("TeeBox colour", text: $editTeeBoxVM.colour)
            ColorPicker("Select teebox colour", selection: $editTeeBoxVM.teeBoxColor)
            TextField("Slope rating", text: $editTeeBoxVM.slopeRating)
            TextField("Course rating", text: $editTeeBoxVM.courseRating)
//            Button("Edit holes"){
////                loadDefaultValuesHoles()
//            }

            HStack(spacing: 6){
                Text("Hole")
                    .frame(width: 36, alignment: .center)
                Text("Yards")
                    .frame(width: 50, alignment: .center)
                Text("Par")
                    .frame(width: 30, alignment: .center)
                Text("SI")
                    .frame(width: 36, alignment: .center)
                Text("Name")
                    .frame(width: 100, alignment: .center)
                
            }
            .font(.caption)
            
            ForEach(0..<18) {j in
                HStack(spacing: 6){
                    Text((j+1).formatted())
                        .frame(width: 36, alignment: .center)
                    TextField("Dist", text: $holeValues2[j][0])

                   
                        .frame(width: 50, alignment: .center)
                   
                    TextField("Par", text: $holeValues2[j][1])

                        .frame(width: 30, alignment: .center)
                    TextField("SI", text: $holeValues2[j][2])

                        .frame(width: 36, alignment: .center)
                        .foregroundColor(.orange)
                    TextField("Name", text: $holeValues2[j][3])

                        .frame(width: 100, alignment: .center)
                }
                .font(.callout)
            }
            
            
            
//
            Button("Save") {
                let teeBox2 = manager.getTeeBoxById(id: teeBox.teeBoxId)
                teeBox2?.colour = editTeeBoxVM.colour
                teeBox2?.slopeRating = Int16(editTeeBoxVM.slopeRating) ?? 0
                teeBox2?.courseRating = Double(editTeeBoxVM.courseRating) ?? 0.0
                teeBox2?.teeBoxColor = UIColor(editTeeBoxVM.teeBoxColor)
                
//                holeListVM.getHolesByTeeBox(vm: teeBox)
                let currentHoles = teeBox.teeBox.holesArray
            
                    for hole in (currentHoles){
                        
                        
                        
                        hole.distance = Int16(holeValues2[Int(hole.number-1)][0]) ?? 0
                        hole.par = Int16(holeValues2[Int(hole.number-1)][1]) ?? 0
                        hole.strokeIndex = Int16(holeValues2[Int(hole.number-1)][2]) ?? 0
                        hole.name = holeValues2[Int(hole.number-1)][3]
                        manager.save()
                    }
                
           
                
                
                manager.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Edit teebox")
            //.embedInNavigationView()
            .onAppear{
                loadDefaultValues()

                
            }

    }
}

struct EditTeeBoxScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            let teeBox = TeeBoxViewModel(teeBox: TeeBox(context: CoreDataManager.shared.viewContext))
            EditTeeBoxScreen(teeBox: teeBox, holeValues2: .constant(Array(repeating: ["","","",""], count: 18)))
        }
    }
}
