//
//  SendMoney.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-16.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SendMoney: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var recipient: Contact = sampleContact
    
    @State var amount = ""
    @State var invalidField: Bool = false
    
    @State var showModal: Bool = false
    @State var bottomState = CGSize.zero
    @State var isSelectedCard: Bool = true
    @State var deselected: Bool = false
    @State var selectedCard: CustomerCard = sampleCard
    
    @State var goToAddContact: Bool = false
    
    @State var id: Int = 0
    
    @State var uud: UUID = UUID()
    
    @State var avatarUUD: UUID = UUID()
    
    @State var balance: String = ""
    
    //@State var selectedCard: CardM = sampleCard
    
    @ObservedObject var customerCards = CustomersCards()
    
    @ObservedObject var beneficiaries = CustomerContacts()
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater1)
            
            //MARK: - Body Stack
            
            VStack {
                VStack (spacing: 30) {
                    
                    //Total Customer Balance
                    VStack (spacing: 10) {
                        Text("Total Balance").modifier(H6(color: .grey))
                        Text(balance).modifier(H2(color: .white))
                    }
                    
                    //MARK:- Card Stack
                    VStack (alignment: .leading) {
                        Text("Choose Card").modifier(H4(color: .white))
                            .padding(.leading, K.CustomUIConstraints.hPadding)
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (spacing: 20) {
                                ForEach (customerCards.customerCards) { card in
                                    Button(action: {
                                        self.uud = card.id
                                        self.selectedCard = card
                                        
                                    }) {
                                        if self.uud == card.id {
                                            CardSmall(isSelected: self.$isSelectedCard, card: card).frame(width: screenWidth / 1.5)
                                        } else {
                                            CardSmall(isSelected: self.$deselected, card: card).frame(width: screenWidth / 1.5)
                                        }
                                        
                                    }
                                }
                                
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        }
                    }.padding(.top, 15)
                    .onAppear {
                       self.uud = self.customerCards.customerCards[0].id
                    }

                    
                    //MARK: - Recipients
                    VStack (alignment: .leading) {
                        Text("Send to").modifier(H4(color: .white)).padding(.leading, K.CustomUIConstraints.hPadding)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (alignment: .center, spacing: 5) {
                                
                                ForEach(beneficiaries.customerContacts) { i in
                                    Button(action: {
                                        self.recipient = i
                                        self.avatarUUD = i.id
                                        if !self.showModal {
                                            self.showModal.toggle()
                                        }
                                    }) {
                                        if self.avatarUUD == i.id {
                                            BeneficiaryAvatar(image: i.avatar, isSelected: self.$isSelectedCard)
                                        } else {
                                            BeneficiaryAvatar(image: i.avatar, isSelected: self.$deselected)
                                        }
                                        
                                    }
                                }
                                
                                Button(action: {
                                    self.goToAddContact.toggle()
                                    
                                }) {
                                    IconsWrapped_Custom(icon: .arrowFromTop)
                                }
                                
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        }
                    }
                    Spacer()
                    
                }.sheet(isPresented: $goToAddContact) {
                    AddContact()
                }
                
            }.onAppear {
                let bal = CardsModel.getTotalBalance(cards: self.customerCards.customerCards)
                self.balance = formatNumber(number: bal)
            }
            .padding(.top, K.CustomUIConstraints.topPadding)
            
            
            //MARK: - Bottom Modal
                VStack {
                    Spacer()
                    BeneficiaryModal(vc: viewController, invalidField: $invalidField, recipient: $recipient, textValue: $amount, toggleModal: $showModal)
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
    var image: URL
    //var imageUrl: String
    
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack {
            WebImage(url: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            //if isSelected {
            CheckBox(shapeStyle: .rounded).opacity(isSelected ? 1.0 : 0.0)
                .offset(y: -20)
            //}
            
        }
    }
    
}

struct BenModalAvatar : View {
    
    var image: URL
    //var imageUrl: String
    
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack {
            WebImage(url: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(8)
        }
    }
}

struct BeneficiaryModal: View {
    
    var vc: UIViewController?
    
    @Binding var invalidField: Bool
    
    @State var amuntMissing: Bool = false
    
    @Binding var recipient: Contact
    
    @Binding var textValue: String
    
    @State var narration: String = ""
    
    @State var isSelected: Bool = false
    
    @State var amount: Double = 0
    
    @Binding var toggleModal: Bool
    //var label: String
    var body: some View {
        
        VStack {
            Color.gray
                .frame(width: 70, height: 5).opacity(0.3)
                .cornerRadius(2)
                
            HStack (alignment: .center) {
                VStack (alignment: .leading) {
                    Text("Selected").modifier(TextFieldLbl())
                    Text(recipient.name).modifier(H6(color: .white))
                    .animation(Animation.easeInOut.delay(0.6))
                }
                Spacer()
                BenModalAvatar(image: recipient.avatar, isSelected: $isSelected)
                .animation(Animation.easeInOut.delay(0.6))
            }
            
            VStack {
                Text("")
                TextFldNIcons(placeHolder: "Enter your notes", textValue: $narration, invalidField: invalidField, label: "Notes (Optional)")
                 .animation(Animation.easeInOut.delay(0.9))
            }
            
            //Button and Amount Stack
            HStack (alignment: .bottom, spacing: 20) {
                TextFldNIcons(placeHolder: "Amount", textValue: $textValue, invalidField: amuntMissing, label: "Amount")
                
                Button(action: {
                    
                    self.amount = Double(self.textValue) ?? 0.0
                    
                    if self.amount <= 0.0 {
                        self.amuntMissing = true
                        
                    } else {
                        self.amuntMissing = false
                        let transactionInfo = SubmitTransaction(amount: self.amount, recipientId: self.recipient.email, narration: self.narration, transactionType: "debit", transactionCategory: "Transfers", recipientName: self.recipient.name)
                        self.toggleModal = false
                        self.vc?.present(presentationStyle: .fullScreen) {
                            
                            SendMoneyConfirmation(transactionInfo: transactionInfo, recipientImage: self.recipient.avatar)
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }) {
                    PrimaryButton(label: "Send")
                }

            }
            
        }
        .padding([.bottom, .horizontal], 25)
        .padding(.top, 10)
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

struct CardSmall: View {

@Binding var isSelected: Bool

var card: CustomerCard = sampleCard

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
                Text(card.cardNumber).modifier(H6(color: .white))
                
            }
            
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                    Text(card.expiryDate).modifier(TextFieldLbl())
                    Text(card.cardName).modifier(TextFieldLbl())
                }
                Spacer()
                Image(card.cardProvider).renderingMode(.original)
            }
            
        }.padding(.all, 20)
            //.padding(.vertical, 20)
    }
    .background(LinearGradient(gradient: Gradient(colors: [Color(Colors.tb6.rawValue), Color(Colors.tb4.rawValue).opacity(0.6)]), startPoint: .top, endPoint: .bottom))
    .shadow(radius: 20)
    .cornerRadius(10)
}}



