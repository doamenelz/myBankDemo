//
//  Categories.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-20.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Categories: View {
    
    @State var isSelected: Bool = true
    var cat: TransactionCategory = .shopping
    
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            GeometryReader { geometry in
                
                VStack {
                    Button(action: {
                        self.isSelected.toggle()
                    }) {
                        CategoryCell(isExpanded: self.$isSelected, icon: .shopping)
                        
                    }
                    
                    CategoryCell(isExpanded: self.$isSelected, icon: .shopping)
                        .onTapGesture {
                            
                    }
                    
                    Button(action: {
                        self.isSelected.toggle()
                    }) {
                        CategoryCell(isExpanded: self.$isSelected, icon: .bills)
                    }
                    
                    Button(action: {
                        self.isSelected.toggle()
                    }) {
                        CategoryCell(isExpanded: self.$isSelected, icon: .food)
                    }
                    
                    Spacer()
                }
                
                
            }.padding(.top, K.CustomUIConstraints.topPadding)
                .padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            SecondaryNavigation(header: "Categories")
        }
        
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories()
    }
}

struct CategoryCell: View {
    
    @Binding var isExpanded: Bool
    
    var icon: TransactionCategory
    var body: some View {
        
        HStack {
            VStack (alignment: .leading, spacing: 15) {
                HStack {
                    Image(icon.rawValue).renderingMode(.original)
                    .resizable()
                    .frame(width: 20, height: 20)
                    
                    Text(icon.rawValue).modifier(TextFieldLbl())
                }
                Text("-$ 513,30").modifier(H4(color: .white))
            }
            
            Spacer()
            Image(systemName: isExpanded ? SFIcons.chevronUp.rawValue : SFIcons.chevronDown.rawValue)
                .frame(width: 20, height: 20)
                .foregroundColor(Color(Colors.p1.rawValue))
        }
        
        .padding()
        .background(Color(Colors.darkTextField.rawValue))
    .cornerRadius(8)
    }
}
