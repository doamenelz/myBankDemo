//
//  Transfers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-15.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Transfers: View {
    var body: some View {
        ZStack{
            BackGround(wallpaper: .Floater1)
            
            //MARK: - Body Stack
            VStack {
                VStack {
                    Button(action: {
                        
                    }) {
                        TransfersCell(icon: .arrowToBottom, label: "Transfer to Wallet")
                    }
                    
                    Button(action: {
                        
                    }) {
                        TransfersCell(icon: .arrowFromTop, label: "Transfer to Bank")
                    }
                }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                Spacer()
            }.padding(.top, K.CustomUIConstraints.topPadding)
            
            
            //MARK: - Nav Stack
            MainNavigation(header: .transfers)
        }
    }
}

struct Transfers_Previews: PreviewProvider {
    static var previews: some View {
        Transfers()
    }
}

struct TransfersCell: View {
    var icon: CustomSymbols
    var label: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            HStack (spacing: 20) {
                IconsWrapped_Custom(icon: icon)
                Text(label).modifier(H6(color: .white))
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue)).opacity(0.5)
                
            }.padding(.top, 5)
            CellDivider()
        }
    }
}
