//
//  BottomTabBar.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct BottomNav: View {
   
    @State var current = "Home"
    @Namespace var animation
    @Binding var ChildrenProfiles : [ChildProfileStruct]
    @Binding var FosterEvents : EventAndOrg
    @Binding var AllPrograms: [Programs]
    @State var ProfileDetails : Bool = false;
    @ObservedObject var UserInfo = UserBasedFirebase()
    @Binding var Requests : [FamilyUser]
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $current){
                
                Navigation(FosterOrgEvents: $FosterEvents , ChildrenProfile : $ChildrenProfiles , AllPrograms : $AllPrograms, ChildrenRequests: $Requests).environment(\.colorScheme, .light)
                    .tag("Home")
               
//                RegisteredEvents(ProfileDetails: $ProfileDetails, FosterOrgEvents: $FosterEvents, UserInfo: $UserInfo.UserInfo )
                    Text("Programs")
                    .tag("Programs")
               
                Text("Galleries")
                .tag("Galleries")
            }
            
            HStack(spacing: 0){
                
                // TabButton...
                
              
                TabButtonRe(title: "Programs", image: "filemenu.and.selection", selected: $current)
                
                Spacer(minLength: 0)
                
                TabButtonRe(title: "Event", image: "house.circle", selected: $current)
                
                
                Spacer(minLength: 0)
                
                TabButtonRe(title: "Galleries", image: "photo.on.rectangle.angled", selected: $current)
            }
            .padding(.vertical,12)
            .padding(.horizontal)
            .background(Color("Color2"))
            .clipShape(Capsule())
            .padding(.horizontal,25)
        }
    }
}

