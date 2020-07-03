//
//  AddCardView.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-28.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Firebase

struct AddCardView: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
     self.viewControllerHolder.value
    }

    
    
    var body: some View {
        ZStack {
            BackGround()
            
            CardOutlets(viewController: viewController)
            SecondaryNavigation(header: "")
            
        }
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddCardView().previewDevice("iPhone 8")
            AddCardView().previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct CardOutlets: View {
    
    @State var name: String = ""
    @State var invalidName: Bool = false
    @State var cardNumber: String = ""
    @State var invalidCard: Bool = false
    @State var expiryDate: String = ""
    @State var invalidExp: Bool = false
    @State var invalidCVC: Bool = false
    @State var cvc: String = ""
    
    @State var isSelected: Bool = true
    @State var deselected: Bool = false
    
    @State var selectedProvider: CardProvider = .mcard
    
    var viewController: UIViewController?
    
    
    func addCard () {
        
        guard let email = Auth.auth().currentUser?.email else {return}
        CURRENT_USER_EMAIL = email
        
        print("User's name is \(name)")
        
        let balance = CardsModel.generateFakeBalance()
        //self.uploadProfilePic()
        
        Firestore.firestore().collection(CUSTOMERS_REF).document(email).collection(CARDS_REF).addDocument(data: [
            Cards_Ref.cardName : name,
            Cards_Ref.cardNumber: Int(cardNumber)!,
            Cards_Ref.expiryDate : expiryDate,
            Cards_Ref.cvc : Int(cvc)!,
            Cards_Ref.cardProvider : self.selectedProvider.rawValue,
            Cards_Ref.balance : balance,
            CREATED_REF : FieldValue.serverTimestamp()
            ], completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)

                } else {
                    print("Cards was added")
                    self.viewController?.dismiss(animated: true, completion: nil)
                }
        })

    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Spacer()
            Text("Add a card").modifier(H3(color: .white)).padding(.top)
            TextFldNIcons(placeHolder: "Enter card name", textValue: $name, invalidField: invalidName, label: "Name")
            TextFldNIcons(placeHolder: "0000 0000 0000 0000", textValue: $cardNumber, invalidField: invalidCard, label: "Card Number").keyboardType(.numberPad)
            HStack (spacing: 20) {
                TextFldNIcons(placeHolder: "mm/yy", textValue: $expiryDate, invalidField: invalidExp, label: "Expiry date")
                TextFldNIcons(placeHolder: "123", textValue: $cvc, invalidField: invalidCVC, label: "CVC").keyboardType(.numberPad)
            }
            
            HStack (spacing: 100) {

                Button(action: {
                    self.selectedProvider = .mcard
                    
                }) {
                    CardProviderSelector(isSelected: selectedProvider == .mcard ? $isSelected : $deselected, icon: "masterCard")
                    
                }
                
                Button(action: {
                    self.selectedProvider = .visa
                }) {
                    CardProviderSelector(isSelected: selectedProvider == .visa ? $isSelected : $deselected, icon: "visa")
                }

            }.padding([.vertical, .leading])
            
            Spacer()
            
            Button(action: {
                let balance = CardsModel.generateFakeBalance()
                let card = CustomerCard(cardProvider: self.selectedProvider.rawValue, cardName: self.name, expiryDate: self.expiryDate, cvc: self.cvc, cardNumber: self.cardNumber, balance: Int(balance))
                //self.addCard()
                
                CardsModel.addCard(card: card, vc: self.viewController!)
                print(card)
                
            }) {
                PrimaryButton(label: "Continue")
            }
            
            Spacer()
            
        }.padding(.horizontal, K.CustomUIConstraints.hPadding)
           // .padding(.top, 20)
        .modifier(AdaptsToKeyboard())
        .modifier(DismissingKeyboard())
    }
}

struct CardProviderSelector : View {
    @Binding var isSelected: Bool
    var icon: String = ""
    var body: some View {
        HStack {
            RadioIcon(isSelected: $isSelected)
            Image(icon).renderingMode(.original)
        }
    }
}

enum CardProvider: String {
    case mcard = "masterCard"
    case visa = "visa"
}
