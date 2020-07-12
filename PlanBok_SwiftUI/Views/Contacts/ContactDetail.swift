//
//  ContactDetail.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-19.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContactDetail: View {
    
    @State var edit: Bool = false
    @State var phonenumber: String = ""
    @State var email: String = ""
    
    @ObservedObject var transactionStore = TransactionsStore()
    @State var contact: Contact
    
    let transactions = ContactTransactions.all()
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater1)
                .onAppear{
                    print(self.transactionStore)
            }
            
            //MARK: - Body Stack
            VStack {
                ScrollView {
                    VStack (spacing: 20) {
                        VStack {
                            ContactHeader(contact: contact)
                            ProfileFieldTemplate(field: .phoneNumber, image: ProfileFieldTemplate.getIcon(profileFieldType: .phoneNumber), cellValue: $phonenumber, editEnabled: $edit, canEdit: edit)
                            
                            ContactField(field: .phoneNumber, cellValue: $phonenumber, editEnabled: $edit)
                        }
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("Transactions").modifier(H3(color: .white))
                            //ScrollView {
                            VStack  {
                                ForEach(transactions) { transaction in
                                    TransCell(transaction: transaction)
                                }
                            }
                        }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        //Spacer()
                    }
                }
                
            }.padding(.top, K.CustomUIConstraints.topPadding)
                .padding(.bottom)
            
            
            //MARK: - Nav Stack
            SecondaryNavigation(header: "Contact Detail")

        }
        
            }
}

struct ContactDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetail( contact: Contact(avatar: URL(string: "https://nationalpostcom.files.wordpress.com/2019/09/portraitofaladyonfire_02.jpg?quality=80&strip=all&w=780")!, name: "TestName", number: 898, email: "testemail"))
    }
}

struct ContactHeader: View {
    
    var contact: Contact
    
    var body: some View {
        VStack (spacing: 10) {
            //Image("Avatar1")
            WebImage(url: contact.avatar)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 88, height: 88)
                .cornerRadius(8)
            
            Text(contact.name).modifier(H4(color: .white))
            //Text("#\(contact.number)").modifier(H6(color: .grey))
        }
    }
    
}

struct TransCell: View {
    let transaction: ContactTransactions
    var body: some View {
        VStack (spacing: 20) {
            HStack {
                Text(transaction.date).modifier(H7(color: .grey))
                Spacer()
                if transaction.type == .credit {
                    Text(transaction.amount).modifier(H6(color: .credit))
                } else {
                    Text(transaction.amount).modifier(H6(color: .debit))
                }
                
            }.padding(.top, 10)
            
            CellDivider().frame(height: 10)
        }
    }
}

struct ContactTransactions: Identifiable {
    let id = UUID()
    let date: String
    let amount: String
    let type: TransactionType
}

extension ContactTransactions {
    static func all() -> [ContactTransactions] {
        return [
            ContactTransactions(date: "7 Apr, 5:27 PM", amount: "$\(12343)", type: .credit),
            ContactTransactions(date: "12 Feb, 6:19 AM", amount: "- $\(23343)", type: .debit),
            ContactTransactions(date: "18 Jan, 12:20 AM", amount: "$\(344)", type: .credit),
            ContactTransactions(date: "18 Jan, 9: 30 AM", amount: "$\(456)", type: .credit),
            ContactTransactions(date: "17 Jan, 1:00 AM", amount: "- $\(34)", type: .debit)
        ]
    }
}

struct ContactField: View {
    
    var field: ProfileFieldType
    
    //var icon: Image
    
    var placeHolder: String = "Email"
    
    @Binding var cellValue: String
    @Binding var editEnabled: Bool
    
    var body: some View {
        VStack {
            HStack (alignment: .bottom) {
                VStack (alignment: .leading, spacing: 5) {
                    Text(field.rawValue).modifier(TextFieldLbl())
                    TextField("Enter your \(placeHolder)", text: $cellValue).lineLimit(3)
                        .disabled(editEnabled ? false : true)
                        .opacity(editEnabled && (field == .id || field == .email)  ? 0.5 : 1)
                        .modifier(H7(color: .white))
                    
                }.padding(.trailing, 2.5)
                    .padding(.top, 10)
                
                Spacer()
                
                if editEnabled {
                    
                    if field == .id || field == .bvn {
                        //show padlock
                        Image("CirclePadlock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(Colors.p1.rawValue))
                        .frame(width: 20, height: 20)
                    } else {
                        //Dont show anything
                    }
                    
                } else {
                    //Show the related icon for that field
                    Image(field.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(Colors.p1.rawValue))
                    .frame(width: 20, height: 20)
                }
                
            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            CellDivider().padding(.horizontal, K.CustomUIConstraints.hPadding)
        }
    }
}


