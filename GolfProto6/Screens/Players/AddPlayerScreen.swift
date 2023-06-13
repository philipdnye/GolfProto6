//
//  AddPlayerScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import SwiftUI

struct AddPlayerScreen: View {
    @StateObject private var addPlayerVM = AddPlayerViewModel()
    @State private var image = UIImage()
    @State private var showingSheet = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            
            TextField("First name", text: $addPlayerVM.firstName)
            TextField("Last name", text: $addPlayerVM.lastName)
            DatePicker(selection: $addPlayerVM.dateOfBirth, in: ...Date(),displayedComponents: .date) {
                Text("Date of birth:")
            }
//            TextField("Date of birth", text: $addPlayerVM.dateOfBirth)
            //TextField("Gender", text: $addPlayerVM.gender)
            
           // let filteredGameFormats = GameFormatType.allCases.filter({$0.NoOfPlayers() == playerCount})
            
            
            Picker("Gender", selection: $addPlayerVM.pickerGender){
                ForEach(PlayerGender.allCases, id: \.self) {
                    Text($0.stringValue())
                        .tag($0.rawValue)
                }
            }

            
            
            
            TextField("e-mail address", text: $addPlayerVM.email)
            TextField("Mobile", text: $addPlayerVM.mobile)
            TextField("Current handicap index", text:$addPlayerVM.currentHandicap)
            
            HStack {
                
                Image(uiImage: self.image)
                
                    .resizable()
                    
                    .frame(width: 125)
                    .frame(height: 155)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)).opacity(0.2), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1)).opacity(0.2)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                
                
                   
                    .aspectRatio(contentMode: .fill)
                
                
                Text("Select photo")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        showingSheet = true
                    }
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $showingSheet) {
                // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                
                //  If you wish to take a photo from camera instead:
                // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                // designcode.io
                
            }
        
        
        HStack{
            Spacer()
            Button("Save") {
                addPlayerVM.photo = self.image
                addPlayerVM.save()
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
    .navigationTitle("Add Player")
    //.embedInNavigationView()
    }
}

struct AddPlayerScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerScreen()
    }
}
