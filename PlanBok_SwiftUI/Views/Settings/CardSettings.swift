//
//  CardSettings.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-14.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct CardSettings: View {
    
    @State var cardLockStatus: Bool = false
    
    let cards = CardM.all()
    
    var body: some View {
        ZStack {
            
            //MARK: - Background
            
            BackGround(wallpaper: .Floater2)
            
            //MARK: - Body Stack
            VStack {
                
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack (spacing: 20){
                        ForEach(cards) { card in
                            Button(action: {
                                
                            }) {
                                Text("")
//                                Card(isCheckBoxStyled: true, card: card)
//                                .frame(width: screenWidth - 60)
                            }
                        }
                    }.padding(.horizontal, 30)
                }
                VStack {
                    ButtonCell(isOn: $cardLockStatus, controlType: .switches, label: "Lock Card")
                    Button(action: {
                        
                    }) {
                        VStack (alignment: .leading) {
                            Text("Remove Card").modifier(H6(color: .p1))
                            CellDivider()
                        }.frame(height: 65)
                    }
                }.padding([.horizontal,.top], K.CustomUIConstraints.hPadding)
                Spacer()
            }.padding(.top, K.CustomUIConstraints.topPadding)
        
            //MARK: - Nav Stack
            SecondaryNavigation(header: "Cards")
        
        }
    }
}

struct CardSettings_Previews: PreviewProvider {
    static var previews: some View {
        CardSettings()
    }
}


struct Card: View {
    
    var isCheckBoxStyled: Bool
    
    let card: CustomerCard
    
    
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 30) {
                //Headers
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Balance").modifier(H6(color: .grey))
                        Text("$ \(card.balance)").modifier(H3(color: .white))
                    }
                    Spacer()
                    if isCheckBoxStyled {
                        CheckBox(shapeStyle: .square)
                    }
                    
                }
                HStack {
                    Text("****").modifier(H3(color: .white))
                    Spacer()
                    Text("****").modifier(H3(color: .white))
                    Spacer()
                    Text("****").modifier(H3(color: .white))
                    Spacer()
                    Text("\(card.cardNumber)").modifier(H3(color: .white))
                    
                }
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text(card.expiryDate).modifier(TextFieldLbl())
                        Text(card.cardName).modifier(TextFieldLbl())
                    }
                    Spacer()
                    Image(card.cardProvider).renderingMode(.original)
                }
                
            }.padding(.all, 30)
                //.padding(.vertical, 20)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(Colors.tb6.rawValue), Color(Colors.tb4.rawValue).opacity(0.6)]), startPoint: .top, endPoint: .bottom))
        .shadow(radius: 20)
        .cornerRadius(20)
    }
}


struct CardSmall: View {
    
    @Binding var isSelected: Bool
    
    let card: CardM
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 10) {
                //Headers
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("Balance").modifier(TextFieldLbl())
                        Text("$ \(card.balance)").modifier(H4(color: .white))
                    }
                    Spacer()
                    
                    if isSelected {
                       CheckBox(shapeStyle: .rounded)
                    }
                }
                
                HStack {
                    Text("****").modifier(H6(color: .white))
                    Spacer()
                    Text("****").modifier(H6(color: .white))
                    Spacer()
                    Text("****").modifier(H6(color: .white))
                    Spacer()
                    Text(card.last4Digits).modifier(H6(color: .white))
                    
                }
                
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text(card.expiry).modifier(TextFieldLbl())
                        Text(card.name).modifier(TextFieldLbl())
                    }
                    Spacer()
                    Image(card.type).renderingMode(.original)
                }
                
            }.padding(.all, 20)
                //.padding(.vertical, 20)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(Colors.tb6.rawValue), Color(Colors.tb4.rawValue).opacity(0.6)]), startPoint: .top, endPoint: .bottom))
        .shadow(radius: 20)
        .cornerRadius(10)
    }}

