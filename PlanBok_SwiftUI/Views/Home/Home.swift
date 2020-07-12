//
//  Home.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-12.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Firebase
import Contentful

struct Home: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
     self.viewControllerHolder.value
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    let cards = CardM.all()
    let transactions = sampleTransactionStack
    
    var body: some View {
            ZStack {
                BackGround()
                Text("gjgjgjgjg")
                //MARK: - Header
                ScrollView (showsIndicators: false) {
                    VStack (spacing: 15) {
                        HStack {
                            Text("My Cards").modifier(H3(color: .white))
                            Spacer()
                            Button(action: {
                                self.viewRouter.currentPage = .menu
                            }) {
                                Image("Add").foregroundColor(Color("p1"))
                            }
                        }
                        
                        .padding(.horizontal, K.CustomUIConstraints.hPadding)
                            .padding(.bottom, 10)

                        //MARK:  - Card Carousel
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (spacing: 20) {
                                ForEach(cards) { card in
                                    
                                    Button(action: {
                                        print("Menu Pressed")
                                        //self.viewRouter.currentPage = .menu
                                        
                                        self.viewController?.present(presentationStyle: .overCurrentContext) {
                                            Menu()
                                        }
                                    }) {
                                        Text("")
//                                        Card(isCheckBoxStyled: false, card: card)
//                                        .frame(width: screenWidth - 60)
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
                                ThisMonthSummaryCard(type: SummaryType.expense.rawValue, amount: -120000)
                                Spacer()
                                ThisMonthSummaryCard(type: SummaryType.income.rawValue, amount: 12000).allowsTightening(true)
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
                MainNavigation(header: .wallet)
                 
            }

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home().previewDevice("iPhone 8").environmentObject(ViewRouter())
            //Home().previewDevice("iPhone 11")
            //Home().previewDevice("iPhone 11 Pro Max")
            //Home().previewDevice("iPad Pro (12.9-inch) (4th generation)")
        }
        
        
    }
}

///Main Navigation View
struct MainNavigation: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
     self.viewControllerHolder.value
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var header: MenuScreens = .wallet
    let rightIcon: CustomSymbols = .menu
    let leftIcon: CustomSymbols = .notifications
    var body: some View {
        VStack {
            HStack {
                Image(leftIcon.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: K.CustomUIConstraints.menuIconFrame)
                Spacer()
                Text(header.rawValue).modifier(H4(color: .white))
                Spacer()
                Button(action: {
                    self.viewController?.present(presentationStyle: .overCurrentContext) {
                        Menu()
                    }
                    
                    //self.viewRouter.currentPage = .menu
                }) {
                    Image(rightIcon.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: K.CustomUIConstraints.menuIconFrame)
                        .foregroundColor(.white)
                }

                
            }.padding(.horizontal, 30)
                .padding(.top)
            
            Spacer()
        }
    }
}

struct SecondaryNavigation: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
     self.viewControllerHolder.value
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var header: String = "Wallet"
    let rightIcon: CustomSymbols = .menu
    let leftIcon: SFIcons = .chevronLeft
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.viewController?.dismiss(animated: true, completion: nil)
                }) {
                Image(systemName: leftIcon.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                    .foregroundColor(.white)
                }
                
                Spacer()
                Text(header).modifier(H4(color: .white))
                Spacer()
                Button(action: {
                    self.viewController?.present(presentationStyle: .fullScreen) {
                        Menu()
                    }
                    
                }) {
                    Image(rightIcon.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: K.CustomUIConstraints.menuIconFrame)
                        .foregroundColor(.white)
                }

                
            }.padding(.horizontal, 30)
            .padding(.vertical)
            
            Spacer()
        }
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


struct SectionBtn: View {
    var text: String = "Overview"
    var icon: String = "Overview"
    var iconType: IconType
    var body: some View{
        HStack {
            Text(text).modifier(H6(color: .p1))
            
            if iconType == .systemFont {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15)
                    .foregroundColor(Color(Colors.p1.rawValue))
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
            color = Colors.credit.rawValue
        } else {
            color = Colors.debit.rawValue
        }
        
        return color
    }
    
    
    var body: some View {
        VStack {
            HStack (spacing: 20) {
                ZStack {
                    Color(Colors.white.rawValue).opacity(0.05)
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
