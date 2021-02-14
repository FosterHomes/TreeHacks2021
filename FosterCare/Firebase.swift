//
//  Firebase.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class FirebaseFoster : ObservableObject {
    let OrgUser : Bool // True if Org
    let Db = Firestore.firestore()
    @Published var Events = [FosterEvents]()
    @Published var Galleries = [ChildProfileStruct]()
    @Published var AllPrograms = [Programs]()
    @Published var FosterOrgEvents = EventAndOrg()
    @Published var UserInfo = FamilyUser()
    
    @Published var ChildrenRequests = [FamilyUser]()
    
    
    @Published var FamilyInfo = UserBasedFirebase().UserInfo
    init(OrgUser: Bool ) {
        // GetListOfEvents(OrgID: OrgIdFb)
        //   PostEvent()
        //GetAllEventsUser()
        self.OrgUser = OrgUser
        
        if OrgUser == false {
            GetUserInfo()
            GetAllEventsUser()
            GetNewProgramss()
            CallChildren(false)
            
        }
        else {
            
            GetOrgEvents(OrgID: OrgIdFb)
            CallChildren(true)
            //ChildrenInquries()
            self.ChildrenInqury()
            GetOrgProgram()
        }
    }
    
    func GetUserInfo() -> FamilyUser {
        
       
        let DocRf = Db.collection("users").document("likedHmMTzu0Mbcn6zWJ")
        
        DocRf.getDocument { (document, error) in
            
            self.UserInfo.City = document?.get("city") as? String ?? ""
            self.UserInfo.email = document?.get("email") as? String ?? ""
            self.UserInfo.email = document?.get("email") as? String ?? ""
            self.UserInfo.UserName = document?.get("displayName") as? String ?? ""
            self.UserInfo.ProfileImage = document?.get("profileImageUrl") as? String ?? ""
            self.UserInfo.ProfileImage = document?.get("profileImageUrl") as? String ?? ""
            self.UserInfo.Country = document?.get("country") as? String ?? ""
            self.UserInfo.FosterTraining = document?.get("fosterTraining") as? Bool ?? false
            
        }
        return self.UserInfo
        
    }
    func CallChildren(_ Org: Bool) {
        self.Db.collection("children").addSnapshotListener { (QuerySnapshot, Error) in
            self.Galleries = [ChildProfileStruct]()
            if (Error != nil) {
                return
            }
            
            for EventID in QuerySnapshot!.documents {
                
                self.ChildrenProfile(EventID.documentID)
                
                
                
            }
            
            
        }
    }
    
    func GetOrgEvents(OrgID: String) {
        let orgProfile = GetProfile(OrgId: OrgIdFb)
        Db.collection("events").addSnapshotListener { (QuerySnapshot, Error) in
            self.Events = [FosterEvents]()
            self.FosterOrgEvents.FosterOrg = [FosterCare]()
            if Error != nil {
                print(Error?.localizedDescription ?? "Some Weird Error")
            }
            
            
            for EventId in QuerySnapshot!.documents {
                print("Items IS == \(EventId.get("orgIDStr") as? String ?? "")")
                if (EventId.get("orgIDStr") as? String ?? "" == OrgID) {
                    print("Comes here too == \(EventId.get("orgIDStr") as? String ?? "")")
                    let Name = EventId.get("name") as? String ?? ""
                    let Desc = EventId.get("description") as? String ?? ""
                    //   let EventDate = EventId.document.get("eventDate") as! Date
                    //                    let Location = EventId.document.get("venue") as! String
                    let VenueLink = EventId.get("siteUrl") as? String ?? ""
                    let ImageUrl = EventId.get("ImageUrl") as? String ?? ""
                    let DocumentID = EventId.documentID
                    let RegUsers = EventId.get("RegUsers") as? [String] ?? [String]()
                    let EventDate = EventId.get("eventDateTime") as? Timestamp ?? Timestamp()
                    
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy/MM/dd HH:mm"
                  
                    let epocTime = TimeInterval(EventDate.dateValue().timeIntervalSince1970)
                    let myDate = NSDate(timeIntervalSince1970: epocTime)
                    let date = myDate
                    let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
                    let components = calendar.components([.month, .day , .hour , .minute], from: date as Date)
                    let monthName = DateFormatter().monthSymbols[components.month! - 1]
                    
                    let FinalDate = "\(components.day ?? 1) \(monthName), 2021"
                    
                    var Event = FosterEvents(Title: Name, Venue: VenueLink, Location: "Location", Desc: Desc, EventDate: "\(FinalDate)", ImageUrl: ImageUrl)
                    Event.DocumentID = DocumentID
                    //self.Events.append(Event)
                    Event.DocumentID = "\(EventId.documentID)"
                    Event.RegisteredUsers = RegUsers
                    self.Events.append(Event)
                    self.FosterOrgEvents.FosterEvent = self.Events
                    self.FosterOrgEvents.FosterOrg.append(orgProfile)
                    
                    
                }
                
                
            }
            
            
            
            
        }
        
        
    }
    func GetAllEventsUser() {
        
        Db.collection("events").addSnapshotListener { (QuerySnapshot, Error) in
            
            if Error != nil {
                print(Error?.localizedDescription ?? "Some Weird Error")
            }
            self.Events = [FosterEvents]()
            
            for EventId in QuerySnapshot!.documents {
                
                
                print("The reference is \(EventId.documentID)")
                
                let Name = EventId.get("name") as?  String ?? ""
                if (Name ==  "") {
                    continue
                }
                let Desc = EventId.get("description") as?  String ?? ""
                //   let EventDate = EventId.document.get("eventDate") as! Date
                //                    let Location = EventId.document.get("location") as! String
                let VenueLink = EventId.get("siteUrl") as?  String ?? ""
                let ImageUrl = EventId.get("ImageUrl") as?  String ?? ""
                let OrgNum = EventId.get("orgIDStr")  as?  String ?? ""
                let EventDate = EventId.get("eventDateTime") as? Timestamp ?? Timestamp()
                let RegUsers = EventId.get("RegUsers") as? [String] ?? [String]()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
              
                let epocTime = TimeInterval(EventDate.dateValue().timeIntervalSince1970)
                let myDate = NSDate(timeIntervalSince1970: epocTime)
                let date = myDate
                let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
                let components = calendar.components([.month, .day , .hour , .minute], from: date as Date)
                let monthName = DateFormatter().monthSymbols[components.month! - 1]
                
                let FinalDate = "\(components.day ?? 1) \(monthName), 2021"
                
                
                
                
                
                
                
                var Event = FosterEvents(Title: Name, Venue: VenueLink, Location: "Location", Desc: Desc, EventDate: "\(FinalDate)", ImageUrl: ImageUrl)
                Event.OrgID = "\(OrgNum)"
                Event.RegisteredUsers = RegUsers
//                if (self.UserInfo.RegisteredEvents.contains(EventId.document.documentID)) {
//                    Event.Registered = true;
//                }
                 
                print("Ree \(Event.RegisteredUsers)")
                
                Event.DocumentID = "\(EventId.documentID)"
                self.Events.append(Event)
                self.FosterOrgEvents.FosterEvent = self.Events
                
                
                
                
                
                
                
            }
            // ADD THAT AFTER  self.FosterOrgEvents.FosterEvent = self.Events if it does not work
            for i in self.Events {
                self.FosterOrgEvents.FosterOrg.append(self.GetProfile(OrgId: i.OrgID))
            }
            
            
            
        }
        
        
        
    }
    // Get Org profile
    func GetProfile(OrgId: String) -> FosterCare {
        var FC = FosterCare(Contact: [String](), Location: "", OrgImage: "", name: "", SiteUrl: "")
        //  print("Result is \(Split(org: OrgId, From: "", To: "/")) Other side is \(Split(org: OrgId, From: "/", To: ""))")
        let DocRf = Db.collection("fosterHome").document("Cw0UaoztvkLQ0CnSxBmd")
        DocRf.getDocument { (document, error) in
            FC.name = document?.get("name") as? String ?? ""
            FC.Location = document?.get("Location") as? String ?? ""
            FC.SiteUrl = document?.get("siteUrl") as? String ?? ""
            FC.OrgImage = document?.get("logoUrl") as? String ?? ""
            FC.Desc = document?.get("desc") as? String ?? ""
             
        }
        return FC
    }
    
    func ChildrenInqury() -> [FamilyUser] {
        
        
        
        var Kids = [FamilyUser]()
        self.Db.collection("children").addSnapshotListener { (QuerySnapshot, Error) in
            // self.Galleries = [ChildProfileStruct]()
            if (Error != nil) {
                return
            }
            
            for EventID in QuerySnapshot!.documents {
                // print("ID is going to be --> \(EventID.document.documentID)")
                
                if (EventID.get("fosterRef") as? String ?? "" == OrgIdFb) {
                    // let OrgKids =  EventID.document("\(EventID.document.documentID)").get("Inquiries") as? [String] ?? [String]()
                    
                   
                    let OrgKids =  EventID.get("Inquiries") as? [String] ?? [String]()
                    
                    let Name = EventID.get("firstName") as? String ?? ""
                    
                    let DocRf = self.Db.collection("users")
                    
                    
                    
                    
                    
                    for n in OrgKids {
                        
                        print("N being \(n)")
                        DocRf.document(n).getDocument {(documemt , error ) in
                            var Fam = FamilyUser()
                            
                            Fam.City = documemt?.get("City") as? String ?? ""
                           // Fam.Country = documemt?.get("Country") as? String ?? ""
                            Fam.Desc = documemt?.get("Desc") as? String ?? ""
                            print("Desc \(Fam.Desc)")
                            
                            Fam.RegisteredEvents = documemt?.get("RegEvents") as? [String] ?? [String]()
                            Fam.ProfileImage = documemt?.get("ProfileImage") as? String ?? ""
                            Fam.UserName = documemt?.get("userName") as? String ?? ""
                            Fam.email = documemt?.get("email") as? String ?? ""
                            Fam.FosterTraining = documemt?.get("FosterTraining") as? Bool ?? false
                            Fam.UserName = documemt?.get("userName") as? String ?? ""
                            Fam.RequestedChild = Name
                          //  Fam.ChildRequestedFor = documemt?.get(Name) as? String ?? ""
                            
                            Kids.append(Fam)
                            self.ChildrenRequests.append(Fam)
                        }
                        
                        
                        
                
                    }
                    
                }
            }
            
            
        }
       
      
        return Kids
        
    }
    
    func ChildrenProfile(_ DocumentID: String ) -> ChildProfileStruct {
        
        
        var FC = ChildProfileStruct(age: "", name: "", lastName: "", ImageUrl: "", FosterRef: "", Desc: "", Location: "", SiteUrl: "")
        let DocRf = Db.collection("children").document(DocumentID)
       
        
     
        DocRf.getDocument { (document, error) in
           
            FC.name = document?.get("firstName") as? String ?? ""
            FC.name += " "
            FC.name += document?.get("lastName") as? String ?? ""
            FC.age = document?.get("age") as? String ?? ""
            FC.Desc = document?.get("description") as? String ?? ""
            FC.Location = document?.get("Location") as? String ?? ""
            FC.SiteUrl = document?.get("siteUrl") as? String ?? ""
            FC.ImageUrl = document?.get("ImageUrl") as? String ?? ""
         //   FC.FosterRef = document?.get("logoUrl") as? String ?? ""
            FC.FosterRef = document?.get("fosterRef") as? String ?? ""
            FC.DocumentID = document?.documentID ?? ""
            let OrgUserID = document?.get("fosterRef") as? String ?? ""
            
           
    
            
            
            self.Db.collection("fosterHome").document(OrgUserID).getDocument { (document, error) in
                var FCs = FosterCare(Contact: [String](), Location: "", OrgImage: "", name: "", SiteUrl: "")
                FCs.name = document?.get("name") as? String ?? ""
                FCs.Location = document?.get("Location") as? String ?? ""
                FCs.SiteUrl = document?.get("siteUrl") as? String ?? ""
                FCs.OrgImage = document?.get("logoUrl") as? String ?? ""
                FC.FosterOrg = FCs
            
            if FC.age != "" {
                if self.OrgUser {
                     
                    if (OrgUserID == OrgIdFb) {
                         
                        self.Galleries.append(FC)
                        // self.ChildrenInquries()
                    }
                } else {
                    self.Galleries.append(FC)
                }
                
            }
         
            
           
        }
        }
        
      
        return FC
        
    }
    
    func GetEachChild(_ DocumentID: String, _ orgIg: String  ) -> ChildProfileStruct {
        
        
        var FC = ChildProfileStruct(age: "", name: "", lastName: "", ImageUrl: "", FosterRef: "", Desc: "", Location: "", SiteUrl: "")
        let DocRf = Db.collection("children").document(DocumentID)
        
     
        DocRf.getDocument { (document, error) in
            FC.FosterRef = document?.get("fosterRef") as? String ?? ""
            if (orgIg == FC.FosterRef) {
               
            
            FC.name = document?.get("firstName") as? String ?? ""
            FC.name += " "
            FC.name += document?.get("lastName") as? String ?? ""
            FC.age = document?.get("age") as? String ?? ""
            FC.Desc = document?.get("description") as? String ?? ""
            FC.Location = document?.get("Location") as? String ?? ""
            FC.SiteUrl = document?.get("siteUrl") as? String ?? ""
            FC.ImageUrl = document?.get("imageUrl") as? String ?? ""
         //   FC.FosterRef = document?.get("logoUrl") as? String ?? ""
            FC.FosterRef = document?.get("fosterRef") as? String ?? ""
            FC.DocumentID = document?.documentID ?? ""
            }
            
        }
        
      
        return FC
        
    }
    
    
    
    
    
    
    func OrgChildren() -> ChildProfileStruct {
        
        
        var FC = ChildProfileStruct(age: "", name: "", lastName: "", ImageUrl: "", FosterRef: "", Desc: "", Location: "", SiteUrl: "")
        _ = Db.collection("children").addSnapshotListener { (QuerySnapshot, Error) in
            self.Galleries = [ChildProfileStruct]()
            
            
            for documents in QuerySnapshot!.documents {
                
                if (documents.get("fosterRef") as? String ?? "") == OrgIdFb {
                    FC.name = documents.get("firstName") as? String ?? ""
                    FC.name += " "
                    FC.name += documents.get("lastName") as? String ?? ""
                    FC.age = documents.get("age") as? String ?? ""
                    FC.Desc = documents.get("description") as? String ?? ""
                    FC.Location = documents.get("Location") as? String ?? ""
                    FC.SiteUrl = documents.get("siteUrl") as? String ?? ""
                    FC.ImageUrl = documents.get("imageUrl") as? String ?? ""
                    FC.FosterRef = documents.get("logoUrl") as? String ?? ""
                    FC.Inquiries = documents.get("Inquiries") as? [String] ?? [String]()
                    let OrgUserID = documents.get("fosterRef") as? String ?? ""
                    FC.DocumentID = documents.documentID
                    print(FC.name)
                    
                    if FC.age != "" {
                        if self.OrgUser {
                            if (OrgUserID == OrgIdFb) {
                                self.Galleries.append(FC)
                            }
                        } else {
                            self.Galleries.append(FC)
                        }
                        
                        
                    }
                    
                    
                }
                
            }
            
        }
        return FC
        
    }
    
    
    
    
    func PostNewProgram(_ FosterEvent: Programs) {
        
        var Items = [String : Any]()
        
        Items["orgIDStr"] = FosterEvent.OrgId;
        Items["name"] = FosterEvent.name
        Items["siteUrl"] = FosterEvent.SiteUrl
        Items["description"] = FosterEvent.Desc
        Items["ImageUrl"] = FosterEvent.ImageUrl
        
        //        if (FosterEvent.Contacts.Name != "") {
        //        Items["Contact"] = [FosterEvent.Contacts.Name : FosterEvent.Contacts.Email]
        //        }
        
        
        Db.collection("programs").document().setData(Items) { (Error) in
            
        }
    }
    
    // Get new programs
    
    func GetNewProgramss() {
        Db.collection("programs").addSnapshotListener { (QuerySnapshot, Error) in
            
            if Error != nil {
                print(Error?.localizedDescription ?? "Some Weird Error")
            }
            self.AllPrograms = [Programs]()
            for EventId in QuerySnapshot!.documents {
                
                //   print("The reference is \(EventId.document.documentID)")
                var ProgramDesign = Programs()
                ProgramDesign.OrgName = EventId.get("orgName") as? String ?? ""
//                if (ProgramDesign.OrgName == "") {
//                    continue
//                }
                ProgramDesign.name = EventId.get("Name") as?  String ?? ""
                
                ProgramDesign.Desc =  EventId.get("description") as? String ?? ""
                //   let EventDate = EventId.document.get("eventDate") as! Date
                //
                ProgramDesign.ImageUrl = EventId.get("ImageUrl") as? String ?? ""
                ProgramDesign.OrgId = EventId.get("fosterRef") as? String ?? ""
                ProgramDesign.SiteUrl = EventId.get("siteUrl") as? String ?? ""
                ProgramDesign.Contacts = EventId.get("regUrl") as? String ?? ""
                ProgramDesign.DocumentReference = EventId.documentID
                ProgramDesign.Org = self.GetProfile(OrgId: ProgramDesign.OrgId)
                
               // print("OMGGGGG--- \(ProgramDesign.name)")
                self.AllPrograms.append(ProgramDesign)
               
                
            }
            
            
            
            
            
        }
        
    }
    
    func GetOrgProgram() {
        Db.collection("programs").addSnapshotListener { (QuerySnapshot, Error) in
            
            if Error != nil {
                print(Error?.localizedDescription ?? "Some Weird Error")
            }
            self.AllPrograms = [Programs]()
            for EventId in QuerySnapshot!.documents {
                
                //   print("The reference is \(EventId.document.documentID)")
                var ProgramDesign = Programs()
                print("Itemss---> Are: \(EventId.documentID)")
                ProgramDesign.OrgId = EventId.get("fosterRef") as? String ?? ""
                let Test = EventId.get("orgIDStr") as? String ?? ""
                
                if (ProgramDesign.OrgId == OrgIdFb || Test == OrgIdFb) {
                    ProgramDesign.name = EventId.get("Name") as?  String ?? ""
                    
                    ProgramDesign.Desc =  EventId.get("description") as? String ?? ""
                    //   let EventDate = EventId.document.get("eventDate") as! Date
                    //
                    ProgramDesign.ImageUrl = EventId.get("ImageUrl") as? String ?? ""
                    ProgramDesign.OrgId = EventId.get("fosterRef") as? String ?? ""
                    ProgramDesign.SiteUrl = EventId.get("siteUrl") as? String ?? ""
                    ProgramDesign.Contacts = EventId.get("regUrl") as? String ?? ""
                    ProgramDesign.DocumentReference = EventId.documentID
                    ProgramDesign.Org = self.GetProfile(OrgId: ProgramDesign.OrgId)
                    // print("OMGGGGG--- \(ProgramDesign.name)")
                    print("Itemss---> Being: \(ProgramDesign.name)")
                    self.AllPrograms.append(ProgramDesign)
                }
                
                
            }
            
            
            
            
            
        }
        
    }
    
}



class PostToFirebase {
    
    
    let Db = Firestore.firestore()
    init (){
        
    }
    
    
    
    func PostNewEvent(_ FosterEvent: FosterEvents, AddDate: Date) {
        
        var Items = [String : Any]()
        
        Items["orgIDStr"] = OrgIdFb;
        Items["name"] = FosterEvent.Title
        Items["RegUsers"] = [String]()
        Items["siteUrl"] = FosterEvent.Venue
        Items["description"] = FosterEvent.Desc
        Items["ImageUrl"] = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmedia-exp1.licdn.com%2Fdms%2Fimage%2FC4D0BAQEUArKVkqIEGQ%2Fcompany-logo_200_200%2F0%2F1519864260534%3Fe%3D2159024400%26v%3Dbeta%26t%3Dhm9G77R-K0feemAgDpvYB8s5BucQHVWN9dQRC_k3gBA&imgrefurl=https%3A%2F%2Fwww.linkedin.com%2Fcompany%2Fkidsave&tbnid=p8bV09j4_6lURM&vet=12ahUKEwjc-6iWlunuAhVCLxoKHeS0DDgQMygAegUIARCVAQ..i&docid=dU9EN2mVcLgpVM&w=200&h=200&q=kidSave&safe=strict&ved=2ahUKEwjc-6iWlunuAhVCLxoKHeS0DDgQMygAegUIARCVAQ"
        
        
        
        Items["eventDateTime"] = AddDate
        
//        if (FosterEvent.Contacts.Name != "") {
//            Items["Contact"] = [FosterEvent.Contacts.Name : FosterEvent.Contacts.Email]
//        }
        Items["RegUsers"] = [String : String]()
        
        
        Db.collection("events").document().setData(Items) { (Error) in
            
        }
    }
    
    
    func PostNewProgram(_ FosterEvent: Programs ) {
         
            var Items = [String : Any]()
            
            Items["orgIDStr"] = OrgIdFb;
            Items["Name"] = FosterEvent.name
            Items["orgIDStr"] = OrgIdFb
            Items["siteUrl"] = FosterEvent.SiteUrl
            Items["description"] = FosterEvent.Desc
            Items["ImageUrl"] = FosterEvent.ImageUrl
            //  Items["eventDateTime"] = AddDate
            Items["type"] = "Host a child"
            Items["orgName"] = FosterEvent.Org.name
            //        if (FosterEvent.Contacts.Name != "") {
            //            Items["Contact"] = [FosterEvent.Contacts.Name : FosterEvent.Contacts.Email]
            //        }
            Items["RegUsers"] = [String : String]()
            
            
            Db.collection("programs").document().setData(Items) { (Error) in
            }
        
    }
    func Sample() {
        for _ in 1...10 {
            var Items = [String : Any]()
            
            Items["age"] = "";
            Items["description"] = "";
            Items["firstName"] = ""
            Items["Inquiries"] = [String]()
            Items["fosterRef"] = ""
            
            Items["ImageUrl"] = ""
            Items["siteUrl"] = ""
    //        if (FosterEvent.Contacts.Name != "") {
    //            Items["Contact"] = [FosterEvent.Contacts.Name : FosterEvent.Contacts.Email]
    //        }
            Items["lastName"] = ""
            Items["location"] = ""
            
            
            Db.collection("children").document().setData(Items) { (Error) in
                
            }
        }
    }
    
    
    
    func PostNewChildProfile(_ FosterEvent: ChildProfileStruct) {
        
        var Items = [String : Any]()
        
        Items["fosterRef"] = OrgIdFb;
        Items["Name"] = FosterEvent.name
        Items["siteUrl"] = FosterEvent.SiteUrl
        Items["imageUrl"] = FosterEvent.ImageUrl
        Items["location"] = FosterEvent.Location
        Items["age"] = FosterEvent.age
        Db.collection("chidlren").document().setData(Items) { (Error) in
            
        }
    }
    
    
    func DeleteEvent(_ FosterEvent: FosterEvents) {
        
        Db.collection("events").document(FosterEvent.DocumentID).delete()
        
    }
    
    func DeletChildProfile(_ FosterChild: ChildProfileStruct) {
        
        Db.collection("children").document(FosterChild.DocumentID).delete()
        
    }
    
    
    
    
    
}

