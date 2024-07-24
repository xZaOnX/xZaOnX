//
//  DatabaseManager.swift
//  massenger
//
//  Created by Ozan Öneyman on 23.07.2024.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
}
   


extension DatabaseManager{
    public func userExists(with email : String, completion : @escaping(Bool) -> Void){
        
        database.child(email).observeSingleEvent(of:.value, with:   {
            snaphot in   guard snaphot.value as? String != nil else {
            
                completion(false)
                
                return
            }
            completion(true)
        })
        
    }
    
    public func insertUser(with user: ChatAppUser){
        database.child(user.emailAdress).setValue([
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
        
    }
    
    
    struct ChatAppUser {
        let firstName : String
        let lastName : String
        let emailAdress : String
        // let profilePictureUrl:String
    }
}
    
    

