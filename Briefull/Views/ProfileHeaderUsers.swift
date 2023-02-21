//
//  ProfileHeaderUsers.swift
//  Briefull
//
//  Created by Amaal Almutairi on 01/08/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeaderUsers: View {
    var user:User?
    @State var profileImage: Image?

   @EnvironmentObject var sessionVm: SessionStore

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
                   }
                   Text(user?.username ?? "").font(.headline)
                   Spacer()
               }

               
               
           }
       }
       }
       }
       
   

struct ProfileHeaderUsers_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderUsers()
    }
}
