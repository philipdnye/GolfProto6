//
//  ClubListScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct ClubListScreen: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject private var clubListVM = ClubListViewModel()
    @State private var isPresented: Bool = false
    @State private var needsRefresh: Bool = false

    
    private func deleteClub(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let club = clubListVM.clubs[index]
            // delete the club
            clubListVM.deleteClub(club: club)
            // get all clubs
            clubListVM.getAllClubs1()
            
            
         
        }
    }
    
    private func onAdd() {
        isPresented = true
    }
   
    private var addButton: some View {
       AnyView(Button(action: onAdd) {Image(systemName: "plus")})
        }
    
    
    var body: some View {
        List{
            
            ForEach(clubListVM.clubs, id: \.self){club in
                
                NavigationLink(value: club, label: {
                    ClubListRowItem(needsRefresh: $needsRefresh, club: club)
                })
                
                
            }
            .onDelete(perform: deleteClub)
        }
        .navigationDestination(for: ClubViewModel.self){club in
                CourseListScreen(club: club, needsRefresh: $needsRefresh)
            }
        

            .toolbar {

                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }

                

            }
            
//            .navigationTitle("Clubs")
//            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isPresented, onDismiss: {
                clubListVM.getAllClubs1()
            }, content: {
                AddClubScreen()
            })

            .onAppear(perform: {
                clubListVM.getAllClubs1()

            })
            
        }
}

struct ClubListScreen_Previews: PreviewProvider {
  
    static var previews: some View {
        NavigationStack{
            ClubListScreen()
        }
        .environmentObject(CoreDataManager.previewClub)
    }
}
