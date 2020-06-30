//
//  WalletHome.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-28.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Firebase

struct WalletHome: View {
        @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
        private var viewController: UIViewController? {
         self.viewControllerHolder.value
        }
        
        @EnvironmentObject var viewRouter: ViewRouter
        
        
        let cards = CardM.all()
        let transactions = sampleTransactionStack
    @ObservedObject var customerCards = CustomersCards()
        
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
                                HStack (spacing: 20) {
                                    ForEach(customerCards.customerCards) { card in
                                        
                                        Button(action: {
                                            print("Menu Pressed")
                                            //self.viewRouter.currentPage = .menu
                                            
//                                            self.viewController?.present(presentationStyle: .overCurrentContext) {
//                                                Menu()
//                                            }
                                        }) {
                                            Text("")
                                            Card(isCheckBoxStyled: false, card: card)
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
                     
                }.onAppear {
                    //CustomersCards()
            }

        }}

struct WalletHome_Previews: PreviewProvider {
    static var previews: some View {
        WalletHome()
    }
}

