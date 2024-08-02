import Foundation
import FirebaseDatabase
import FirebaseAuth

final class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    var user1 = FirebaseAuth.Auth.auth().currentUser
    
    static func safeEmail(emailAddress: String) -> String {
        
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with:  "-")
        return safeEmail
        
    }
}

extension DatabaseManager{
    public func userExists(with email : String, completion : @escaping(Bool) -> Void){
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with:  "-")
        
        
        database.child(safeEmail).observeSingleEvent(of:.value, with:   {
            snaphot in   guard snaphot.value as? String != nil else {
                
                completion(false)
                
                return
            }
            completion(true)
        })
        
    }
    
    public func insertUser(with user: ChatAppUser, completion : @escaping(Bool) -> Void){
        if user1 == nil {
            database.child("users").child(user1?.uid ?? "idler").setValue([
                "email_adress" : user.emailAdress,
                "first_name" : user.firstName,
                "last_name" : user.lastName
            ],withCompletionBlock: { error, _ in
                guard error == nil else {
                    print("failed to write to database")
                    completion(false)
                    return
                }
                completion(true)
            })
        }
    }
    
}
    struct ChatAppUser {
        let firstName : String
        let lastName : String
        let emailAdress : String
        
        
        var safeEmail :String{
            var safeEmail = emailAdress.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with:  "-")
            return safeEmail
        }
        // let profilePictureUrl:String
        var profilePictureFileName:String{
            //ozan-gmail-com-profile-picture.png
            return "\(safeEmail)-profile_picture.png"
        }
    }

    

    

