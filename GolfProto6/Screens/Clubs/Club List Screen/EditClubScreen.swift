//
//  EditClubScreen1.swift
//  GolfProto01
//
//  Created by Philip Nye on 20/03/2023.
//

import SwiftUI
//if let myString = string where !myString.isEmpty
struct EditClubScreen: View {
    let manager = CoreDataManager.shared
    @Binding var needsRefresh: Bool
    @Environment(\.presentationMode) var presentationMode
    let club: ClubViewModel
    @StateObject private var clubListVM = ClubListViewModel()
    @StateObject private var editClubVM = EditClubViewModel()
    @State private var showSheet: Bool = false
    @State private var image = UIImage()
//    @Binding var needsRefresh: Bool
    private func loadDefaultValues() {
        if !club.name.isEmpty {
            self.editClubVM.name = club.name
        }
        if !club.addressLine1.isEmpty {
            self.editClubVM.addressLine1 = club.addressLine1
        }
        if !club.addressLine2.isEmpty {
            self.editClubVM.addressLine2 = club.addressLine2
        }
        if !club.addressLine3.isEmpty {
            self.editClubVM.addressLine3 = club.addressLine3
        }
        if !club.addressLine4.isEmpty {
            self.editClubVM.addressLine4 = club.addressLine4
        }
        if !club.postCode.isEmpty {
            self.editClubVM.postCode = club.postCode
        }
//        if !club.distMetric.isEmpty {
//            self.editClubVM.distMetric = club.distMetric
//        }
        self.editClubVM.pickerDistMetric = Int(club.distMetric)
        
        if !club.postCode.isEmpty {
            self.editClubVM.eMail = club.eMail
        }
        self.image = club.clubImage
        
        
    }
    var body: some View {
        
        
        
       Form{
            TextField("Club name", text: $editClubVM.name)
            TextField("Address line 1", text: $editClubVM.addressLine1)
            TextField("Address line 2", text: $editClubVM.addressLine2)
            TextField("Address line 3", text: $editClubVM.addressLine3)
            TextField("Address line 4", text: $editClubVM.addressLine4)
            TextField("Postcode", text: $editClubVM.postCode)
           Picker("Distance metric",selection: $editClubVM.pickerDistMetric){
               ForEach(DistMetric.allCases, id: \.self){
                   Text($0.stringValue())
                       .tag($0.rawValue)
                   
               }
           }
           
           
           //TextField("distMetric", text: $editClubVM.distMetric) NEEDS to be a picker
            TextField("email", text: $editClubVM.eMail)
            
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
                   let club = manager.getClubById(id: club.id)
//                   editClubVM.clubImage = self.image
//                   editClubVM.save(club: club)
                   
                   club?.name = editClubVM.name
                   club?.addressLine1 = editClubVM.addressLine1
                   club?.addressLine2 = editClubVM.addressLine2
                   club?.addressLine3 = editClubVM.addressLine3
                   club?.addressLine4 = editClubVM.addressLine4
                   club?.postCode = editClubVM.postCode
                   //club?.distMetric = editClubVM.distMetric
                   club?.distMetric = Int16(editClubVM.pickerDistMetric)
                   club?.email = editClubVM.eMail
                   club?.clubImage = self.image
                   
                   manager.save()
                   needsRefresh.toggle()
                   clubListVM.getAllClubs1()
                   presentationMode.wrappedValue.dismiss()
               }
               Spacer()
           }
        }
        .navigationTitle("Edit \(club.name)")
            //.embedInNavigationView()
            .onAppear(perform: loadDefaultValues)
    }
}

struct EditClubScreen_Previews: PreviewProvider {
    static var previews: some View {
        let club = ClubViewModel(club: Club.example)
        EditClubScreen(needsRefresh: .constant(false),club: club)
    }
}
