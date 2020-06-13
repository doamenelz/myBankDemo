//
//  Menu.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-12.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Menu: View {
    var name: String = "Camilla Lindstrom"
    var icon: String = "MenuSelected"
    var body: some View {
        ZStack {
            BackGround()
            HStack (spacing: 20) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Avatar()
                }
                VStack (alignment: .leading) {
                    Text("Hello,").modifier(H6(color: .grey))
                    Text(name).modifier(H4(color: .white))
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: K.CustomUIConstraints.menuIconFrame)
                    .foregroundColor(Color("p1"))
                }
                
                
            }.padding(.horizontal, 30)
                .padding(.top)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

struct MenuCell: View {
    var body: some View {
        Text("Menu").modifier(H4(color: .grey))
    }
}

struct Avatar: View {
    var body: some View {
        Image("Avatar4")
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
}


