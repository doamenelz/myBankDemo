//
//  Home.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-12.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    let cards = CardM.all()
    
    var body: some View {
        ZStack {
            BackGround()
            //MARK: - Main Navigation
            VStack {
                MainNavigation(header: "Wallet", icon: "Menu")
                Spacer()
            }
            //MARK: - Header
            VStack {
                HStack {
                    Text("My Cards").modifier(H3(color: .white))
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image("Add").renderingMode(.original)
                    }
                }
                .offset(y: 80)
                .padding(.horizontal, K.CustomUIConstraints.hPadding)
                Spacer()
                //MARK:  - Card Carousel
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack (spacing: 20) {
                        ForEach(cards) { card in
                            Card(card: card)
                            .frame(width: screenWidth - 60, height: 275)
                        }
                    }.padding(30)
                }
                    
            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home().previewDevice("iPhone 8")
            Home().previewDevice("iPhone 11")
            Home().previewDevice("iPhone 11 Pro Max")
        }
        
        
    }
}

///Main Navigation View
struct MainNavigation: View {
    var header: String = "Wallet"
    var icon: String = "Menu"
    var leftIcon: String = "Notifications"
    var body: some View {
        HStack {
            Image(leftIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: K.CustomUIConstraints.menuIconFrame)
            Spacer()
            Text(header).modifier(H4(color: .white))
            Spacer()
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: K.CustomUIConstraints.menuIconFrame)
            
        }.padding(.horizontal, 30)
        .padding(.top)
            //.offset(y: screenHeight / 10 )
    }
}

struct Card: View {
    
    let card: CardM
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 30) {
                VStack (alignment: .leading, spacing: 5) {
                    Text("Balance").modifier(H6(color: .grey))
                    Text("$ \(card.balance)").modifier(H3(color: .white))
                }
                HStack {
                    Text("****").modifier(H3(color: .white))
                    Spacer()
                    Text("****").modifier(H3(color: .white))
                    Spacer()
                    Text("****").modifier(H3(color: .white))
                    Spacer()
                    Text(card.last4Digits).modifier(H3(color: .white))
                        //.frame(maxWidth: .infinity)
                }
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text(card.expiry).modifier(TextFieldLbl())
                        Text(card.name).modifier(TextFieldLbl())
                    }
                    Spacer()
                    Image("visa")
                }
                
            }.padding(.horizontal, 20)
                .padding(.vertical, 20)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(FontColors.tb6.rawValue), Color(FontColors.tb4.rawValue).opacity(0.6)]), startPoint: .top, endPoint: .bottom))
        .shadow(radius: 20)
        .cornerRadius(8)
    }
}

struct CardM: Identifiable {
    let id = UUID()
    let balance: Int
    let last4Digits: String
    let name: String
    let expiry: String
}

extension CardM {
    static func all() -> [CardM] {
        
        return [
            CardM(balance: 34567, last4Digits: "1234", name: "Sensei Lannister", expiry: "03/23"),
            CardM(balance: 234, last4Digits: "9056", name: "Sensei Lannister", expiry: "08/26"),
            CardM(balance: 90000, last4Digits: "5643", name: "Sensei Lannister", expiry: "11/23"),
            CardM(balance: 35664, last4Digits: "4564", name: "Sensei Lannister", expiry: "09/23"),
        ]
    }
}


