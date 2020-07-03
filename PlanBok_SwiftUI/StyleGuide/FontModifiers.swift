//
//  FontModifiers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

//enum Colors: String {
//    case white = "white"
//    case grey = "greyText"
//    case p1 = "p1"
//    case tb4 = "tb4"
//    case tb6 = "tb6"
//    case credit = "ctSuccess"
//    case debit = "ctError"
//}

class FontHelper {
    
    static func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
       return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
}

struct FontModifiers: View {
    var body: some View {
        ZStack {
            Color("dark")
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).modifier(H1(color: .p1))
                Text("Hello, World!").modifier(H2(color: .grey))
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).modifier(H3(color: .grey))
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).modifier(H4(color: .grey))
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).modifier(H6(color: .grey))
                
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
    
    let fontHlper = FontHelper()
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
       return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var color: Colors
    
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Medium", size: textSize(textStyle: .largeTitle)))
            .foregroundColor(Color(color.rawValue))
            //.frame(maxWidth: .infinity)
            //.font(.system(.title))
        
    }

}

struct H2: ViewModifier {

    //let fontHlper = FontHelper()
    
    var color: Colors
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Medium", size: 28)).foregroundColor(Color(color.rawValue))
    }

}

struct H3: ViewModifier {

    var color: Colors
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 24)).foregroundColor(Color(color.rawValue))
    }

}

struct H4: ViewModifier {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    

    var color: Colors
    func body(content: Content) -> some View {
        
        
        content.font(.custom("Rubik-Regular", size: 20)).foregroundColor(Color(color.rawValue))
    }

}

struct FormatTransaction: ViewModifier {
    
    //var transaction: CustomerTransaction
    var color: Colors
    
    init(transaction: CustomerTransaction) {
        if transaction.type == "credit" {
            color = .credit
        } else {
            color = .white
        }
    }
    
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 20)).foregroundColor(Color(color.rawValue))
    }
}


struct H6: ViewModifier {

    var color: Colors
    
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 16)).foregroundColor(Color(color.rawValue))
    }

}

struct H7: ViewModifier {

    var color: Colors
    
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 16)).foregroundColor(Color(color.rawValue))
    }

}

struct H8: ViewModifier {

    var color: Colors
    
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 13)).foregroundColor(Color(color.rawValue))
    }

}

struct TextFieldLbl: ViewModifier {
    
    var color: String = "greyText"
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 12)).foregroundColor(Color(color))
    }
    
}

enum Colors: String {
    case white = "white"
    case grey = "greyText"
    case p1 = "p1"
    case p2 = "p2"
    case p3 = "p3"
    case p4 = "p4"
    case tb4 = "tb4"
    case tb5 = "tb5"
    case tb6 = "tb6"
    case credit = "ctSuccess"
    case debit = "ctError"
    case darkTextField = "darkTextFld"
}

