//
//  AddFriends.swift
//  Briefull
//
//  Created by Amaal Almutairi on 11/07/1444 AH.
//

import SwiftUI

// user profile
struct UserProfile: View {
    @State private var value: String = ""
   // @State var users: [User] = []
    @State var isLoading = false
    @EnvironmentObject var sessionVm: SessionStore
         var user:User

      @EnvironmentObject var profileService:ProfileService
    
    
    func searchUsers(){
        isLoading = true
        SearchService.searchUser(input: value) {
            (users) in
            self.isLoading = false
            self.profileService.users = users
            
        }
    }
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                SearchBar(value: $value).padding()
                    .onChange(of: value, perform: {
                        new in
                        searchUsers()
                    })
                if !isLoading {
                    ForEach(profileService.users, id:\.uid) {
                        user in
                        NavigationLink(destination: UsersProfileView(user: user)){
                            //                            HStack{
                            //                                webImage(url:URL(string:
                            //                                                    user.profileImageUrl)!).resizable()
                            //                                    .scaledToFit()
                            //                                    .clipShape(Circle()).frame(width: 40 , height: 60, alignment: .trailing).padding()
                            //                                Text(user.username).font(.subheadline).bold()
                            //
                            //                            }
                            //                            Divider().background(Color.black)
                            
                            HStack{
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 40, height: 40, alignment: .leading)
                                Text(user.username)
                                Spacer()
//                                FollowButton(user: user, followCheck: $profileService.followCheck, requestCount: $profileService.requestList, friendstCount: $profileService.friendsList).modifier(Items.ButtonModifierRequest()).foregroundColor(.white)
//                                Text("\(profileService.friendsList)").font(.headline).padding(.trailing, 50)
                                
                            }.padding(.leading, 50)
//                            Divider().background(Color.black)
                        }
                    }
                }
            }
        }  .navigationTitle("Add Friends")
    }
    
}
//
//struct AddFriends_Previews: PreviewProvider {
// var sessionVm: SessionStore
//    var vmCardService:VideotCardService
//    static var previews: some View {
//        AddFriends().environmentObject(SessionStore()).environmentObject(VideotCardService())
//    }
//}
