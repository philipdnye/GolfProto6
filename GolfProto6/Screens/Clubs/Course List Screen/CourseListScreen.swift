//
//  CourseListScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct CourseListScreen: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    let club: ClubViewModel
    @State private var isPresented: Bool = false
    @State private var isPresentedEdit: Bool = false
    @StateObject private var courseListVM = CourseListViewModel()
    @Binding var needsRefresh: Bool
    
    
    var CoursePicker: some View {
        Group {
            switch club.club.courses?.count {
            case 0:
                EmptyView()
            case 1:
                ForEach(courseListVM.courses, id: \.courseId) {course in
                    TeeBoxListScreen_1Course(club: club ,course: course)
                }

            case _ where club.club.courses?.count ?? 0 > 1:
                List(courseListVM.courses, id: \.courseId){course in
                    NavigationLink(value: course, label: {
                        CourseListRowItem(course: course)
                    })
                }
                .listStyle(PlainListStyle())
                .navigationDestination(for: CourseViewModel.self){course in
                    TeeBoxListScreen(course: course)
                }
                
                
                
//                List{
//                    ForEach(courseListVM.courses, id: \.courseId) { course in
//                        
//                        NavigationLink(
//                            destination: TeeBoxListScreen(course: course)) {
//                                CourseListRowItem(course: course)
//                            }
//                            
//                        
//                    }.onDelete(perform: deleteCourse)
//                }.listStyle(PlainListStyle())
            default:
                EmptyView()
            }
        }
    }
    
    
    private func deleteCourse(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let course = courseListVM.courses[index]
            // delete the course
            courseListVM.deleteCourse(course: course)

            
            
         
        }
    }
    private func onAdd() {
        isPresented = true
    }
    private func onEdit() {
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
            Image(uiImage: club.clubImage)
                .resizable()
                .cornerRadius(50)
                .frame(width:300, height: 200)
//                .background(Color.black.opacity(0.2))
                .aspectRatio(contentMode: .fill)
                .padding(20)
                
            Divider()
            CoursePicker
            
            
//            Text(club.club.course22?.count.formatted() ?? "")
//                .toolbar {
//                            
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        editButton
//                    }
//                            
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        addButton
//                    }
//                            
//                }
                .navigationTitle(club.name)
            
                //NEED TO AMEND THIS BELOW
                .navigationBarItems(trailing: HStack{
                    editButton
                    addButton
                })
                
             
//                .embedInNavigationView()
                
                
                
                .sheet(isPresented: $isPresented, onDismiss: {
                    courseListVM.getCoursesByClub(vm: club)
                }, content: {
                    AddCourseScreen(club: club)
                })
                .sheet(isPresented: $isPresentedEdit, onDismiss: {
                    courseListVM.getCoursesByClub(vm: club)
                }, content: {
                    EditClubScreen(needsRefresh: $needsRefresh, club: club)
                })
            
            
                .onAppear(perform: {
                    courseListVM.getCoursesByClub(vm: club)
                })
        }
    }
}

struct CourseListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let club = ClubViewModel(club: Club.example)
        CourseListScreen(club: club, needsRefresh: .constant(false))//.embedInNavigationView()
            .environmentObject(CoreDataManager.previewClub)
    }
       
}
