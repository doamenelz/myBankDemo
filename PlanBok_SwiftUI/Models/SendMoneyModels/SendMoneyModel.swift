//
//  SendMoneyModel.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-07-07.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
//import UIKit
import Combine
import SDWebImageSwiftUI


class CustomerContacts: ObservableObject {
    
    @Published var customerContacts: [Contact] = [sampleContact]
    
    
    init () {
        let benRef = Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(BENEFICIARIES)
        benRef.addSnapshotListener { snap, error in
            self.customerContacts.removeAll()
            if let err = error {
                debugPrint(err.localizedDescription)
            } else {
                self.parseBen(snapshot: snap)
            }
            
        }
        
        
        
    }
    
    func parseBen (snapshot: QuerySnapshot?) {
        guard let beneficiaries = snapshot else {return}
        
        var benList: [Beneficiary] = []
        
        for ben in beneficiaries.documents {
            let data = ben.data()
            let benEmail = data["beneficiaryEmail"] as? String ?? ""
            let ben = Beneficiary(benEmail: benEmail)
            benList.append(ben)
        }
        
        //Get all images
        
        //Get beneficiary information
        
        getBenDetails(benList: benList)
        
        
        
    }
    
    func getBenDetails (benList: [Beneficiary]) {
        
        
        for beneficiary in benList {
            //let image = URL(string: DEFAULT_IMAGE)
            let imageUrl = IMAGE_PATH + beneficiary.benEmail
            
            let userRef = Firestore.firestore().collection(CUSTOMERS_REF).document(beneficiary.benEmail)
            
            print(userRef.documentID)
            
            var benName: String = ""
            
            
            userRef.getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataDescription = document.data()
                    benName = dataDescription![NAME] as? String ?? ""

                } else {
                    print(error.debugDescription)
                    print("Document does not exist")
                }
            }
            
            let stRef = Storage.storage().reference(forURL: imageUrl)
            
            stRef.downloadURL { url, error in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    let image = url ?? URL(string: DEFAULT_IMAGE)
                    let contact = Contact(avatar: image!, name: benName, number: 0, email: "ee")
                    self.customerContacts.append(contact)
                    //print(self.customerContacts)
                    
                }

            }
            
            
        }
        

    }
    

}

func getFirebaseImage(imageUrl: String) -> URL {
    let stRef = Storage.storage().reference(forURL: imageUrl)
    
    var image = URL(string: DEFAULT_IMAGE)!
    
    stRef.downloadURL { url, error in
        if let err = error {
            print(err.localizedDescription)
        } else {
            image = url ?? URL(string: DEFAULT_IMAGE)!
            //print(url)
            
        }

    }
    
    return image
    
}

struct Beneficiary: Identifiable {
    let id: UUID = UUID()
    let benEmail: String
}

let sampleBen = Beneficiary(benEmail: "aces.ventura@email.com")


///Observable object that contains all Payees (Merchants)
class Payees : ObservableObject {
    
    ///Contains a list of all merchants
    @Published var allMerchants: [Merchants] = [sampleMerchants]
    
    @Published var users: [Users] = []
    
    @Published var filtered : [Merchants] = []
    
    init() {
        getMerchants()
        //getUsers(searchedText: "Eddy Gordo")
    }
    
    ///Gets users from Firebase based on the provided search text
    
    static func getUsers (searchedText: String) -> [Users]  {
        //func getUsers (searchedText: String)  {
        
        var users: [Users] = []
        let usersRef = Firestore.firestore().collection(CUSTOMERS_REF).whereField(NAME, isEqualTo:  searchedText)
        
        usersRef.getDocuments { (doc, error) in
            users.removeAll()
            if let err = error {
                print(err.localizedDescription)
            } else {
                let d = doc!.documents
                for document in d {
                    let data = document.data()
                    let name = data[Users_Ref.name] as? String ?? ""
                    let userID = document.documentID
                    //let av = data[Users_Ref.avatar] as? String ?? ""
                    let stRef = Storage.storage().reference(forURL: IMAGE_PATH + userID)
                    stRef.downloadURL { url, error in
                        if let err = error {
                            print(err.localizedDescription)
                        } else {
                            let avatar = url ?? URL(string: DEFAULT_IMAGE)!
                            let user = Users(name: name, userID: userID, avatar: avatar)
                            print(user)
                            users.append(user)
                        }
                    }
                    
                    
                    
                }
                
            }
        }
        

        return users
 
 }
    
 
    ///Gets all Merchants from the Firestore Repo
    
    func getMerchants () {
        
        let merchantReference = Firestore.firestore().collection(MERCHANT_REF)
        
        merchantReference.getDocuments { (doc, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                let merchants = doc!.documents
               
                for merchant in merchants {
                    let data = merchant.data()
                    let name = data[Merchant_Ref.name] as? String ?? ""
                    let merchantID = data[Merchant_Ref.id] as? String ?? ""
                    let category = data[Merchant_Ref.category] as? String ?? ""
                    let av = data[Merchant_Ref.avatar] as? String ?? ""
                    //let avatar = getFirebaseImage(imageUrl: MERCHANT_AVATAR_PATH + av)
                    
                    let stRef = Storage.storage().reference(forURL: MERCHANT_AVATAR_PATH + av)
                    stRef.downloadURL { url, error in
                        if let err = error {
                            print(err.localizedDescription)
                            let avatar = url ?? URL(string: DEFAULT_IMAGE)!
                            let merchant = Merchants(name: name, merchantID: merchantID, avatar: avatar, category: category)
                            self.allMerchants.append(merchant)
                        } else {
                            let avatar = url ?? URL(string: DEFAULT_IMAGE)!
                            let merchant = Merchants(name: name, merchantID: merchantID, avatar: avatar, category: category)
                            self.allMerchants.append(merchant)
                        }
                    }
                }
            }
        }

    }
    
    func searchMerchants (searchedText: String) {
        filtered.removeAll()
        for result in allMerchants {
            if result.name == searchedText {
                filtered.append(result)
                print(result)
            }
        }
    }

    
}

class UsersM : ObservableObject {
    
    @Published var users : [Users] = []
    
    @Published var filtered : [Users] = []
    
    init() {
        getUsers()
    }
    
    func getUsers () {
           let usersRef = Firestore.firestore().collection(CUSTOMERS_REF)//.whereField(NAME, isEqualTo: searchedText)
           
           usersRef.getDocuments { (doc, error) in
            //self.users.removeAll()
               if let err = error {
                   print(err.localizedDescription)
               } else {
                   let d = doc!.documents
                   for document in d {
                       let data = document.data()
                       let name = data[Users_Ref.name] as? String ?? ""
                       let userID = document.documentID
                       let stRef = Storage.storage().reference(forURL: IMAGE_PATH + userID)
                       stRef.downloadURL { url, error in
                           if let err = error {
                               print(err.localizedDescription)
                           } else {
                               let avatar = url ?? URL(string: DEFAULT_IMAGE)!
                               let user = Users(name: name, userID: userID, avatar: avatar)
                               //print(user)
                            self.users.append(user)
                           }
                       }
                       
                       
                       
                   }
                   
               }
           }

    }
    
    func searchUsers (searchedText: String)  {
        filtered.removeAll()
        for result in users {
            
            let rez = result.name.contains(searchedText)
            if rez {
               filtered.append(result)
            }
        }
        
    }
}

struct Merchants : Identifiable {
    let id = UUID()
    let name: String
    let merchantID: String
    let avatar: URL
     let category: String
}

struct Merchantsl : Identifiable {
    let id = UUID()
    let name: String
    let merchantID: String
    let avatar: String
     let category: String
}


struct Users : Identifiable {
    let id = UUID()
    let name: String
    let userID: String
    let avatar: URL
}


struct Users_Ref {
    static let name = "name"
    static let userID = "id"
    static let avatar = "avatar"
    static let email = "email"
}

struct Merchant_Ref {
    static let id = "merchantId"
    static let avatar = "avatar"
    static let name = "name"
    static let category = "category"
}

func getUsers (searchedText: String) -> [Users]  {
       //func getUsers (searchedText: String)  {
       
       var users: [Users] = []
       let usersRef = Firestore.firestore().collection(CUSTOMERS_REF).whereField(NAME, isEqualTo:  searchedText)
       
       usersRef.getDocuments { (doc, error) in
           users.removeAll()
           if let err = error {
               print(err.localizedDescription)
           } else {
               let d = doc!.documents
               for document in d {
                   let data = document.data()
                   let name = data[Users_Ref.name] as? String ?? ""
                   let userID = document.documentID
                   //let av = data[Users_Ref.avatar] as? String ?? ""
                   let stRef = Storage.storage().reference(forURL: IMAGE_PATH + userID)
                   stRef.downloadURL { url, error in
                       if let err = error {
                           print(err.localizedDescription)
                       } else {
                           let avatar = url ?? URL(string: DEFAULT_IMAGE)!
                           let user = Users(name: name, userID: userID, avatar: avatar)
                           print(user)
                           users.append(user)
                       }
                   }
                   
                   
                   
               }
               
           }
       }
       

       return users

}

func searchUsers (value: [Users], searchedText: String) -> [Users] {
    
    var results : [Users] = []
    
    for result in value {
        if result.name == searchedText {
            results.append(result)
            print(result)
        }
    }
    
    return results
}

func searchMerchants (value: [Merchants], searchedText: String) -> [Merchants] {
    
    var results : [Merchants] = []
    
    for result in value {
        if result.name == searchedText {
            results.append(result)
            print(result)
        }
    }
    
    return results
}

//func searchMerchants
   



//MARK: - NLN
func postBulkMerchants () {
    
    let merchants = allMerchants
    
    for merchant in merchants {
        Firestore.firestore().collection(MERCHANT_REF)
            .addDocument(data: [//.document(CURRENT_USER_EMAIL).collection(TRANSACTIONS_REF).addDocument(data: [
                Merchant_Ref.id: merchant.merchantID,
                Merchant_Ref.name : merchant.name,
                Merchant_Ref.category : merchant.category,
                Merchant_Ref.avatar : merchant.avatar,
            ], completion: { (error) in
               if let err = error {
                   debugPrint(err.localizedDescription)
               } else {
                   print("New Merchant was added")
               }
               
           })
    }
    
}

func postBulkT () {
    
    let transactions = bulkT
    
    for t in transactions {
        Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(TRANSACTIONS_REF).addDocument(data: [
            Transaction_Ref.amount : t.amount,
                   "recipient" : t.recipient,
                   "type" : t.type,
                   "sender" : t.sender,
                   "narration" : t.narration,
                   "image" : t.image,
                   Transaction_Ref.date : FieldValue.serverTimestamp()
               ], completion: { (error) in
                   if let err = error {
                       debugPrint(err.localizedDescription)
                   } else {
                       print("New Transaction was posted")
                   }
                   
               })
    }
    
}

let allMerchants = [
    Merchantsl(name: "Burger King", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "Burger King.pdf", category: TransactionCategory.food.rawValue),
    Merchantsl(name: "Calvin Klein", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "CK.pdf", category: TransactionCategory.fashion.rawValue),
    Merchantsl(name: "Dominos Pizza", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "Dominos Pizza.pdf", category: TransactionCategory.food.rawValue),
    Merchantsl(name: "KFC", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "KFC.pdf", category: TransactionCategory.food.rawValue),
    Merchantsl(name: "McDonalds", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "McDonalds.pdf", category: TransactionCategory.food.rawValue),
    Merchantsl(name: "Nike", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "Nike.pdf", category: TransactionCategory.fashion.rawValue),
    Merchantsl(name: "Pizza Hut", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "Pizza Hut.pdf", category: TransactionCategory.food.rawValue),
    Merchantsl(name: "Ralph Lauren", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "RL.pdf", category: TransactionCategory.food.rawValue),
    Merchantsl(name: "Starbucks", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "Starbucks.pdf", category: TransactionCategory.food.rawValue),
    Merchantsl(name: "Tommy Hilfiger", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "TH.pdf", category: TransactionCategory.fashion.rawValue),
    Merchantsl(name: "Uber", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "Uber.pdf", category: TransactionCategory.transport.rawValue),
    Merchantsl(name: "Zara", merchantID: "#\(RegistrationVM.generateCustomerID())", avatar: "Zara.pdf", category: TransactionCategory.fashion.rawValue)
]

let sampleUser = Users(name: "Edem Ekeng", userID: "edem.ekeng@live.com", avatar: SAMPLE_IMAGE_URL!)

let sampleMerchants = Merchants(name: "Dominos", merchantID: "434532", avatar: SAMPLE_IMAGE_URL!, category: "Shopping")





