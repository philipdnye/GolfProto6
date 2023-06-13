//
//  ClubListRowItem.swift
//  GolfProto01
//
//  Created by Philip Nye on 17/03/2023.
//

import SwiftUI

struct ClubListRowItem: View {
    
    @StateObject private var clubListVM = ClubListViewModel()
    @Binding var needsRefresh: Bool
    let club: ClubViewModel
    var body: some View {
        HStack{
            
            Text(club.name)
               
                        .font(.title2)
                        .foregroundColor(.orange)
            Spacer()
            ZStack{
                Text(needsRefresh.description)
                    .opacity(0.0)
                Image(uiImage: club.clubImage)
                   
                    .resizable()
                
                    .frame(width: 75)
                    .frame(height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)).opacity(0.2), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1)).opacity(0.2)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                
                
                //                .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
            }
            //NavigationLink("", value: club)
             
            
            
        }
    }
}

struct ClubListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        let club = ClubViewModel(club: Club.example)
        ClubListRowItem(needsRefresh: .constant(false),club: club)//.embedInNavigationView()
            .environmentObject(CoreDataManager.previewClub)
    }
}
