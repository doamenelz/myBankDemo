//
//  CardsModel.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-29.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import Firebase

class CardsModel {
    
    static func generateFakeBalance () -> Double {
        let balance: Double = Double(arc4random_uniform(UInt32(8000.00)))
        return balance
    }
    
    static func getLast4Digits (digits: Int) -> String {
        let str = String(digits)
        let r = str.index(str.endIndex, offsetBy: -4)..<str.endIndex
        print(str[r])
        return String(str[r])
    }
    
    static func addCard (card: CustomerCard, vc: UIViewController) {
        
        
        Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(CARDS_REF).addDocument(data: [
            Cards_Ref.cardName : card.cardName,
            Cards_Ref.cardNumber: Int(card.cardNumber)!,
            Cards_Ref.expiryDate : card.expiryDate,
            Cards_Ref.cvc : Int(card.cvc)!,
            Cards_Ref.cardProvider : card.cardProvider,
            Cards_Ref.balance : card.balance,
            CREATED_REF : FieldValue.serverTimestamp()
            ], completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)

                } else {
                    print("Cards was added")
                    vc.dismiss(animated: true, completion: nil)
                }
        })
        
    }
}

class CustomersCards : ObservableObject {
    
    @Published var customerCards: [CustomerCard] = []
    
    func parseCards (snapshot: QuerySnapshot?) {
        guard let cards = snapshot else {return}
        
        for card in cards.documents {
            let data = card.data()
            let cardProvider = data[Cards_Ref.cardProvider] as? String ?? ""
            let cardName = data[Cards_Ref.cardName] as? String ?? ""
            let expiryDate = data[Cards_Ref.expiryDate] as? String ?? ""
            let cvc = data[Cards_Ref.cvc] as? String ?? ""
            let fullCardN = data[Cards_Ref.cardNumber] as? Int ?? 0
            let cardNumber = CardsModel.getLast4Digits(digits: fullCardN)
            let balance = data[Cards_Ref.balance] as? Int ?? 0
            
            let newCard = CustomerCard(cardProvider: cardProvider, cardName: cardName, expiryDate: expiryDate, cvc: cvc, cardNumber: cardNumber, balance: balance)
            customerCards.append(newCard)
        }
    }
    
    init() {
        let cardsRef = Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(CARDS_REF)

        /*
        cardsRef.getDocuments { (querySnap, error) in

            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.parseCards(snapshot: querySnap)
            }
        }
        */
        cardsRef.addSnapshotListener { snap, error in
            self.customerCards.removeAll()
            if let err = error {
                debugPrint(err.localizedDescription)
            } else {
                self.parseCards(snapshot: snap)
            }
            
        }
    }
    
    
}

struct CustomerCard : Identifiable {
    let id = UUID()
    let cardProvider: String
    let cardName: String
    let expiryDate: String
    let cvc: String
    let cardNumber: String
    let balance: Int
}



