//
//  AddContact.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-07-07.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct AddContact: View {
    
    @State var search : String = ""
    //@State var pickerSelection: Int = 0
    @State var selectedSection: Int = 0
    
    var colors = [Color("p1"),Color("p3")]
    
    var textFColors = [Color("tb3"), Color("tb4")]
    
    @ObservedObject var merchant = Payees()
    
    @ObservedObject var allUsers = UsersM()
    
    @State var didSearch : Bool = false
    
    @State var searchedMerchants: [Merchants] = []
    
    @State var searchedUsers: [Users] = []
    
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater1)
            
            VStack (spacing: 20) {
                Color.gray
                    .frame(width: 70, height: 5).opacity(0.3)
                    .cornerRadius(2)
                Text("Add a Payee").modifier(H4(color: .white))
                HStack(spacing: 15){
                    
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.white.opacity(0.3))
                    
                    ZStack (alignment: .leading) {
                        
                        if search.isEmpty {
                            Text("Enter Payee's Email")
                                .foregroundColor(Color(Colors.white.rawValue).opacity(0.3))
                        }
                        
                        TextField("", text: self.$search,
                                  onCommit: {
                                    
                                    self.searchedMerchants.removeAll()
                                    self.merchant.searchMerchants(searchedText: self.search)
                                    self.searchedMerchants = self.merchant.filtered
                                    
                                    self.searchedUsers.removeAll()
                                    
                                    self.allUsers.searchUsers(searchedText: self.search)
                                    self.searchedUsers = self.allUsers.filtered
                                    
                                    if self.search == "" {
                                      self.didSearch = false
                                    } else {
                                        self.didSearch = true
                                    }
                                    
                                    /*
                                    if self.selectedSection == 0 {
                                        self.searchedUsers.removeAll()
                                        
                                        self.allUsers.searchUsers(searchedText: self.search)
                                        self.searchedUsers = self.allUsers.filtered
                                        
                                        if self.search == "" {
                                          self.didSearch = false
                                        } else {
                                            self.didSearch = true
                                        }
                                        
                                        
                                    } else if self.selectedSection == 1 {
                                        self.searchedMerchants.removeAll()
                                        self.merchant.searchMerchants(searchedText: self.search)
                                        self.searchedMerchants = self.merchant.filtered
                                        
                                        if self.search == "" {
                                          self.didSearch = false
                                        } else {
                                            self.didSearch = true
                                        }
                                    }
                                    */
                                    
                        })
                            .modifier(H6(color: .white))
                    }
                    
                    
                }
                .padding()
                .background(LinearGradient(gradient: .init(colors: self.textFColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(8)
                .padding(.horizontal, K.CustomUIConstraints.hPadding)
                
                ZStack {
                    Color(.white).opacity(0.01)
                        .frame(width: screenWidth - 30, height: 55)
                    
                    HStack (spacing: 5) {
                        
                        Button(action: {
                            self.selectedSection = 0
                        }) {
                            Text("Users")
                                .modifier(H6(color: .white))
                                .padding(.vertical, 10)
                                .frame(width: screenWidth / 2.5)
                                .background(LinearGradient(gradient: .init(colors: self.selectedSection == 0 ? self.colors: [Color.white.opacity(0.06)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(Capsule())
                        }
                        
                        Button(action: {
                            self.selectedSection = 1
                        }) {
                            Text("All Merchants")
                                .modifier(H6(color: selectedSection == 1 ? .white : .white))
                                .padding(.vertical, 10)
                                .frame(width: screenWidth / 2.5)
                                .background(LinearGradient(gradient: .init(colors: self.selectedSection == 1 ? self.colors: [Color.white.opacity(0.06)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(Capsule())
                        }
                        
                    }
                    .padding(.vertical, 10)
                }
                .frame(width: screenWidth - 50)
                .clipShape(Capsule())
                
                if selectedSection == 0 {
                        ScrollView (showsIndicators: false) {
                            VStack {
                                if !didSearch {
                                    ForEach(allUsers.users) { user in
                                        Button(action: {
                                            
                                        }) {
                                            UsersCell(user: user)
                                        }
                                    }
                                }
                                
                                if didSearch {
                                    ForEach(searchedUsers) { user in
                                        Button(action: {
                                            
                                        }) {
                                            UsersCell(user: user)
                                        }
                                    }
                                }
                                
                            }
                            
                        }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                }
                
                if selectedSection == 1 {
                    
                    ScrollView (showsIndicators: false) {
                        VStack {
                            if !didSearch {
                                ForEach(merchant.allMerchants) { merc in
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                        MerchantCell(merchant: merc)
                                    }
                                }
                            }
                            
                            if didSearch {
                                ForEach(searchedMerchants) { merc in
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                        MerchantCell(merchant: merc)
                                    }
                                }
                            }
                            
                        }
                    }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                }
            }.padding(.top, 10)
                
            //MARK: Secondary Navigation
            //SecondaryNavigation(header: "Add Contact")
        }
    }
}

struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
        AddContact()
    }
}

struct MerchantCell: View {
        var merchant: Merchants
        var body: some View {
            VStack {
                HStack (spacing: 20) {
                    WebImage(url: merchant.avatar)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                        .cornerRadius(8)
    
                    VStack (alignment: .leading, spacing: 5) {
                        Text(merchant.name).modifier(H6(color: .white))
                        Text(merchant.merchantID).modifier(H7(color: .grey))
                    }
                    
                    Spacer()
                    /*
                    Text("Shopping").modifier(H7(color: .white))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color("tb5"))
                        .cornerRadius(20)
                       
                    */
                    
                    Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue)).opacity(0.5)
                }
                
                CellDivider().frame(height: 10)
            }
        }

}

struct UsersCell: View {
        var user: Users
        var body: some View {
            VStack {
                HStack (spacing: 20) {
                    WebImage(url: user.avatar)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                        .cornerRadius(8)
    
                    VStack (alignment: .leading, spacing: 5) {
                        Text(user.name).modifier(H6(color: .white))
                        Text(user.userID).modifier(H7(color: .grey))
                    }
                    
                    Spacer()
                    /*
                    Text("Shopping").modifier(H7(color: .white))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color("tb5"))
                        .cornerRadius(20)
                       
                    */
                    
                    Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue)).opacity(0.5)
                }
                
                CellDivider().frame(height: 10)
            }
        }

}


