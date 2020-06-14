//
//  MyProfile.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-13.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct MyProfile: View {
    
    
    
    //MARK: - State Variables: Customer Info
    @State var customerID: String = ProfileInformation.customerInformation().customerID
    @State var customerPhoneNumber: String = "\(ProfileInformation.customerInformation().phoneNumber)"
    @State var customerBVN: String = "\(ProfileInformation.customerInformation().bvn)"
    @State var customerAddress: String = ProfileInformation.customerInformation().address
    @State var customerEmail: String = ProfileInformation.customerInformation().email
    @State var customerName: String = "\(ProfileInformation.customerInformation().firstName) \(ProfileInformation.customerInformation().lastName)"
    
    
    //MARK: - State Variables: Controls
    @State var editEnabled: Bool = false
    
    var body: some View {
        ZStack {
            BackGround(image: Wallpapers.Floater2.rawValue)
            //MARK: - Body Stack
            VStack {
                ScrollView {
                    VStack {
                        Button(action: {
                            
                        }) {
                            ProfileHeader(editEnabled: $editEnabled, name: "\(ProfileInformation.customerInformation().firstName) \(ProfileInformation.customerInformation().lastName)", image: ProfileInformation.customerInformation().avatar)
                        }.disabled(editEnabled ? false : true)
                        
                        
                        //Profile Fields
                        VStack {
                            
                            if editEnabled {
                                ProfileFieldTemplate(field: ProfileFieldType.name, image: ProfileFieldTemplate.getIcon(profileFieldType: ProfileFieldType.name), cellValue: $customerName, editEnabled: $editEnabled, canEdit: editEnabled)
                            }
                            
                            ProfileFieldTemplate(field: ProfileFieldType.id, image: ProfileFieldTemplate.getIcon(profileFieldType: ProfileFieldType.id), cellValue: $customerID, editEnabled: $editEnabled, canEdit: editEnabled)
                            
                            ProfileFieldTemplate(field: ProfileFieldType.email, image: ProfileFieldTemplate.getIcon(profileFieldType: ProfileFieldType.email), cellValue: $customerEmail, editEnabled: $editEnabled, canEdit: editEnabled)
                            
                            ProfileFieldTemplate(field: ProfileFieldType.phoneNumber, image: ProfileFieldTemplate.getIcon(profileFieldType: ProfileFieldType.phoneNumber), cellValue: $customerPhoneNumber, editEnabled: $editEnabled, canEdit: editEnabled)
                            
                            ProfileFieldTemplate(field: ProfileFieldType.bvn, image: ProfileFieldTemplate.getIcon(profileFieldType: ProfileFieldType.bvn), cellValue: $customerBVN, editEnabled: $editEnabled, canEdit: editEnabled)
                            
                            ProfileFieldTemplate(field: ProfileFieldType.address, image: ProfileFieldTemplate.getIcon(profileFieldType: ProfileFieldType.address), cellValue: $customerAddress, editEnabled: $editEnabled, canEdit: editEnabled)
            
                        }
                        
                        if editEnabled {
                            Button(action: {
                                //persist profile
                            }) {
                                Text("Update profile").modifier(ButtonText()).modifier(PrimaryBtn()).padding(.vertical)
                            }
                        }
                        
                    }
                }.padding(.bottom)
            }.padding(.top, 70)
            
            
            //MARK: - Header
            VStack {
                ProfileNav(editEnabled: $editEnabled)
                Spacer()
            }
            
            
        }
        
    }
}

struct MyProfile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyProfile(editEnabled: false).previewDevice("iPhone 8")
            MyProfile(editEnabled: true).previewDevice("iPhone 11 Pro Max")
        }
        
    }
}

struct ProfileHeader: View {
    
    @Binding var editEnabled: Bool
    
    var name: String
    var image: String
    var body: some View {
        VStack (spacing: 30){
            Image(image).renderingMode(.original)
            .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 88, height: 88)
                .cornerRadius(8)
            if editEnabled {
                //Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Change Profile Photo").modifier(H7(color: .purple))
                //}
            } else {
              Text(name).modifier(H4(color: .white))
            }
            
            
        }.padding()
    }
}

struct ProfileFieldTemplate: View {
    
    var field: ProfileFieldType
    
    var image: Image
    
    var placeHolder: String = "Email"
    @Binding var cellValue: String
    
    @Binding var editEnabled: Bool
    
    
    var canEdit: Bool
    
    let icon = {
        
    }
    
    var body: some View {
        VStack {
            HStack (alignment: .bottom) {
                VStack (alignment: .leading, spacing: 5) {
                    Text(field.rawValue).modifier(TextFieldLbl())
                    TextField("Enter your \(placeHolder)", text: $cellValue).lineLimit(3)
                        .disabled(editEnabled ? false : true)
                        .opacity(editEnabled && (field == .id || field == .bvn)  ? 0.5 : 1)
                        .modifier(H7(color: .white))
                    
                }.padding(.trailing, 2.5)
                    .padding(.top, 10)
                
                Spacer()
                
                if editEnabled {
                    
                    if field == .id || field == .bvn {
                        //show padlock
                        Image("CirclePadlock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(FontColors.purple.rawValue))
                        .frame(width: 20, height: 20)
                    } else {
                        //Dont show anything
                    }
                    
                } else {
                    //Show the related icon for that field
                    image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(FontColors.purple.rawValue))
                    .frame(width: 20, height: 20)
                }
                
                
                
            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            CellDivider().padding(.horizontal, K.CustomUIConstraints.hPadding)
        }
    }
}

struct CellDivider: View {
    var body: some View{
        VStack {
            Path{ path in
                path.move(to: CGPoint(x: 10, y: 10))
                path.addLine(to: CGPoint(x: screenWidth, y: 10))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5])).cornerRadius(10)
            .foregroundColor(Color("tb6"))
            .frame(height: -10)
        }
    }
}

struct ProfileInformation {
    let firstName: String
    let lastName: String
    let email: String
    let customerID: String
    let address: String
    let preferredLanguage: String
    let profilePicture: String
    let phoneNumber: Int
    let bvn: Int
    let avatar: String
}

extension ProfileInformation {
    
    static func customerInformation () -> ProfileInformation {
        return ProfileInformation(firstName: "Camilla", lastName: "Lordstrom", email: "camillalordstrom@yahoo.com", customerID: "#5432232", address: "105 Harrison Garden, Blvd. North York, Toronto. Canada", preferredLanguage: "English", profilePicture: "Avatar1", phoneNumber: 08048247330, bvn: 4533432111, avatar: "Avatar1")
    }
}

extension ProfileFieldTemplate {
    //let profileFieldType: ProfileFieldType
    static func getIcon (profileFieldType: ProfileFieldType) -> Image {
        switch profileFieldType {
        case .address:
            return Image(systemName: "house.fill")
        case .id:
            return Image(systemName: "person.crop.square.fill")
        case .email:
            return Image("Email")
        case .name:
            return Image(systemName: "")
        case .bvn:
            return Image(systemName: "person.crop.circle.fill.badge.checkmark")//.foregroundColor(Color(FontColors.purple.rawValue)) as! Image
        case .phoneNumber:
            return Image("Phone Number")
            
    }
    
    }
}

enum ProfileFieldType: String {
    case id = "Customer ID"
    case address = "Address"
    case email = "Email"
    case name = "Name"
    case bvn = "BVN"
    case phoneNumber = "Phone Number"
}

struct ProfileNav: View {
    
    @Binding var editEnabled: Bool
       
       var header: String = "My Profile"
       var icon: String = "Menu"
       var leftIcon: String = "Notifications"
       var body: some View {
           
        HStack {
            Image(systemName: IconsEnum.chevronLeft.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Spacer()
            Text("My Profile").modifier(H4(color: .white))
            Spacer()
            Button(action: {
                self.editEnabled.toggle()
               }) {
                Image(IconsEnum.edit.rawValue)
                    .resizable()
                    .renderingMode(editEnabled ? .original : .none)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(.white)
               }

               
           }.padding(.horizontal, 30)
           .padding(.top)
       }}

