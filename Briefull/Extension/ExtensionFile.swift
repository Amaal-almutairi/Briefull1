//
//  ExtensionFile.swift
//  Briefull
//
//  Created by Amaal Almutairi on 15/07/1444 AH.
//


import SwiftUI

extension Image {
    
    func profileImageMod() -> some View {
        self
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
    
}

extension Rectangle {
    
    func rectangle() -> some View {
        self
            .frame(width:UIScreen.main.bounds.width - 30, height: 500).cornerRadius(20)
            .foregroundColor(.gray.opacity(0.40))
    }
    
}
extension Rectangle {
    
    func rectangleImoji() -> some View {
        self
            .frame(width:UIScreen.main.bounds.width - 30, height: 120).cornerRadius(20)
            .foregroundColor(.gray.opacity(0.40))
    }
    
}


extension Encodable {
    func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder () . encode (self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String: Any]
    else {
    throw NSError()
    }
    return dictionary
   }
}


extension Decodable{
    
    init(fromDictionary: Any ) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary,
                                              options: .prettyPrinted)
        let decoder = JSONDecoder ( )
        self = try decoder.decode (Self.self, from: data)
    }
}

extension String {
    
    func splitString() -> [String] {
        
        var stringArray: [String] = []
        let trimmed = String(self.filter{ !" \n\t\r".contains($0)})
        for (index, _) in trimmed.enumerated(){
            let prefixIndex = index+1
            let substringPrefix =
            String(trimmed.prefix(prefixIndex)).lowercased()
            stringArray.append(substringPrefix)
          
        }
        return stringArray
    }
    
    func removeWhiteSpace() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
}


extension Date {
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = . full
        formatter.allowedUnits = [.year, .month, .day, . hour, .minute, . second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "" ,locale: .current)
    }
}
