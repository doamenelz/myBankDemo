//
//  Security.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-14.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Security: View {
    
    @State var tog: Bool = false
    @State var enableFaceIDTog: Bool = false
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            //MARK: - Body Stack
            VStack {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    ButtonCell(isOn: $tog, controlType: .none, label: "Change Password")
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    ButtonCell(isOn: $tog, controlType: .none, label: "Change Transaction Code")
                }

                Button(action: {
                    self.enableFaceIDTog.toggle()
                }) {
                    ButtonCell(isOn: $enableFaceIDTog, controlType: .switches, label: "FaceID")
                }
                
                Spacer()
            }.padding(.top, 70)
            .padding(.vertical)
            .padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            SecondaryNavigation(header: "Security")
            
        }
    }
}

struct Security_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Security().previewDevice("iPhone 8")
            Security().previewDevice("iPhone 11 Pro Max")
        }
    }
}

/*
struct SecurityNav: View {
    //@Binding var editEnabled: Bool
    
    var header: String = "My Profile"
    var icon: String = "Menu"
    var leftIcon: String = "Notifications"
    var body: some View {
        
     HStack {
         Image(systemName: SFIcons.chevronLeft.rawValue)
             .resizable()
             .aspectRatio(contentMode: .fit)
             .frame(width: 20, height: 20)
             .foregroundColor(.white)
         Spacer()
         Text("Security").modifier(H4(color: .white))
         Spacer()
         Button(action: {
             //self.editEnabled.toggle()
            }) {
             Image(SFIcons.menu.rawValue)
                 .resizable()
                 //.renderingMode(editEnabled ? .original : .none)
                 .aspectRatio(contentMode: .fit)
                .frame(width: K.CustomUIConstraints.menuIconFrame)
                 .foregroundColor(.white)
            }

            
        }.padding(.horizontal, 30)
        //.padding(.top)
    }
}

*/

struct SecuritySettingOptions {
    let label: String
    let toggleType: ControlType
}

enum ControlType {
    case switches
    case none
    case checkBox
}
