//
//  Contacts.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-19.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct Contacts: View {
    
    
    @State var search = ""
    @State var showContactDetail: Bool = false
    @ObservedObject var contacts = ContactsStore()
    @ObservedObject var store = ContactsStore()
    
    @State var selectedContact: Contact
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            //MARK: - Body Stack
            VStack (alignment: .leading, spacing: 30) {
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color.white.opacity(0.3))
                    
                    TextField("Search", text: self.$search).modifier(H6(color: .white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("darkTextFld"), lineWidth: 1)
                    )
                }.padding()
                .background(Color("darkTextFld"))
                .cornerRadius(8)
                
                ScrollView (showsIndicators: false) {
                    //MARK: -  All Contacts
                    VStack (alignment: .leading, spacing: 30) {
                        
                        //MARK: Recent Contacts
                        VStack (alignment: .leading, spacing: 20) {
                            
                            Text("Recent Contacts").modifier(H3(color: .white))
                            
                            ForEach(store.contacts) { item in

                                Button(action: {
                                    self.showContactDetail.toggle()
                                    self.selectedContact = item
                                    //self.selected = item
                                    
                                }) {
                                    ContactCell(contact: item)
                                }.sheet(isPresented: self.$showContactDetail) {
                                    ContactDetail(contact: self.selectedContact)
                                }
                            }
                        }
                        
                        //MARK: Other Contacts
                        ScrollView {
                            VStack (alignment: .leading, spacing: 20) {
                                HStack {
                                    Text("Other Contacts").modifier(H3(color: .white))
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                        IconsWrapped_Custom(icon: .arrowFromTop)
                                        
                                    }.padding(.all, 1)
                                }
                                ForEach(self.contacts.contacts) { i in
                                    Button(action: {
                                        print(self.contacts.contacts.count)
                                        
                                    }) {
                                        ContactCell(contact: i)
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    
                }
                                
            }
            .padding(.top, K.CustomUIConstraints.topPadding)
            .padding(.horizontal, K.CustomUIConstraints.hPadding)
                
            
            //MARK: - Nav Stack
            MainNavigation(header: .contacts)
        }
        
    }
}

struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts(selectedContact: sampleContact)
    }
}

struct ContactCell: View {
    
    var contact: Contact
    var body: some View {
        VStack {
            HStack (spacing: 20) {
                WebImage(url: contact.avatar)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .cornerRadius(8)
//
                VStack (alignment: .leading, spacing: 5) {
                    Text(contact.name).modifier(H6(color: .white))
                    Text("#\(contact.number)").modifier(H7(color: .grey))
                }
                
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue)).opacity(0.5)
            }
            
            CellDivider().frame(height: 10)
        }//.frame(height: 65)
    }
}



