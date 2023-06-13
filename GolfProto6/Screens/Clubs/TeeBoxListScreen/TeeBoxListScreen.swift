//
//  TeeBoxListScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct TeeBoxListScreen: View {
    
    let course: CourseViewModel
    @State private var isPresented: Bool = false
    @State private var isPresentedEdit: Bool = false
    @StateObject private var teeBoxListVM = TeeBoxListViewModel()
//    @StateObject private var holeListVM = HoleListViewModel()
    
    private func deleteTeeBox(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let teeBox = teeBoxListVM.teeBoxes[index]
            // delete the club
          teeBoxListVM.deleteTeeBox(teeBox: teeBox)
            // get all clubs
//            clubListVM.getAllClubs()
            
            
         
        }
    }
    private func onAdd() {
        isPresented = true
    }
    private func onEdit() {
        isPresentedEdit = true
    }
    
    private var editCourseButton: some View {
        AnyView(Button(action: onEdit) {Text("Edit")})
        }
    
    private var addButton: some View {
       AnyView(Button(action: onAdd) {Image(systemName: "plus")})
        }
   
    
    var body: some View {
        
        List{
            ForEach(teeBoxListVM.teeBoxes.sorted(by: {$0.totalDistance > $1.totalDistance}), id: \.teeBoxId) { teeBox in
                
                NavigationLink(
                    destination: HoleListScreen(teeBox: teeBox)) {
                        TeeBoxListRowItem(teeBox: teeBox)
                    }
                    
                
            }.onDelete(perform: deleteTeeBox)
        }.listStyle(PlainListStyle())
//        VStack {
//            List(teeBoxListVM.teeBoxes, id: \.teeBoxId) { teeBox in
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(teeBox.colour)
//
//                            .font(.caption)
//
//                    }
//                    Spacer()
//
//                }
//            }
//        }
        .navigationTitle(course.name)
//        .navigationBarItems(trailing: HStack{
//            editCourseButton
//            addButton
//        })
        .toolbar {
                    
            ToolbarItem(placement: .navigationBarTrailing) {
                editCourseButton
            }
                    
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton
            }
                    
        }
        
        
        .sheet(isPresented: $isPresented, onDismiss: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        }, content: {
            //AddCourseScreen(club: club)
            AddTeeBoxScreen(course: course)
        })
        .sheet(isPresented: $isPresentedEdit, onDismiss: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        }, content: {
            //AddCourseScreen(club: club)
            EditCourseScreen(course: course)
        })
        
        
        .onAppear(perform: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        })
    }
}

struct TeeBoxListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            let course = CourseViewModel(course: Course(context: CoreDataManager.shared.viewContext))
            TeeBoxListScreen(course: course)//.embedInNavigationView()
        }
    }
}

