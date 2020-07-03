//
//  WalletHome.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-28.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct WalletHome: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    let cards = CardM.all()
    @ObservedObject var customerCards = CustomersCards()
    @ObservedObject var customerTransactions = TransactionModel()
    
    @State var selectedCard: CustomerCard = sampleCard
    
        
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
                                    //self.viewRouter.currentPage = .
                                    self.viewController?.present(presentationStyle: .fullScreen) {
                                        AddCardView()
                                    }
                                }) {
                                    Image("Add").foregroundColor(Color("p1"))
                                }
                            }
                            
                            .padding(.horizontal, K.CustomUIConstraints.hPadding)
                                .padding(.bottom, 10)

                            //MARK:  - Card Carousel
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack (spacing: 10) {
                                    ForEach(customerCards.customerCards) { card in
                                        
                                        Button(action: {
                                            self.selectedCard = card
                                            self.viewController?.present(presentationStyle: .overCurrentContext) {
                                                //History(customerCard: self.selectedCard)
                                                History(customerCard: self.selectedCard, category: Array(self.customerTransactions.transactionCategories), customerTransactions: self.customerTransactions.customerTransactions, selectedCat: 0)
                                            }
                                            
                                        }) {
                                            Text("")
                                            CardViewLarge(isCheckBoxStyled: false, card: card)
                                            .frame(width: screenWidth - 60)
                                        }
    //
                                    }
                                }.padding([.horizontal, .bottom], 20)
                                
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
                                    ThisMonthSummaryCard(type: SummaryType.expense.rawValue, amount: Double(self.customerTransactions.totalExpense))
                                    Spacer()
                                    ThisMonthSummaryCard(type: SummaryType.income.rawValue, amount: Double(self.customerTransactions.totalIncome)).allowsTightening(true)
                                }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                            }.offset(y: -30)
                            
                            
                            //MARK: - Transaction Section
                            VStack (spacing: 20) {
                                HStack {
                                    Text("Transactions").modifier(H3(color: .white))
                                    Spacer()

                                    Button(action: {
                                        
                                    }) {
                                        SectionBtn(text: "History", icon: "list.bullet", iconType: .systemFont)
                                    }

                                }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                                
                                ForEach(self.customerTransactions.customerTransactions) { transaction in
                                    TransactionCell(transaction: transaction)
                                }.padding(.horizontal, K.CustomUIConstraints.hPadding)

                            }
                        }
                    }.offset(y: 70).onAppear{
                        //TransactionModel.postBulkT()
                    }
                    
                    //MARK: - Main Navigation
                    MainNavigation(header: .wallet)
                     
                }
        }}

struct WalletHome_Previews: PreviewProvider {
    static var previews: some View {
        WalletHome()
    }
}

let sampleCard = CustomerCard(cardProvider: "visa", cardName: "Sample User", expiryDate: "12/12", cvc: "123", cardNumber: "1234", balance: 12345678)

