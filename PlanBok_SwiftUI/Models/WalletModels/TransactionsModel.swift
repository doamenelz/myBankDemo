//
//  TransactionsModel.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-29.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI
import UIKit
import SDWebImageSwiftUI

class TransactionModel : ObservableObject {
    
    @Published var customerTransactions: [CustomerTransaction] = [sampleCustomerTransaction]
    
    @Published var transactionCategories: Set<String> = []
    
    @Published var totalIncome: Double = 0.0
    
    @Published var totalExpense: Int = 0
    
    init() {
        
        let transactionsRef = Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(TRANSACTIONS_REF)
        transactionsRef.getDocuments { (querySnap, error) in
            
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.parsetransactions(snapshot: querySnap!)
                //self.getCategories()
                //self.getCategorioes()
                
            }
        }
        
        
        
    }
    
    func getTransactions () {
        
        let transactionsRef = Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(TRANSACTIONS_REF)
        transactionsRef.getDocuments { (querySnap, error) in
            
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                self.parsetransactions(snapshot: querySnap!)
            }
        }
        
    }
    
    func parsetransactions (snapshot: QuerySnapshot) {
        
        let transactions = snapshot
        for transaction in transactions.documents {
            let data = transaction.data()
            
            let category = data[Transaction_Ref.category] as? String ?? ""
            transactionCategories.insert(category)
            //print(transactionCategories)

            let amount = data[Transaction_Ref.amount] as? Double ?? 0.0
            let format = NumberFormatter()
             format.numberStyle = .currency
             format.allowsFloats = true
            
            let type = data[Transaction_Ref.type] as? String ?? ""
            
            let tD = data[Transaction_Ref.date] as? Timestamp
            
            let narration = data[Transaction_Ref.narration] as? String ?? "Transaction"
            
            let sender = data[Transaction_Ref.sender] as? String ?? "N/A"
            
            let d = tD?.dateValue()
            
            let date = DateFormatterHelper.formatFirebaseDate(serverDate: d!)
            
            let tImg = data[Transaction_Ref.image] as? String ?? ""
            
            let imageUrl = IMAGE_PATH + tImg
            
            let stRef = Storage.storage().reference(forURL: imageUrl)
            
            var image = URL(string: DEFAULT_IMAGE)
            
            stRef.downloadURL { url, error in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    image = url ?? URL(string: DEFAULT_IMAGE)
                    let transaction = CustomerTransaction(amount: NSNumber(value: amount), date: date, image: image!, type: type, narration: narration, sender: sender, category: category)
                    self.customerTransactions.append(transaction)
                    if transaction.type == "credit" {
                        self.totalIncome += Double(truncating: transaction.amount)
                        //self.totalIncome += amount
                    } else {
                        //self.totalExpense = Int(truncating: transaction.amount) + self.totalExpense
                        self.totalExpense = Int(truncating: NSNumber(value: amount))
                    }
                    
                }

            }
        }
    }
    
    static func postTransactions (transaction: CustomerTransaction) {
        Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(TRANSACTIONS_REF).addDocument(data: [
            Transaction_Ref.amount : transaction.amount,
            CREATED_REF : transaction.date
        ], completion: { (error) in
            if let err = error {
                debugPrint(err.localizedDescription)
            } else {
                print("New Transaction was posted")
            }
            
        })

        
    }
    
    static func checktransactionType (transaction: Transaction) -> String  {
        var color: String?
        if transaction.type == .credit {
            color = Colors.credit.rawValue
        } else {
            color = Colors.debit.rawValue
        }
        
        return color!
    }
    
    static func postBulkT () {
        
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
    
    func getTotal (transactions: [CustomerTransaction]) -> Double {
        var total: Double = 0.0
        for tran in transactions {
            total += Double(truncating: tran.amount)
        }
        
        return total
    }
    
    static func getCategories (customerTransactions: [CustomerTransaction]) -> [String] {
        var transactionCategories : [String] = []
        for cat in customerTransactions {
            let c = cat.category
            transactionCategories.append(c)
            print("Categories are \(c)")
        }
        return transactionCategories
    }

    
}

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

struct ThisMonthSummaryCard: View {
    
    var type: SummaryType.RawValue
    var amount: Double
    
    var body: some View {
        HStack (alignment: .bottom, spacing: 10) {
            Image(type).renderingMode(.original)
                .aspectRatio(contentMode: .fit)
            
            VStack (alignment: .leading, spacing: 2) {
                Text(type).modifier(TextFieldLbl())
//                Text("$ \(String(format: "%.2f", amount))").modifier(H4(color: .white)).lineLimit(1).minimumScaleFactor(0.6)
                Text("$ \(amount)").modifier(H4(color: .white)).lineLimit(1).minimumScaleFactor(0.6)
                
            }
        }
    }
}


let bulkT = [
    TransactionT(image: "Uber.pdf", recipient: "Self", date: "16 Apr, 9:94am", amount: 12345, type: "credit", sender: "e.ekeng", narration: "Uber Trip"),
    TransactionT(image: "BurgerKing.pdf", recipient: "edem.ekeng@live.com", date: "16 Apr, 9:94am", amount: -400, type: "credit", sender: "self", narration: "Burger King Vouchers"),
    TransactionT(image: "Zara.pdf", recipient: "Self", date: "16 Apr, 9:94am", amount: 12345, type: "credit", sender: "e.ekeng", narration: "Uber Trip"),
    TransactionT(image: "Nike.pdf", recipient: "edem.ekeng@live.com", date: "16 Apr, 9:94am", amount: -400, type: "credit", sender: "self", narration: "Nike Airforce Ones Purchase"),
]

enum TransactionType {
    case debit
    case credit
}

enum TransactionCategory: String {
    case shopping = "Shopping"
    case food = "Food"
    case bills = "Bills"
    case transport = "Transport"
}

extension Transaction {
    static func all() -> [Transaction] {
        return [
            Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 12345, type: .credit, category: .transport),
            Transaction(image: "BurgerKing", receipient: "Burger King purchase", transactionDate: "16 Apr, 9:94am", amount: -400, type: .debit, category: .food),
            Transaction(image: "Zara", receipient: "Zara Purchase", transactionDate: "16 Apr, 9:94am", amount: 254, type: .credit, category: .shopping),
            Transaction(image: "Nike", receipient: "Nike Store", transactionDate: "16 Apr, 9:94am", amount: 10, type: .credit, category: .shopping),
            Transaction(image: "McDonald", receipient: "McDonald Fries", transactionDate: "16 Apr, 9:94am", amount: 134, type: .credit, category: .food),
            Transaction(image: "KFC", receipient: "KFC Chicken Stash", transactionDate: "16 Apr, 9:94am", amount: -56, type: .debit, category: .food),
            Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 5456, type: .credit, category: .transport),
            Transaction(image: "Zara", receipient: "Zara Jacket", transactionDate: "16 Apr, 9:94am", amount: -2345, type: .debit, category: .shopping),
            Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 10000, type: .credit, category: .transport),
        ]
    }
    
}

let sampleTransactionStack = [
    Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 12345, type: .credit, category: .transport),
    Transaction(image: "BurgerKing", receipient: "Burger King purchase", transactionDate: "16 Apr, 9:94am", amount: -400, type: .debit, category: .food),
    Transaction(image: "Zara", receipient: "Zara Purchase", transactionDate: "16 Apr, 9:94am", amount: 254, type: .credit, category: .shopping),
    Transaction(image: "Nike", receipient: "Nike Store", transactionDate: "16 Apr, 9:94am", amount: 10, type: .credit, category: .shopping),
    Transaction(image: "McDonald", receipient: "McDonald Fries", transactionDate: "16 Apr, 9:94am", amount: 134, type: .credit, category: .food),
    Transaction(image: "KFC", receipient: "KFC Chicken Stash", transactionDate: "16 Apr, 9:94am", amount: -56, type: .debit, category: .food),
    Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 5456, type: .credit, category: .transport),
    Transaction(image: "Zara", receipient: "Zara Jacket", transactionDate: "16 Apr, 9:94am", amount: -2345, type: .debit, category: .shopping),
    Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 10000, type: .credit, category: .transport)
]

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

class CustomerTransactions : ObservableObject {
    @Published var transactions: [CustomerTransaction] = []
    
    let cardsRef = Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(TRANSACTIONS_REF)

    
//    cardsRef.getDocuments { (querySnap, error) in
//
//        if let err = error {
//            print("Error getting documents: \(err)")
//        } else {
//            self.parseCards(snapshot: querySnap)
//        }
//    }
    
    
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

struct TransactionT: Identifiable {
    let id = UUID()
    let image: String
    let recipient: String
    let date: String
    let amount: Int
    let type: String
    let sender: String
    let narration: String
}

struct CustomerTransaction: Identifiable {
    let id = UUID()
    let amount: NSNumber
    let date: String
    let image: URL
    let type: String
    let narration: String
    let sender: String
    let category: String
}

struct TransactionCell : View {
    let transaction: CustomerTransaction
    
    var body: some View {
        VStack {
            HStack (spacing: 20) {
                ZStack {
                    Color(Colors.white.rawValue).opacity(0.05)
                        .frame(width: 48, height: 48)
                        .cornerRadius(8)
                    WebImage(url: transaction.image)
                    .resizable()
                        .frame(width: 48, height: 48)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                }
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(transaction.narration).modifier(H6(color: .white))
                    Text(transaction.date).modifier(TextFieldLbl())
                }
                
                Spacer()
                
                if transaction.type == "credit" {
                    Text("$\(transaction.amount)")
                    .modifier(FormatTransaction(transaction: transaction))
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .allowsTightening(true)
                } else {
                    Text("- $\(transaction.amount)")
                    .modifier(FormatTransaction(transaction: transaction))
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .allowsTightening(true)
                    
                }
                
                
            }
            Path{ path in
                path.move(to: CGPoint(x: 10, y: 10))
                path.addLine(to: CGPoint(x: screenWidth - 60, y: 10))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5])).cornerRadius(10)
            .foregroundColor(Color("tb6"))
        }
        
    }

}


let sampleCustomerTransaction = CustomerTransaction(amount: 12345, date: "10pm June", image: SAMPLE_IMAGE_URL!, type: "visa", narration: "This is a test transaction", sender: "MeSelf", category: "shopping")

let sampleURL = SAMPLE_IMAGE_URL
