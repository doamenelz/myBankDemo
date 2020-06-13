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
    let transactions = Transaction.all()
    
    var body: some View {
            ZStack {
                BackGround()

                
                //MARK: - Header
                ScrollView (showsIndicators: false) {
                    VStack (spacing: 15) {
                        HStack {
                            Text("My Cards").modifier(H3(color: .white))
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image("Add").foregroundColor(Color("p1"))//.renderingMode(.original)
                            }
                        }
                        
                        .padding(.horizontal, K.CustomUIConstraints.hPadding)
                            .padding(.bottom, 10)

                        //MARK:  - Card Carousel
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (spacing: 20) {
                                ForEach(cards) { card in
                                    
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                        Card(card: card)
                                        .frame(width: screenWidth - 60)
                                    }
//
                                }
                            }.padding([.horizontal, .bottom], 30)
                            
                            //offset(y: 40)
                        }
                        
                        //MARK: - Overview Section
                        VStack {
                            HStack {
                                Text("This Month").modifier(H3(color: .white))
                                Spacer()
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                    SectionBtn(iconType: .asset)
                                }
                                
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                                .padding(.top, 15)
                            
                            //Summary
                            HStack  {
                                ThisMonthSummaryCard(type: SummaryType.expense.rawValue, amount: -120000000)
                                Spacer()
                                ThisMonthSummaryCard(type: SummaryType.income.rawValue, amount: 12000000).allowsTightening(true)
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        }.offset(y: -30)
                        
                        
                        //MARK: - Transaction Section
                        VStack (spacing: 20) {
                            HStack {
                                Text("Transactions").modifier(H3(color: .white))
                                Spacer()
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                    SectionBtn(text: "History", icon: "list.bullet", iconType: .systemFont)
                                }
                                
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                            
                            ForEach(self.transactions) { transaction in
                                TransactioCell(transaction: transaction)
                                
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                            
                        }
                    }
                }.offset(y: 70)
                
                //MARK: - Main Navigation
                VStack {
                    MainNavigation(header: "Wallet", icon: "Menu")
                    Spacer()
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
            //Home().previewDevice("iPad Pro (12.9-inch) (4th generation)")
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
                    Image(card.type).renderingMode(.original)
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
    let type: String
}

extension CardM {
    static func all() -> [CardM] {
        
        return [
            CardM(balance: 34567, last4Digits: "1234", name: "Sensei Lannister", expiry: "03/23", type: "visa"),
            CardM(balance: 234, last4Digits: "9056", name: "Sensei Lannister", expiry: "08/26", type: "masterCard"),
            CardM(balance: 90000, last4Digits: "5643", name: "Sensei Lannister", expiry: "11/23", type: "visa"),
            CardM(balance: 35664, last4Digits: "4564", name: "Sensei Lannister", expiry: "09/23", type: "masterCard"),
        ]
    }
}

struct ThisMonthSummaryCard: View {
    
    var type: SummaryType.RawValue
    var amount: Int
    
    var body: some View {
        HStack (alignment: .bottom, spacing: 10) {
            Image(type).renderingMode(.original)
                //.resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(width: K.CustomUIConstraints.menuIconFrame)
                
            VStack (alignment: .leading, spacing: 2) {
                Text(type).modifier(TextFieldLbl())
                Text("$ \(amount)").modifier(H3(color: .white)).lineLimit(1).minimumScaleFactor(0.6)
            }
        }
    }
}

struct SectionBtn: View {
    var text: String = "Overview"
    var icon: String = "Overview"
    var iconType: IconType
    var body: some View{
        HStack {
            Text(text).modifier(H6(color: .purple))
            
            if iconType == .systemFont {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15)
                    .foregroundColor(Color(FontColors.purple.rawValue))
            } else {
                Image(icon)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12)
            }
            
        }
        
    }
}

enum SummaryType: String {
    case expense = "Expense"
    case income = "Income"

}

enum IconType {
    case systemFont
    case asset
}

struct TransactioCell: View {
    
    let transaction: Transaction
    var color: String = "credit"
    mutating func checktransactionType (transaction: Transaction) -> String  {
        //var color: String
        if transaction.type == .credit {
            color = FontColors.credit.rawValue
        } else {
            color = FontColors.debit.rawValue
        }
        
        return color
    }
    
    
    var body: some View {
        VStack {
            HStack (spacing: 20) {
                ZStack {
                    Color(FontColors.white.rawValue).opacity(0.05)
                        .frame(width: 48, height: 48)
                        .cornerRadius(8)
                    Image(transaction.image)
                        .aspectRatio(contentMode: .fit)
                }
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(transaction.receipient).modifier(H6(color: .white))
                    Text(transaction.transactionDate).modifier(TextFieldLbl())
                }
                Spacer()
                
                Text("$ \(transaction.amount)").modifier(H4(color: .credit) ).lineLimit(1).minimumScaleFactor(0.6).allowsTightening(true)
                
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

enum TransactionType {
    case debit
    case credit
}

struct Transaction: Identifiable {
    let id = UUID()
    let image: String
    let receipient: String
    let transactionDate: String
    let amount: Int
    let type: TransactionType
}

extension Transaction {
    static func all() -> [Transaction] {
        return [
            Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 12345, type: .credit),
            Transaction(image: "BurgerKing", receipient: "Burger King purchase", transactionDate: "16 Apr, 9:94am", amount: -400, type: .debit),
            Transaction(image: "Zara", receipient: "Zara Purchase", transactionDate: "16 Apr, 9:94am", amount: 254, type: .credit),
            Transaction(image: "Nike", receipient: "Nike Store", transactionDate: "16 Apr, 9:94am", amount: 10, type: .credit),
            Transaction(image: "McDonald", receipient: "McDonald Fries", transactionDate: "16 Apr, 9:94am", amount: 134, type: .credit),
            Transaction(image: "KFC", receipient: "KFC Chicken Stash", transactionDate: "16 Apr, 9:94am", amount: -56, type: .debit),
            Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 5456, type: .credit),
            Transaction(image: "Zara", receipient: "Zara Jacket", transactionDate: "16 Apr, 9:94am", amount: -2345, type: .debit),
            Transaction(image: "Uber", receipient: "Uber Trip", transactionDate: "16 Apr, 9:94am", amount: 10000, type: .credit),
        ]
    }
    
}


