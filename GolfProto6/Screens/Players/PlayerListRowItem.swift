//
//  PlayerListRowItem.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import SwiftUI

struct PlayerListRowItem: View {
    @StateObject private var playerListVM = PlayerListViewModel()
    @Binding var needsRefresh: Bool
    let player: PlayerViewModel
    var body: some View {
        
        
        HStack{
            HStack(spacing:0){
                Text(player.lastName)
                Text(", ")
                Text(player.firstName)
                
                Text(" (\(player.player.pl_genderInitial())) ")
                Text(player.player.handicapArray.currentHandicapIndex().formatted())
            }
                        .font(.title3)
                        .foregroundColor(darkTeal)
            Spacer()
           
//
                Image(uiImage: player.player.photo ?? UIImage())
                   
                    .resizable()
                
                    .frame(width: 35)
                    .frame(height: 40)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)).opacity(0.2), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1)).opacity(0.15)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical,1)
                
                
                
                //                .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
            
//            NavigationLink("", value: player)
//                .frame(width:0)
            
        }
    }
}

struct PlayerListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        let player = PlayerViewModel(player: Player(context: CoreDataManager.shared.viewContext))
        PlayerListRowItem(needsRefresh: .constant(false), player: player)//.embedInNavigationView()
    }
}
