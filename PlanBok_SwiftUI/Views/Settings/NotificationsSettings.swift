//
//  NotificationsSettings.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-14.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct NotificationsSettings: View {
    
    @State var mailEnabled: Bool = false
    
    var body: some View {
        
        //MARK: - Main View
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            //MARK: - Body Stack
            VStack {
                VStack {
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        ButtonCell(isOn: $mailEnabled, controlType: .switches, label: "Mail")
                    }
                    Button(action: {}) {
                        ButtonCell(isOn: $mailEnabled, controlType: .switches, label: "SMS")
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        ButtonCell(isOn: $mailEnabled, controlType: .switches, label: "Push Notifications")
                    }
                }
                Spacer()
            }
            .padding(.top, K.CustomUIConstraints.topPadding)
            .padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            //MARK: - Nav Stack
            SecondaryNavigation(header: "Notifications")
        }
    }
}

struct NotificationsSettings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotificationsSettings().previewDevice("iPhone 8")
            NotificationsSettings().previewDevice("iPhone 11 Pro Max")
        }
    }
}
