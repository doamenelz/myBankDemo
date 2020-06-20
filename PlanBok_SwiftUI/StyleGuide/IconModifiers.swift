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
                IconsWrapped_SF(icon: .iconShield)
                IconsWrapped_SF(icon: .cards)
                IconsWrapped_SF(icon: .notifications)
                IconsWrapped_SF(icon: .support)
                IconsWrapped_Custom(icon: .clipBoard)
                IconsWrapped_Custom(icon: .bell)
                IconsWrapped_Custom(icon: .chat)
                IconsWrapped_Custom(icon: .creditcard)
                IconsWrapped_Custom(icon: .globe)
                
            }
        }
    }
}

struct IconModifiers_Previews: PreviewProvider {
    static var previews: some View {
        IconModifiers()
    }
}

///SF Icons wrapped with rectangle border
struct IconsWrapped_SF : View {
    var icon: SFIcons
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

///Custom Icons wrapped with rectangle border
struct IconsWrapped_Custom : View {
    var icon: CustomSymbols
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


///Custom Symbols no wrap
enum CustomSymbols: String {
    case globe = "Globe"
    case chat = "Chat"
    case bell = "Bell"
    case lockShield = "LockShield"
    case creditcard = "CreditCard"
    case clipBoard = "ClipBoard"
    case logout = "Logout"
    case arrowFromTop = "ArrowFromTop"
    case arrowToBottom = "ArrowToBottom"
    case edit = "Edit"
    case email = "Email"
    case menu = "Menu"
    case notifications = "Notifications"
    case moreActions = "MoreActions"
}

enum Wallpapers: String {
    case Floater1 = "Floater1"
    case Floater2 = "Floater2"
    case Floater3 = "Floater3"
    case Floater4 = "Floater4"
    case Floater5 = "Floater5"
    case none = "F"
}

///SF Icons for this project
enum SFIcons: String {
    case chevronDownCircle = "chevron.down.circle.fill"
    case chevronDown = "chevron.down"
    case chevronUp = "chevron.up"
    case exclaimation = "exclamationmark.triangle.fill"
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case success = "checkmark.circle.fill"
    case iconShield = "lock.shield.fill"
    case cards = "creditcard.fill"
    case notifications = "bell.fill"
    case support = "bubble.left.and.bubble.right.fill"
    
    
}

