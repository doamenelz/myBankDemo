//
//  IconModifiers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-13.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct IconModifiers: View {
    var body: some View {
        ZStack {
            BackGround()
            VStack (spacing: 20) {
                IconWrapper(icon: .iconShield)
                IconWrapper(icon: .cards)
                IconWrapper(icon: .notifications)
                IconWrapper(icon: .support)
                Icons(icon: .clipBoard)
                Icons(icon: .bell)
                Icons(icon: .chat)
                Icons(icon: .creditcard)
                Icons(icon: .globe)
                
                
                //IconWrapper(icon: .iconShield)
                
            }
        }
    }
}

struct IconModifiers_Previews: PreviewProvider {
    static var previews: some View {
        IconModifiers()
    }
}

struct IconWrapper : View {
    var icon: SystemIcons
    var body: some View {
        Image(systemName: icon.rawValue)
            .foregroundColor(Color("p1"))
            .padding()
            .overlay(
            RoundedRectangle(cornerRadius: 8)
            .stroke(Color("p1"), lineWidth: 1)
                .frame(width: 40, height: 40)
        )
    }
}

struct Icons : View {
    var icon: CustomIconsUnwrapped
    var body: some View {
        Image(icon.rawValue)
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .overlay(
            RoundedRectangle(cornerRadius: 8)
            .stroke(Color("p1"), lineWidth: 1)
                .frame(width: 40, height: 40)
                .padding()
                
                
        )
    }
}

///Custom System Icons for this project
enum SystemIcons: String {
    case iconShield = "lock.shield.fill"
    case cards = "creditcard.fill"
    case notifications = "bell.fill"
    case support = "bubble.left.and.bubble.right.fill"
}

enum CustomIconsUnwrapped: String {
    case globe = "Globe"
    case chat = "Chat"
    case bell = "Bell"
    case lockShield = "LockShield"
    case creditcard = "CreditCard"
    case clipBoard = "ClipBoard"
    case logout = "Logout"
}

enum Wallpapers: String {
    case Floater1 = "Floater1"
    case Floater2 = "Floater2"
    case Floater3 = "Floater3"
    case Floater4 = "Floater4"
    case Floater5 = "Floater5"
}

enum IconsEnum: String {
    case chevronDownCircle = "chevron.down.circle.fill"
    case chevronDown = "chevron.down"
    case exclaimation = "exclamationmark.triangle.fill"
    case chevronLeft = "chevron.left"
    case success = "checkmark.circle.fill"
    case edit = "Edit"
    
}

