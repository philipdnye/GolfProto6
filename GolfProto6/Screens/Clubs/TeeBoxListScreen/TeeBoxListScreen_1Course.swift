//
//  TeeBoxListScreen_1Course.swift
//  GolfProto01
//
//  Created by Philip Nye on 20/03/2023.
//

import SwiftUI

struct TeeBoxListScreen_1Course: View {
    @StateObject private var clubListVM = ClubListViewModel()
    @State private var isPresentedEdit: Bool = false
    var club: ClubViewModel
    let course: CourseViewModel
    
    @State private var isPresented: Bool = false
    @State private var isPresentedCourse: Bool = false
    
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
    
    private func onEdit() {
        isPresentedEdit = true
    }
    
    private var editCourseButton: some View {
        AnyView(Button(action: onEdit) {Text("Edit course")})
        }
    private func onAdd() {
        isPresented = true
    }
    private func onAddCourse() {
        isPresentedCourse = true
    }
    private var addButton: some View {
       AnyView(Button(action: onAdd) {Image(systemName: "plus")})
        }
    private var addCourseButton: some View {
       AnyView(Button(action: onAddCourse) {Text("Add course")})
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
//            addCourseButton
//            addButton
//
//        })
        .toolbar {
            ToolbarItemGroup(placement: .secondaryAction) {
                Button("Edit course") {
                    onEdit()
                }
                
                Button("Add course") {
                    onAddCourse()
                }
                
                Button("Add teebox") {
                    onAdd()
                }
            }
            
        }
            
//
//            ToolbarItem(placement: .navigationBarTrailing) {
//                editCourseButton
//            }
//
//            ToolbarItem(placement: .navigationBarTrailing) {
//                addCourseButton
//            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                addButton
//            }
//        }
        
        
        
        
        .sheet(isPresented: $isPresentedCourse, onDismiss: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        }, content: {
            //AddCourseScreen(club: club)
            
//            let club = CoreDataManager.shared.getClubById(id: club.id)
            AddCourseScreen(club: club)
        })
        .sheet(isPresented: $isPresentedEdit, onDismiss: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        }, content: {
            //AddCourseScreen(club: club)
            EditCourseScreen(course: course)
        })
        
        
        
        .sheet(isPresented: $isPresented, onDismiss: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        }, content: {
            //AddCourseScreen(club: club)
            AddTeeBoxScreen(course: course)
        })
        .onAppear(perform: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        })
    }
}

struct TeeBoxListScreen_1Course_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            let club = ClubViewModel(club: Club(context: CoreDataManager.shared.viewContext))
            let course = CourseViewModel(course: Course(context: CoreDataManager.shared.viewContext))
            TeeBoxListScreen_1Course(club: club,course: course)//.embedInNavigationView()
        }
    }
}

