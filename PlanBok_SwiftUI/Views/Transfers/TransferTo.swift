//
//  TransferToWallet.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-15.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct TransferTo: View {
    
    @State var originAccount: String = "VISA - 2344 ($ 1,200)"
    @State var invalidAmount: Bool = false
    @State var amount: Int = 0
    @State var narration: String = "mmkmkmkmkmkmknjbyb"
    
    var pinA: Int = 0
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater1)
            
            //MARK: - Body Stack
            
            VStack {
                ScrollView (showsIndicators: false) {
                    VStack (spacing: 40){
                        TextDropdown(fieldValue: $originAccount, label: "Transfer from")
                        TextDropdown(fieldValue: $originAccount, label: "Transfer to")
                        TextFldNIcons(placeHolder: "Enter an amount", textValue: "$ \(amount)", invalidField: invalidAmount, label: "Amount")
                        TextFldNIcons(placeHolder: "Enter an amount", textValue: narration, invalidField: invalidAmount, label: "Notes")
                        TextFldNIcons(placeHolder: "Transaction PIN", textValue: "\(pinA)", invalidField: invalidAmount, label: "Transaction PIN")
                        Button(action: {
                            
                        }) {
                            PButton(label: "Continue")
                        }
                        
                    }
                    
                }
                Spacer()
            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                .padding(.top, K.CustomUIConstraints.topPadding)
            
            
            //MARK: - Navigation
            SecondaryNavigation(header: "Transfer to Wallet")
        }
    }
}

struct TransferToWallet_Previews: PreviewProvider {
    static var previews: some View {
        TransferTo()
    }
}



