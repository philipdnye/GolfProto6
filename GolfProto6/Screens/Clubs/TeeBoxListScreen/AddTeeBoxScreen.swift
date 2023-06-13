//
//  AddTeeBoxScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct AddTeeBoxScreen: View {
    
    @StateObject private var addTeeBoxVM = AddTeeBoxViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let course: CourseViewModel
    
    var body: some View {
        Form {
            
            TextField("Teebox colour", text: $addTeeBoxVM.colour)
            
            ColorPicker("Select teebox colour", selection: $addTeeBoxVM.teeBoxColour)
            TextField("Course rating", text: $addTeeBoxVM.courseRating)
            TextField("Slope rating", text: $addTeeBoxVM.slopeRating)
            
            HStack {
                Spacer()
                Button("Save") {
                    addTeeBoxVM.addTeeBoxToCourse(vm: course)
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }

        }
        .navigationTitle("Add TeeBox")
//        .embedInNavigationView()
    }
}

struct AddTeeBoxScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let course = CourseViewModel(course: Course(context: CoreDataManager.shared.viewContext))
        AddTeeBoxScreen(course: course)
    }
}
