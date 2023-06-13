//
//  TeeBoxDistancesSubScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 19/04/2023.
//

import SwiftUI

struct TeeBoxDistancesSubScreen: View {
    let teeBox: TeeBoxViewModel
    var body: some View {
        let DMI = teeBox.teeBox.course?.club?.dist_metric.stringValueInitial() ?? ""
        Text(String(teeBox.totalDistance)+DMI)
        Text(String(teeBox.totalDistanceFront9)+DMI)
        Text(String(teeBox.totalDistanceBack9)+DMI)
    }
}

struct TeeBoxDistancesSubScreen_Previews: PreviewProvider {
    static var previews: some View {
        let teeBox = TeeBoxViewModel(teeBox: TeeBox(context: CoreDataManager.shared.viewContext))
        TeeBoxDistancesSubScreen(teeBox: teeBox)
    }
}
