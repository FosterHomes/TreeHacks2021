//
//  OrganisationFile.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import Foundation

// Sample Data
var OrgIdFb = "Cw0UaoztvkLQ0CnSxBmd"
var Name = "KidSave"


struct FosterCare {
    var Contact : [String]
    var Location : String
    var OrgImage : String
    var name : String
    var SiteUrl : String
    var Desc = ""
}

struct FosterEvents {
    
    var Title: String
    var Venue: String
    var Location : String
    var Desc: String
    var EventDate: String
    var Contacts = Contact(Email: "", Name: "")
    var ImageUrl: String
    var DocumentID = ""
    var OrgID = ""
    var Registered : Bool = false;
    var RegisteredUsers: [String] = [String]()
    
//    var Volunteer: [Volunteer]
    
}

struct ChildProfileStruct {
    var age : String
    var name : String
    var lastName : String
    var ImageUrl : String
    var FosterRef: String
    var Desc: String
    var Location : String
    var SiteUrl : String
    var Inquiries = [String]()
    var DocumentID = ""
    var FosterOrg = FosterCare(Contact: [""], Location: "", OrgImage: "", name: "", SiteUrl: "")
}

struct Programs {
    var name : String = ""
    var OrgId: String = ""
    var Desc: String = ""
    var ImageUrl : String = ""
    var SiteUrl : String = ""
    var Contacts = ""
    var OrgName : String = ""
    var DocumentReference = ""
    var type : String = ""
    var RegIsers : [String] = [String]()
    var Org = FosterCare(Contact: [""] , Location: "", OrgImage: "", name: "", SiteUrl: "")
}
struct EventAndOrg {
    var FosterEvent : [FosterEvents] = [FosterEvents]()
    var FosterOrg : [FosterCare] = [FosterCare]()
}



