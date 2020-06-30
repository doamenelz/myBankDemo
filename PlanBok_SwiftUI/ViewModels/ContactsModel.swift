//
//  ContactsModel.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-20.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "nl1wg3be77le", accessToken: "W3cM01iWVVG2qPV3d4AUUOarMhfu8NUw_-T7UR3_Mvs")

func getContacts (id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
                //print(array.items)
            }
            
        case .failure(let error):
            print(error)
        }
        
    }
    
}

class ContactsStore: ObservableObject {
    
    @Published var contacts: [Contact] = []
    
    init() {
        getContacts(id: "contact") { (contact) in
            contact.forEach { (i) in
                self.contacts.append(Contact(
                    avatar: i.fields.linkedAsset(at: "avatar")?.url ?? URL(string: "https://nationalpostcom.files.wordpress.com/2019/09/portraitofaladyonfire_02.jpg?quality=80&strip=all&w=780")!,
                    name: i.fields["name"] as! String,
                    number: i.fields["phoneNumber"] as! Int,
                    email: i.fields["email"] as! String))            }
            
            print(contact.count)
            
        }
    }
}

class TransactionsStore: ObservableObject {
    
    @Published var transactions: [Transaction] = sampleTransactionStack
    
    init() {
        getContacts(id: "transactions") { (transaction) in
            transaction.forEach { (t) in
                self.transactions.append(Transaction(
                    image: "Avatar1",
                    receipient: "RYRYRY",
                    transactionDate: "",
                    amount: 5678,
                    type: .credit,
                    category: .bills))
                //print(t.fields["recipient"]["name"] as? String)
                print(t.fields.linkedAsset(at: "recipient")?.url ?? URL(string: "https://nationalpostcom.files.wordpress.com/2019/09/portraitofaladyonfire_02.jpg?quality=80&strip=all&w=780")!)
                
            }
            
        }
    }
    
}

struct Transaction: Identifiable {
    let id = UUID()
    let image: String
    let receipient: String
    let transactionDate: String
    let amount: Int
    let type: TransactionType
    let category: TransactionCategory
}

class ContactsViewModel: ObservableObject {
    
    @Published var selectedContact: Contact = sampleContact
        
    init(selectedContact: Contact) {
        self.selectedContact = selectedContact
    }
       
}

struct Contact: Identifiable {
    let id = UUID()
    let avatar: URL
    let name: String
    let number: Int
    let email: String
}



extension Contact {
    
    static func all() -> [Contact] {
        return [
//        Contact(avatar: "Avatar1", name: "Agatha Carlsson", number: "#2344321"),
//        Contact(avatar: "Avatar2", name: "Esteban Craviewer", number: "#09003920"),
//        Contact(avatar: "Avatar3", name: "Sensei Lannister", number: "#9838493"),
//        Contact(avatar: "Avatar4", name: "Jennier Morrison", number: "#45432345"),
//        Contact(avatar: "Avatar5", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar1", name: "Richardson Brainiac", number: "#4095065"),
//        Contact(avatar: "Avatar2", name: "Richardson Brainiac", number: "#4095065"),
//        Contact(avatar: "Avatar4", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar5", name: "Richardson Brainiac", number: "#4095065"),
//        Contact(avatar: "Avatar4", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar3", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar1", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar4", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar2", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar3", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar5", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar2", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar1", name: "Brainiac Richardson", number: "#4095065"),
//        Contact(avatar: "Avatar2", name: "Brainiac Richardson", number: "#4095065")
        
        ]
    }
}
//
//var sampleContact: [Contact] = [Contact(avatar: "https://nationalpostcom.files.wordpress.com/2019/09/portraitofaladyonfire_02.jpg?quality=80&strip=all&w=780" as URL, name: "Avatar1", number: 345543, email: "ede.ded.ede")]

struct ContactsModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

let sampleContact = Contact(avatar: URL(string: "https://nationalpostcom.files.wordpress.com/2019/09/portraitofaladyonfire_02.jpg?quality=80&strip=all&w=780")!, name: "TestName", number: 898, email: "testemail")
