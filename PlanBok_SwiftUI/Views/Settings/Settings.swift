//
//  Settings.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-13.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    let settingsLanding = SettingsLanding.all()
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            //MARK: - Settings Stack
            ScrollView (showsIndicators: false) {
                
                //Profile
                VStack (spacing: 20) {
                    VStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            ProfileCell()//.padding(.bottom, 50)
                        }
                    }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        .padding(.vertical)
                    
                    //CTA Stack
                    VStack {
                        ForEach(settingsLanding) { item in
                            Button(action: {
                                
                            }) {
                                SettingsCell(settingItem: item)
                            }
                        }
                    }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                    .padding(.bottom, 70)
                }
                
                
            }.offset(y: 70)
            
            //MARK: - Main Navigation
            MainNavigation(header: .wallet)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Settings().previewDevice("iPhone 8")
            Settings().previewDevice("iPhone 11 Pro")
        }
    }
}

struct SettingsCell: View {
    
    var settingItem: SettingsLanding
    var body: some View{
        VStack (alignment: .leading, spacing: 5) {
            HStack (spacing: 20) {
                IconsWrapped_Custom(icon: CustomSymbols(rawValue: settingItem.image.icon.rawValue)!)
                Text(settingItem.label).modifier(H6(color: .white))
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue)).opacity(0.5)
                
            }.padding(.top, 5)
            Path{ path in
                path.move(to: CGPoint(x: 10, y: 10))
                path.addLine(to: CGPoint(x: screenWidth, y: 10))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5])).cornerRadius(10)
            .foregroundColor(Color("tb6"))
        }
    }
}

struct SettingsLanding: Identifiable {
    let id = UUID()
    let label: String
    let image: IconsWrapped_Custom
    //let icon: Icons
}

extension SettingsLanding {
    
    static func all() -> [SettingsLanding] {
        return [
            SettingsLanding(label: "Language", image: .init(icon: .globe)),
            SettingsLanding(label: "Cards", image: .init(icon: .creditcard)),
            SettingsLanding(label: "Security", image: .init(icon: .lockShield)),
            SettingsLanding(label: "Notifications", image: .init(icon: .bell)),
            SettingsLanding(label: "Support", image: .init(icon: .chat)),
            SettingsLanding(label: "Terms of Service", image: .init(icon: .clipBoard)),
            SettingsLanding(label: "Logout", image: .init(icon: .logout))
        ]
    }
    
}

struct ProfileCell: View {
    var body: some View {
        HStack (spacing: 20) {
            Image("Avatar4").renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48)
                .cornerRadius(8)
            VStack (alignment: .leading) {
                Text("Camilla Lindstrom").modifier(H6(color: .white))
                Text("camillaLindstrom@yahoo.com").modifier(TextFieldLbl())
            }
            
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue))
        }
    }
}
