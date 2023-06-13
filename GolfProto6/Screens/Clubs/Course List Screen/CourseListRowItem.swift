//
//  CourseListRowItem.swift
//  GolfProto01
//
//  Created by Philip Nye on 17/03/2023.
//

import SwiftUI

struct CourseListRowItem: View {
    @StateObject private var courseListVM = CourseListViewModel()
    @StateObject private var teeBoxListVM = TeeBoxListViewModel()
    @EnvironmentObject private var coreDataManager: CoreDataManager
    let course: CourseViewModel
    
    var body: some View {
        HStack{
            Text(course.name)
            Spacer()
            HStack{
                ForEach(teeBoxListVM.teeBoxes.sorted(by: {$0.totalDistance > $1.totalDistance}), id: \.teeBoxId) { teeBox in
                    HStack{
                        
                    }.frame(width:20, height:20)
                        .background(Color(teeBox.teeBoxColor))
                        .border(.black.opacity(0.2))
                }
            }
        }
        .onAppear(perform: {
            teeBoxListVM.getTeeBoxesByCourse(vm: course)
        })
    }
}

struct CourseListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        let course = CourseViewModel(course: Course(context: CoreDataManager.shared.viewContext))
        CourseListRowItem(course: course)
    }
}
