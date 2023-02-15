//
//  EditPersonalInfo.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI

struct EditPersonalInfo: View {
    @EnvironmentObject var sessionVm: SessionStore
    //    @State var changeProfileImage = false
    //    @State var openCameraRoll = false
    //        @State var userName = ""
    @State var nickName = ""
    @State var imageSelected: Image?
    @State var profileImg: Image?
    @State var showSheetProfile = false
    @State var showImagePikerProfile = false
    @State var imageData:Data = Data()
    @State var sourceType:UIImagePickerController.SourceType = .photoLibrary
    
    
    func loadImage() {
        guard let inputImg = imageSelected else { return}
        profileImg = inputImg
    }
    
    func clear(){
        self.imageData = Data()
        self.profileImg = Image(systemName: "person.circle.fill")
    }
    var body: some View {
//        NavigationView{
            VStack{
                VStack{
                    ScrollView{
                        VStack(alignment: .center){
            //
            //                    if profileImg != nil {
            //                        Image(systemName: "person")
            //                        profileImg? .profileImageMod()
            //                            .onTapGesture {
            //                                self.showSheetProfile = true
            //                            }
            //                    } else {
                                    ZStack(alignment: .bottomTrailing) {
                                        profileImg? .profileImageMod()
                                       Image(systemName: "person.circle")
                                            .profileImageMod()
                                        Image(systemName: "highlighter")
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.white)
                                            .background(Color("mauve"))
                                            .clipShape(Circle())
                                            .onTapGesture {
                                                self.clear()
                                                self.showSheetProfile = true
                                            }
                                    }
                            Text(sessionVm.session?.username ?? "UkUsername")
                            Spacer()
                            VStack(alignment: .leading,spacing: 30){
                                VStack(alignment: .leading){
                                    Text("nickName")
                                    TextField("Enter nickName", text: $nickName).textFieldStyle(RoundedBorderTextFieldStyle())
                                    //                                    .padding()
                                }.padding(.leading)
                                
                                VStack(alignment: .leading){
                                    Text("Email")
                                    TextField("Enter Email", text: $nickName).textFieldStyle(RoundedBorderTextFieldStyle())
                                    //                                    .padding()
                                }.padding(.leading)
                            }.padding(.top)
                        }
                    }
                }
                .sheet(isPresented: $showImagePikerProfile, onDismiss: loadImage) {
                    ImagePicker(selectedImage: self.$imageSelected, showImagePiker: self.$showImagePikerProfile, imageData: self.$imageData)
                }.actionSheet(isPresented: $showSheetProfile){
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Choose A Photo")){
                            self.sourceType = .photoLibrary
                            self.showImagePikerProfile = true
                        },
                        .default(Text("Take A Photo")){
                            self.sourceType = .camera
                            self.showImagePikerProfile = true

                        }, .cancel()
                    ])
                }
            }.navigationTitle("Edit Profile").navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                                        Button {
                    
                    self.sessionVm.logout()
                    
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.forward").foregroundColor(Color("mauve"))
                   
                })
            
//        }
    }
}

struct EditPersonalInfo_Previews: PreviewProvider {
    var session: SessionStore
    static var previews: some View {
        EditPersonalInfo().environmentObject(SessionStore())
    }
}
