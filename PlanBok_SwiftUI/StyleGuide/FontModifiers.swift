//
//  FontModifiers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

enum FontColors: String {
    case white = "white"
    case grey = "greyText"
    case purple = "p1"
}

struct FontModifiers: View {
    var body: some View {
        ZStack {
            Color("dark")
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).modifier(H1(color: .purple))
                Text("Hello, World!").modifier(H2(color: .grey))
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).modifier(H3(color: .grey))
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).modifier(H4(color: .grey))
                
            }
        }
    }
}

struct FontModifiers_Previews: PreviewProvider {
    static var previews: some View {
        FontModifiers()
    }
}


struct H1: ViewModifier {
    var color: FontColors
    
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Medium", size: 40)).foregroundColor(Color(color.rawValue))
    }

}

struct H2: ViewModifier {

    var color: FontColors
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Medium", size: 32)).foregroundColor(Color(color.rawValue))
    }

}

struct H3: ViewModifier {

    var color: FontColors
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 24)).foregroundColor(Color(color.rawValue))
    }

}

struct H4: ViewModifier {

    var color: FontColors
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 18)).foregroundColor(Color(color.rawValue))
    }

}

struct TextFieldLbl: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 12)).foregroundColor(Color("greyText"))
    }}

