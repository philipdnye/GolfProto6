//
//  EditClubViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 20/03/2023.
//

import Foundation
import SwiftUI

class EditClubViewModel: ObservableObject {


    var name: String = ""
    var addressLine1: String = ""
    var addressLine2: String = ""
    var addressLine3: String = ""
    var addressLine4: String = ""
    var postCode: String = ""
    //var distMetric: Int16 = 0
    var eMail: String = ""
    var clubImage: UIImage = UIImage()
    @Published var pickerDistMetric: Int = 0

    
}
