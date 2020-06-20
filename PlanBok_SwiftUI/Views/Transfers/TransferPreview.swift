//
//  TransferPreview.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-16.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct TransferPreview: View {
    var body: some View {
        
        ZStack {
            BackGround(wallpaper: .none)
            
            //MARK: - Body Stack
            VStack (spacing: 30) {
                VStack {
                    PreviewField(label: "Date", value: "20 Apr 2020")
                    PreviewField(label: "Transfer from", value: "VISA **** 2356")
                    PreviewField(label: "Transfer to", value: "First Bank")
                    PreviewField(label: "Amount", value: "$ 1,200")
                    PreviewField(label: "Notes", value: "Paying Bills")
                }
                
                HStack (spacing: 20){
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        IconsWrapped_Custom(icon: .arrowToBottom)
                    }
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        IconsWrapped_Custom(icon: .email)
                        
                        
                    }
                }.offset(x: screenWidth / 2 - 76)
                Spacer()
                Button(action: {
                    
                }) {
                    PButton(label: "Complete")
                }
                Spacer()
            }.padding(.top, K.CustomUIConstraints.topPadding)
            .padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            
            //MARK: - Navigation
            SecondaryNavigation(header: "Confirm")
        }
        
    }
}

struct TransferPreview_Previews: PreviewProvider {
    static var previews: some View {
        TransferPreview()
    }
}

struct PreviewField: View {
    var label: String = "label"
    var value: String = "Value"
    var body: some View {
        VStack {
            HStack {
                Text(label).modifier(H6(color: .grey))
                Spacer()
                Text(value).modifier(H6(color: .white))
            }.padding(.top, 5)
            CellDivider()
        }
    }
}
