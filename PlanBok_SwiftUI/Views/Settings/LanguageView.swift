//
//  LanguageView.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-14.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct LanguageView: View {
    
    var languages = Languages.all()
    @State var isSelected: Bool = true
    @State var notSelected: Bool = false
    @State var selectedLanguage = "English"
    @State var usersCurrentLanguage = "Nederlands"
    
    
    
    var body: some View {
        
        //MARK: - Main View
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            //MARK: - Body Stack
            ScrollView {
                
                    VStack {
                        ForEach(languages) { language in
                            
                            Button(action: {
                                self.usersCurrentLanguage = language.label
                                print(self.usersCurrentLanguage)
                                
                            }) {
                                if language.label == self.usersCurrentLanguage  {
                                    RadioCell(isSelected: self.$isSelected, label: language.label)
                                } else {
                                    RadioCell(isSelected: self.$notSelected, label: language.label)
                                }
                                
                            }
                        }
                }
                .padding(.horizontal, K.CustomUIConstraints.hPadding)
                .padding(.top, 5)
                
                Spacer()
            }
            .padding(.top, K.CustomUIConstraints.topPadding)
            
            //MARK: - Nav Stack
            SecondaryNavigation(header: "Languages")
        }
        
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(isSelected: true, selectedLanguage: "Language")
    }
}

struct Languages: Identifiable {
    let id = UUID()
    let label: String
}

extension Languages {
    
    static func all () -> [Languages] {
        
        return [
        Languages(label: "English"),
        Languages(label: "Español"),
        Languages(label: "Français"),
        Languages(label: "Nederlands"),
        Languages(label: "Svenska"),
        Languages(label: "Yoruba")
        
        ]
    }
    
}
