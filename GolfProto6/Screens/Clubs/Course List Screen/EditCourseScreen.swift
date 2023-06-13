//
//  EditCourseScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 20/03/2023.
//

import SwiftUI

struct EditCourseScreen: View {
    
    let manager = CoreDataManager.shared
    let course: CourseViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var courseListVM = CourseListViewModel()
    @StateObject private var editCourseVM = EditCourseViewModel()
    @State private var showingSheet: Bool = false
    
    private func loadDefaultValues() {
        if !course.name.isEmpty {
            self.editCourseVM.name = course.name
        }
    }
    
    var body: some View {
        Form{
            TextField("Course name", text: $editCourseVM.name)
            Button("Save") {
                let course = manager.getCourseById(id: course.courseId)
                course?.name = editCourseVM.name
                manager.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Edit course")
           // .embedInNavigationView()
            .onAppear(perform: loadDefaultValues)
        
    }
}

struct EditCourseScreen_Previews: PreviewProvider {
    static var previews: some View {
        let course = CourseViewModel(course: Course(context: CoreDataManager.shared.viewContext))
        EditCourseScreen(course: course)
    }
}
