//
//  SendMoneyConfirmation.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-16.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SendMoneyConfirmation: View {
    
    //@EnvironmentObject var viewRouter: ViewRouter
    
    @State var successfulPayment: Bool = false
    
    var transactionInfo: SubmitTransaction = sampleSendMoney
    
    var recipientImage: URL = SAMPLE_IMAGE_URL!
    
    var paymentCard: CustomerCard = sampleCard
    
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .none)
            //MARK: - Body Stack
            VStack {
                Spacer()
                SendMoneyContactPreview(successfulPayment: $successfulPayment, transaction: transactionInfo, recipientImage: recipientImage)
                    .animation(.easeInOut(duration: 1))
                Spacer()
                SendMoneyBottomModal(makePayment: $successfulPayment, recipientImage: recipientImage, transactionInfo: transactionInfo, paymentCard: paymentCard)
                .animation(.easeInOut(duration: 1))
            }.padding(.top, K.CustomUIConstraints.topPadding)
            .edgesIgnoringSafeArea(.bottom)
            
            
            //MARK: - Nav Stack
            if !successfulPayment {
                SecondaryNavigation(header: successfulPayment ? "Payment Successl!" : "Send Money")
            } else {
                Text("Payment Successful!").modifier(H4(color: .grey)).offset(y: -screenHeight / 2.5)
            }
                        
        }
    }
}

struct SendMoneyConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SendMoneyConfirmation().previewDevice("iPhone 8")
            SendMoneyConfirmation().previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct SendMoneyBottomModal: View {
        
    @Binding var makePayment: Bool
    
    @State var savePayeeSelected: Bool = true
    
    @State var showAlert: Bool = false
    
    @State var alertText: String = ""
    
    @State var alertMessage: String = ""
    
    var recipientImage: URL
    
    var transactionInfo: SubmitTransaction
    
    var paymentCard: CustomerCard
    
    
    func postTransaction () -> Bool {
        
        var isSuccessful: Bool?
        Firestore.firestore().collection(CUSTOMERS_REF).document(CURRENT_USER_EMAIL).collection(TRANSACTIONS_REF).addDocument(data: [
            Transaction_Ref.amount : transactionInfo.amount,
            Transaction_Ref.recipient : transactionInfo.recipientId,
            Transaction_Ref.narration : transactionInfo.narration,
            Transaction_Ref.type : transactionInfo.transactionType,
            Transaction_Ref.category : transactionInfo.transactionCategory,
            Transaction_Ref.recipientName : transactionInfo.recipientName,
            
            "date" : FieldValue.serverTimestamp()
            ], completion: { (error) in
                if let err = error {
                    debugPrint(err.localizedDescription)
                    isSuccessful = false
                } else {
                    print("Transaction was posted Successfully")
                    isSuccessful = true
                }
                
        }
        )
        
        return isSuccessful ?? true
    }
    
    var body: some View {
        
        VStack (spacing: 20) {
            
            if !makePayment {
                Button(action: {
                    
                    let hasSufficentBalance = TransactionModel.checkSufficientBalance(balance: Double(self.paymentCard.balance), amountToTransfer: self.transactionInfo.amount)
                    
                    if hasSufficentBalance {
                        let submitTransaction = self.postTransaction()
                        
                        //Reduce customer balance
                        
                        
                        //Return to Send Money landing pages.
                        
                        
                        if submitTransaction {
                            self.makePayment.toggle()
                            //self.viewRouter.currentPage = .confirmationPage
                        } else {
                            self.alertText = "Transaction Failed"
                            self.alertMessage = "Something went wrong, please try again."
                            self.showAlert.toggle()
                        }
                        
                    } else {
                        self.alertText = "Insufficient Balance"
                        self.alertMessage = "The card \(self.paymentCard.cardNumber)you selected does not have enough balance to make this payment. Please select another card or top up your card"
                        self.showAlert.toggle()
                        print("Insufficient Balance in card")
                    }
                }) {
                    PrimaryButton(label: "Confirm")
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text(alertText), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                Button(action: {
                    //self.makePayment.toggle()
                }) {
                    Text("Cancel").modifier(H4(color: .white))
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                }
            }
            
            if makePayment {
                VStack (spacing: 20) {
                    HStack {
                        WebImage(url: recipientImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .animation(.easeOut(duration: 0.3))
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text(transactionInfo.recipientName).modifier(H6(color: .white))
                            Text(transactionInfo.narration).modifier(TextFieldLbl())
                        }
                        .animation(.easeOut(duration: 0.8))
                        
                        Spacer()
                        /*
                        HStack (spacing: 10) {
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                IconsWrapped_Custom(icon: .arrowToBottom)
                            }
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                IconsWrapped_Custom(icon: .email)
                            }
                            
                            
                            
                        }
                        */
                        
                    }
                    HStack (spacing: 40) {
                        Button(action: {
                            self.makePayment.toggle()
                            
                        }) {
                            PrimaryButton(label: "Done")
                        }
                        
                        
                        
                    }
                    Button(action: {
                        self.savePayeeSelected.toggle()
                    }) {
                        HStack {
                            CheckBoxSelector(isSelected: $savePayeeSelected)
                            Text("Save Payee?").modifier(H7(color: .white))
                            
                        }//.frame(height: 50)
                    }.padding(.bottom)
                }.animation(Animation.easeInOut(duration: 0.8))
            }
            
        }
            
        .padding([.vertical,.horizontal], 30)
        .background(Color(Colors.tb4.rawValue))
            //.edgesIgnoringSafeArea(.all)
        .cornerRadius(20)
        
        //Spacer()
        
        
    }
}

struct SendMoneyContactPreview: View {
    
    @Binding var successfulPayment: Bool
    
    @State private var phase: CGFloat = 0
    
    var transaction: SubmitTransaction
    var recipientImage: URL
    
    @State var displayAmnt: String = ""
    
    var body: some View {
        ZStack {
            if !successfulPayment {
                Circle()
                .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [3], dashPhase: phase)).foregroundColor(Color(Colors.p4.rawValue)).opacity(0.8)
                .frame(width: 150, height: 150)
                .onAppear { self.phase -= 20 }
                    .animation(Animation.linear.repeatForever().speed(0.1))
            }
            
            
            if successfulPayment {
              Circle()
                .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color(successfulPayment ? Colors.credit.rawValue : Colors.p4.rawValue).opacity(0.5), Color(Colors.tb4.rawValue)]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 4, dash: [3], dashPhase: phase)).foregroundColor(Color(Colors.darkTextField.rawValue))
                //.animation(.easeInOut(duration: 0.9))
                .frame(width: 270, height: 270)
                .onAppear { self.phase -= 20 }
                .animation(Animation.linear.repeatForever(autoreverses: false).speed(0.1))
                
                
            }
            
                
            
            Circle()
                .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [5])).foregroundColor(Color(Colors.darkTextField.rawValue)).opacity(0.8)
                .frame(width: 350, height: 350)
            
            
            VStack (spacing: 20) {
                if !successfulPayment {
                   Image("IconSmile")
                    .animation(.easeInOut(duration: 0.1))
                }
                
                VStack (spacing: 10) {
                    Text(successfulPayment ? "" : "Sending cash to").modifier(H6(color: successfulPayment ? .white : .grey)).background(Color("dark"))
                    .animation(.easeInOut(duration: 0.3))
                    Text(transaction.recipientName).modifier(H3(color: .white)).background(Color("dark"))
                    .animation(.easeInOut(duration: 0.6))
                }
                
                WebImage(url: recipientImage)
                .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                .cornerRadius(8)
                .animation(.easeInOut(duration: 0.8))
                
                Text(displayAmnt).modifier(H3(color: .white))
                .animation(.easeInOut(duration: 0.9)).background(Color("dark"))
                
                if successfulPayment {
                    Image(systemName: "checkmark.circle.fill")
                    .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(Colors.credit.rawValue))
                    .animation(.easeInOut(duration: 0.7))
                }
                
            }.onAppear {
                self.displayAmnt = formatNumber(number: self.transaction.amount)
            }
        }
    }
}
