//
//  AddClubScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct AddClubScreen: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    @StateObject private var addClubVM = AddEditClubViewModel()
    @State private var image = UIImage()
    @State private var showSheet = false
//    @FocusState private var nameIsFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    
//    @State private var name: String = ""
//    @State private var addressLine1: String = ""
//    @State private var addressLine2: String = ""
//    @State private var addressLine3: String = ""
//    @State private var addressLine4: String = ""
//    @State private var postCode: String = ""
//    @State private var distMetric: String = ""
//    @State private var eMail: String = ""
    
    var body: some View {
        Form{
          
                TextField("Enter club name", text: $addClubVM.name)
//                .focused($nameIsFocused)
//                .keyboardType(.default)
                TextField("Enter address line 1", text: $addClubVM.addressLine1)
                TextField("Enter address line 2", text: $addClubVM.addressLine2)
                TextField("Enter address line 3", text: $addClubVM.addressLine3)
                TextField("Enter address line 4", text: $addClubVM.addressLine4)
                TextField("Enter postcode", text: $addClubVM.postCode)
            
            Picker("Distance metric",selection: $addClubVM.pickerDistMetric){
                ForEach(DistMetric.allCases, id: \.self){
                    Text($0.stringValue())
                        .tag($0.rawValue)
                    
                }
            }
            
            
            
                //TextField("Enter distance metric", text: $addClubVM.distMetric)
                TextField("Enter email address", text: $addClubVM.eMail)
       
            HStack {
                
                Image(uiImage: self.image)
                
                    .resizable()
                    
                    .frame(width: 125)
                    .frame(height: 80)
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
                        showSheet = true
                    }
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $showSheet) {
                // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                
                //  If you wish to take a photo from camera instead:
                // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                // designcode.io
                
            }
            
            
            
            
            
            
            
            HStack{
                Spacer()
                Button("Save") {
                    addClubVM.clubImage = self.image
                    //coreDataManager.saveClubPreview(named: addClubVM.name)
                    addClubVM.save()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
        .navigationTitle("Add Club")
        //.embedInNavigationView()
    }
}

struct AddClubScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddClubScreen()
        }
        .environmentObject(CoreDataManager.previewClub)
    }
}
