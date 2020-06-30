//
//  RegisterBio.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-21.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct RegisterBio: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                BackGround(wallpaper: .Floater1)
                UserProfile(vc: self.viewController)
                
            }
        }
    }
}

struct RegisterBio_Previews: PreviewProvider {
    static var previews: some View {
        RegisterBio()
    }
}


struct UserProfile: View {
    
    var vc: UIViewController?
    
    //MARK: - State Variables: Customer Info
    @State var customerID: String = ""
    @State var customerPhoneNumber: String = ""
    @State var customerBVN: String = "\(CustomerProfile.customerInformation().bvn)"
    @State var customerAddress: String = CustomerProfile.customerInformation().address
    @State var customerEmail: String = ""
    @State var customerName: String = ""
    @State var updateSuccessful: Bool = false
    
    
    
    
    let currentUser = Auth.auth().currentUser
    
    //MARK: - State Variables: Controls
    @State var editEnabled: Bool = true
    
    @State var showImgPicker = false
    @State private var inputImage: UIImage?
    @State var image: Image?
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func uploadProfilePic () {
        
        let meta =
            [
                "customerName" : customerName
            ]
        
        let metadata = StorageMetadata()
        //metadata.contentType = "image/jpeg"
        metadata.customMetadata = meta
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let avatarRef = storageRef.child("\(currentUser!.email ?? "av").jpg")
        let imagesRef = storageRef.child("avatars/\(avatarRef)")
        
        imagesRef.putData(inputImage!.jpegData(compressionQuality: 0.35)!, metadata: metadata) { (metadata, error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            } else {
                print("Success")
            }
            
        }
    }
    
    var body: some View {
        ZStack {
            BackGround(wallpaper: .Floater2)
            //MARK: - Body Stack
            VStack {
                ScrollView {
                    VStack {
                        Button(action: {
                            
                        }) {
                            ProfileAvat(showPicker: $showImgPicker, name: customerName, image: image)
                            
                        }.sheet(isPresented: $showImgPicker, onDismiss: loadImage) {
                                ImagePicker(image: self.$inputImage)
                        }
                        
                        
                        //MARK: Profile Fields
                        VStack {
                            
                            ContactField(field: .id, placeHolder: "", cellValue: $customerID, editEnabled: $editEnabled)
                            
                            ContactField(field: .email, placeHolder: "email", cellValue: $customerEmail, editEnabled: $editEnabled)
                            
                            ContactField(field: .name, placeHolder: "name", cellValue: $customerName, editEnabled: $editEnabled)
                            
                            ContactField(field: .phoneNumber, placeHolder: "name", cellValue: $customerPhoneNumber, editEnabled: $editEnabled)
                            
                            //Update User Profile
                            Button(action: {
                                //guard let userID = Auth.auth().currentUser?.uid else {return}
                                guard let email = Auth.auth().currentUser?.email else {return}
                                
                                
                                self.uploadProfilePic()
                                
                                Firestore.firestore().collection(CUSTOMERS_REF).document(email).setData([
                                    NAME : self.customerName,
                                    PHONE_NUMBER : self.customerPhoneNumber,
                                    "signUpDate" : FieldValue.serverTimestamp()
                                    ], completion: { (error) in
                                        if let error = error {
                                            debugPrint(error.localizedDescription)
                                            
                                        } else {
                                            print("uer was created")
                                            self.vc?.present(presentationStyle: .fullScreen) {
                                                ConfirmationView(status: true, screenToGoTo: .wallet)
                                            }
                                        }
                                })
                            }) {
                                Text("Next").modifier(ButtonText()).modifier(PrimaryBtn()).padding(.vertical)
                            }
                            
                                        
                        }.onAppear {
                            let newCustomerID: Int = RegistrationVM.generateCustomerID()
                            self.customerID = "#\(newCustomerID)"
                            guard let cEmail = self.currentUser?.email else {return}
                            self.customerEmail = cEmail
                            
                        }

                        
                    }
                }.padding(.bottom)
            }.padding(.top, 70)
            
        }
        
    }
}

struct ProfileAvat : View {
    @Binding var showPicker: Bool
    var name: String
    var image: Image?
    var body: some View {
        VStack (spacing: 30){
            
            if image != nil {
                image?
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 88, height: 88)
                .cornerRadius(8)
            } else {
                Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 88, height: 88)
                    .foregroundColor(Color(Colors.p1.rawValue))
                .cornerRadius(8)
            }
                Button(action: {
                    self.showPicker.toggle()
                }) {
                    Text("Change Profile Photo").modifier(H7(color: .p1))
                }
            
              Text(name).modifier(H4(color: .white))
            
        }.padding()
    }
}

