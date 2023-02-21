//
//  ProfileHeader.swift
//  Briefull
//
//  Created by Amaal Almutairi on 20/07/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeader: View {

     var user:User?
    var postsCounts:Int
    @Binding var following:Int
    @Binding var followers:Int
    @State var profileImage: Image?
    @State var pickedImage: Image?
    @State var showingActionSheet = false
    @State private var imageData = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showingImagePiker = false
    @EnvironmentObject var sessionVm: SessionStore

    func loadImage() {
        guard let inputImage = pickedImage else{return}
        profileImage = inputImage
        
    }
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                if user != nil {
                    if  let userProfile = user?.profileImageUr1{
                        WebImage(url: URL(string: userProfile))
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 0.9, height: 100, alignment: .trailing)
                            .padding(.leading)
                    }
                }else{
                    Color.init(red: 0.9, green: 0.9, blue: 0.9).frame(width: 100, height: 100, alignment: .trailing)
                        .padding()
                }
                VStack{
                    if profileImage != nil {
                        profileImage!.resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                            .padding()
                            .onTapGesture {
                                self.showingActionSheet = true
                            }
                    }else{
                        ZStack(alignment: .top) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                                .padding()
                            .onTapGesture {
                                self.showingActionSheet = true
                            }
                        }
                    }
                     
                            
                        
                    
                    Text(user?.username ?? "").font(.headline)
                    Spacer()
                }

                
                
            }
        }    .sheet(isPresented: $showingImagePiker, onDismiss: loadImage) {
            ImagePicker(selectedImage: self.$pickedImage, showImagePiker: self.$showingImagePiker, imageData: self.$imageData)
//            ImagePicker(selectedImage: self.$pickedImage, showImagePiker: self.$showImagePikerProfile, imageData: self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet){
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Choose A Photo")){
                    self.sourceType = .photoLibrary
                    self.showingImagePiker = true
                }, .cancel()
            ])
        }
        
    }
}
struct ProfileHeader_Previews: PreviewProvider {
    @EnvironmentObject var sessionVm: SessionStore

    static var previews: some View {

        ProfileHeader(user: User?(User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus")), postsCounts: 0, following:.constant(0), followers:.constant(0))

//        ProfileHeader(user: User(uid: "9988", email: "amaal@gmail.com", profileImageUr1: "", username: "moly", searchName: [""], caption: "molyus"), vlogsCounts: .constant(0), friends:.constant(0))
            .environmentObject(SessionStore())

    }
}

