//
//  AddCoursesScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct AddCourseScreen: View {
    
    @StateObject private var addCourseVM = AddCourseViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let club: ClubViewModel
    
    var body: some View {
        Form {
            TextField("Enter name", text: $addCourseVM.name)
//            TextEditor(text: $addReviewVM.text)
            
            HStack {
                Spacer()
                Button("Save") {
                    addCourseVM.addCourseToClub(vm: club)
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }

        }
        .navigationTitle("Add Course")
        //.embedInNavigationView()
    }
}

struct AddCourseScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let club = ClubViewModel(club: Club(context: CoreDataManager.shared.viewContext))
        AddCourseScreen(club: club)
    }
}
