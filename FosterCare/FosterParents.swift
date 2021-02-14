//
//  FosterParents.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import Foundation
import Firebase
struct FamilyUser {
    var UserName: String = ""
    var RegisteredEvents = [String]()
    var NotificationID: String = ""
    var Desc: String = ""
    var email: String = ""
    var City: String = ""
    var Country: String = ""
    var FosterTraining: Bool  = false
    var ProfileImage: String = ""
    var DocumentID: String = ""
    var ChildRequestedFor: String = ""
    
    // Not needed by user
    var RequestedChild = ""
}


class UserBasedFirebase : ObservableObject  {
    let Db = Firestore.firestore()
    @Published var UserInfo = FamilyUser()
    init() {
        GetUserInfo()
    }
    
    func GetUserInfo()   {
        
       
        let DocRf = Db.collection("users").document("likedHmMTzu0Mbcn6zWJ")
        
        DocRf.getDocument { (document, error) in
            
            self.UserInfo.City = document?.get("City") as? String ?? ""
            self.UserInfo.email = document?.get("email") as? String ?? ""
            self.UserInfo.Desc = document?.get("Desc") as? String ?? ""
            self.UserInfo.UserName = document?.get("userName") as? String ?? ""
            self.UserInfo.RegisteredEvents = document?.get("RegEvents") as? [String] ?? [String]()
            print("GOTT \(self.UserInfo.RegisteredEvents)")
            self.UserInfo.ProfileImage = document?.get("ProfileImage") as? String ?? ""
            self.UserInfo.Country = document?.get("Country") as? String ?? ""
            self.UserInfo.FosterTraining = document?.get("FosterTraining") as? Bool ?? false
        }
       
        
    }
    /// Join as event //  programs // Child Request // User info is document ID
    func SendInquiry(Registered: String, UserInfo : String , DocumentID : String ) {
        var Items = [String : Any]()
        let DocRf = Db.collection(Registered).document(DocumentID)
        let DocRfChild = Db.collection("users").document(UserInfo)
       
        DocRf.getDocument { (document, error) in
            
            var ArrayOfRegisters = document?.get("RegUsers") as? [String] ?? [""]
            
            ArrayOfRegisters.append(UserInfo)
            Items["RegUsers"] = ArrayOfRegisters
            self.Db.collection(Registered).document(DocumentID).updateData(Items) { (Error) in
                
            }
            // RegEvents
            print("item beingss \(Items)")
            DocRfChild.getDocument { (UserDoc , error) in
                var item = [String]()
                
                item = UserDoc?.get("RegEvents") as? [String] ?? [String]()
                item.append(DocumentID)
                print("item being \(item)")
                self.Db.collection("users").document(UserInfo).updateData(["RegEvents" : item])
            }
            
        }
        
        
    }
    
    
    
    func SendChildInquiry(UserInfo : String , DocumentID : String ) {
        var Items = [String : Any]()
        let DocRf = Db.collection("children").document(DocumentID)
       
       
        DocRf.getDocument { (document, error) in
            
            var ArrayOfRegisters = document?.get("RegUsers") as? [String] ?? [""]
            
            ArrayOfRegisters.append(UserInfo)
            Items["RegUsers"] = ArrayOfRegisters
            self.Db.collection("children").document(DocumentID).updateData(Items) { (Error) in
                
            }
            // RegEvents
             
            
        }
        
        
    }
    
}

