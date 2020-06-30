//
//  SendMoney.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-16.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct SendMoney: View {
    
    let cards = CardM.all()
    var beneficiaries = BeneficiaryList.all()
    @State var recipient = BeneficiaryList(name: "", avatar: "")
    
    @State var amount = ""
    @State var invalidField: Bool = false
    
    @State var showModal: Bool = false
    @State var bottomState = CGSize.zero
    @State var isSelectedCard: Bool = false
    @State var selectedCard: String = ""
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater1)
            
            //MARK: - Body Stack
            VStack {
                VStack (spacing: 30) {
                    
                    VStack (spacing: 10) {
                        Text("Total Balance").modifier(H6(color: .grey))
                        Text("$12,354.56").modifier(H2(color: .white))
                    }
                    
                    //MARK:- Card Stack
                    VStack (alignment: .leading) {
                        Text("Choose Card").modifier(H4(color: .white))
                            .padding(.leading, K.CustomUIConstraints.hPadding)
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (spacing: 20) {
                                ForEach (cards) { card in
                                    Button(action: {
                                        self.selectedCard = card.name
                                        print("Selected Card is \(self.selectedCard)")
                                        self.isSelectedCard.toggle()
                                        
                                    }) {
                                        CardSmall(isSelected: self.$isSelectedCard, card: card).frame(width: screenWidth / 1.5)
                                    }
                                }
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        }
                    }.padding(.top, 15)
                    
                    //MARK: - Recipients
                    VStack (alignment: .leading) {
                        Text("Send to").modifier(H4(color: .white)).padding(.leading, K.CustomUIConstraints.hPadding)
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (spacing: 15) {
                                
                                ForEach(beneficiaries) { i in
                                    Button(action: {
                                        self.recipient = i
                                        if !self.showModal {
                                            self.showModal.toggle()
                                        }
                                    }) {
                                        BeneficiaryAvatar(image: i.avatar)
                                    }
                                }
                                Button(action: {
                                    
                                }) {
                                    IconsWrapped_Custom(icon: .arrowFromTop)
                                }
                                
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        }
                    }
                    Spacer()
                    
                }
                
            }
            .padding(.top, K.CustomUIConstraints.topPadding)
            
            //MARK: - Bottom Modal
                VStack {
                    Spacer()
                    BeneficiaryModal(invalidField: $invalidField, recipient: $recipient, textValue: amount)
                        .offset(y: showModal ? 0 : screenHeight / 2)
                        
                        .offset(y: self.bottomState.height)
                        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                        .animation(Animation.easeInOut.delay(0.6))
                .gesture(DragGesture().onChanged { value in
                        self.bottomState = value.translation
                        if self.bottomState.height < -5 {
                            self.bottomState.height = -5
                        }

                    }
                .onEnded { value in
                    if self.bottomState.height > 200 {
                        self.showModal = false
                    }
                    if (self.bottomState.height < -50 && !self.showModal) {
                        self.bottomState.height = -50
                        //self.showModal = true
                    } else {
                        self.bottomState = .zero
                        //self.showModal = false
                    }
                    }
                    
                )
                }.edgesIgnoringSafeArea(.all)


            MainNavigation(header: .sendMoney)
        }
    }
}

struct SendMoney_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SendMoney().previewDevice("iPhone 8")
            SendMoney().previewDevice("iPhone 11 Pro")
            SendMoney().previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct BeneficiaryAvatar: View {
    var image: String
    var body: some View {
        Image(image).renderingMode(.original)
        .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .cornerRadius(8)
    }
}

struct BeneficiaryModal: View {
    
    @Binding var invalidField: Bool
    
    @Binding var recipient: BeneficiaryList
    
    var textValue: String
    //var label: String
    var body: some View {
        
        VStack {
            //Selected Stack
            Color.gray
                .frame(width: 70, height: 5).opacity(0.3)
                .cornerRadius(2)
                
            HStack {
                VStack (alignment: .leading) {
                    Text("Selected").modifier(TextFieldLbl())
                    Text(recipient.name).modifier(H6(color: .white))
                    .animation(Animation.easeInOut.delay(0.6))
                }
                Spacer()
                BeneficiaryAvatar(image: recipient.avatar)
                .animation(Animation.easeInOut.delay(0.6))
            }
            
            VStack {
                Text("")
//               TextFldNIcons(placeHolder: "Enter your narration", textValue: textValue, invalidField: invalidField, label: "Notes")
                 //.animation(Animation.easeInOut.delay(0.9))
            }
            
            //Button and Amount Stack
            HStack (alignment: .bottom, spacing: 20) {
//                TextFldNIcons(placeHolder: "Amount", textValue: textValue, invalidField: invalidField, label: "Amount")
                
                Button(action: {
                    
                }) {
                    PrimaryButton(label: "Send")
                }

            }
            
        }
        .padding([.bottom, .horizontal], 25)
        .padding(.top, 10)
        //.padding(.bottom, 40)
        .background(Color(Colors.tb6.rawValue))
        .cornerRadius(20)
        
        
    }
}

struct BeneficiaryList: Identifiable {
    var id = UUID()
    let name: String
    let avatar: String
}

extension BeneficiaryList {
    static func all () -> [BeneficiaryList] {
        return [
        BeneficiaryList(name: "Cynthia Jameson", avatar: "Avatar1"),
        BeneficiaryList(name: "Brandson Peter", avatar: "Avatar2"),
        BeneficiaryList(name: "June May", avatar: "Avatar3"),
        BeneficiaryList(name: "Linda Coldstone", avatar: "Avatar4"),
        BeneficiaryList(name: "Sandra Bullock", avatar: "Avatar5")
        ]
    }
}
