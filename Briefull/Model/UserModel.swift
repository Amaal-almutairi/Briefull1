//
//  UserModel.swift
//  Briefull
//
//  Created by Amaal Almutairi on 16/07/1444 AH.
//

import Foundation


struct User:Encodable, Decodable {
    var uid:String
    var email: String
    var profileImageUr1:String
    var username: String
    var searchName: [String]
    var caption:String
    var friends:[String] = []
}
