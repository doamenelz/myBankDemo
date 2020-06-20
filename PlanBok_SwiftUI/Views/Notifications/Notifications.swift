//
//  Notifications.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-16.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Notifications: View {
    
    let allNotifications = Notification.all()
    var body: some View {
        
        ZStack {
            BackGround(wallpaper: .none)
            
            //MARK: - Body Stack
            VStack {
                //COntent
                ScrollView (showsIndicators: false) {
                    VStack {
                        ForEach(allNotifications) { notification in
                            
                            //Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                NotificationCell(notification: notification)
                            //}
                        }
                    }
                }
                Spacer()
            }.padding(.top, K.CustomUIConstraints.topPadding)
                .padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            SecondaryNavigation(header: "Notifications")
        }
        
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Notifications().previewDevice("iPhone 8")
            Notifications().previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct NotificationCell: View {
    
    var notification: Notification
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                HStack {
                    Circle()
                        .foregroundColor(Color(Colors.p1.rawValue))
                        .frame(width: 10, height: 10)
                    Image(notification.senderAvatar)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                }
                VStack (alignment: .leading, spacing: 5) {
                    Text(notification.sender).modifier(H7(color: .p1))
                    Text(notification.notificationContent).modifier(H8(color: .white)).lineLimit(2)
                    Text(notification.timeOfNot).modifier(TextFieldLbl())
                }
                
            }
            CellDivider()
        }
        
    }
}

struct Notification: Identifiable {
    let id = UUID()
    let sender: String
    let senderAvatar: String
    let timeOfNot: String
    let notificationContent: String
}

extension Notification {
    static func all() -> [Notification] {
        return [
        Notification(sender: "Natalie Gomez", senderAvatar: "Avatar1", timeOfNot: "5 minutes ago", notificationContent: "This a new connect from Natalie"),
        Notification(sender: "John Cena", senderAvatar: "Avatar2", timeOfNot: "15 minutes ago", notificationContent: "New voucher available for purchase"),
        Notification(sender: "Linda Lindstrom", senderAvatar: "Avatar3", timeOfNot: "25 minutes ago", notificationContent: "Youve just received $10,000"),
        Notification(sender: "Jennifer Lida", senderAvatar: "Avatar4", timeOfNot: "35 minutes ago", notificationContent: "This a new connect from Natalie"),
        Notification(sender: "Cynthia Rothruck", senderAvatar: "Avatar5", timeOfNot: "45 minutes ago", notificationContent: "This a new connect from Natalie"),
        Notification(sender: "Giselle Gomez", senderAvatar: "Avatar6", timeOfNot: "55 minutes ago", notificationContent: "This a new connect from Natalie"),
        Notification(sender: "Crystie Gomez", senderAvatar: "Avatar1", timeOfNot: "58 minutes ago", notificationContent: "This a new connect from Natalie")
        
        ]
    }
}
