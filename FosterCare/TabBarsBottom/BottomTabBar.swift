//
//  BottomTabBar.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct BottomTabBar: View {
    @State var Detail : Bool = false;
    @State var current = "Home"
    @Namespace var animation
    @Binding var ChildrenProfiles : [ChildProfileStruct]
    @Binding var FosterEvents : EventAndOrg
    @Binding var AllPrograms: [Programs]
    @State var ProfileDetails : Bool = false;
    @State var DetailProgram : Bool = false
    @ObservedObject var UserInfo = UserBasedFirebase()
    @State var Selected : String = "Programs"
    
    @State var ViewRegisted = false;
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
             
                
               
                TabBar(Detail : $Detail , DetailProgram: $DetailProgram , ProfileDetail : $ProfileDetails , ChildrenProfiles:
                        $ChildrenProfiles, FosterEvents: self.$FosterEvents, AllPrograms: self.$AllPrograms, Selected: $Selected, ViewRegistered: self.$ViewRegisted  ).background(Color("Color1"))
                    
                 
                
                //    RegisteredEvents(ProfileDetails: $ProfileDetails, FosterOrgEvents: $FosterEvents, UserInfo: $UserInfo.UserInfo, ViewRegisted: self.$ViewRegisted )
                    
                 
             
            TabssBarss(selected: self.$Selected)
                .offset(y: 45)
            
//            HStack(spacing: 0){
//
//                // TabButton...
//              //  if self.ProfileDetails == false && self.Detail == false && self.DetailProgram == false {
//                TabButtonRe(title: "Home", image: "house.circle", selected: $current)
//
//                Spacer(minLength: 0)
//
//                TabButtonRe(title: "Registered Events", image: "filemenu.and.selection", selected: $current)
//              //  }
//            }
//            .padding(.vertical,12)
//            .padding(.horizontal)
//            .background(Color.yellow)
//            .clipShape(Capsule())
//            .padding(.horizontal,25)
        }
    }
}

struct TabButtonRe: View {
    var title: String
    var image: String
    
    @Binding var selected : String
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){selected = title}
        }) {
            
            HStack(spacing: 10){
                
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                
                if selected == title {
                    
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color.purple.opacity(selected == title ? 0.8 : 0))
            .clipShape(Capsule())
        }
    }
}


struct RegisteredEvents : View {
    @Binding var ProfileDetails : Bool
    @Binding var FosterOrgEvents : EventAndOrg
    
    //@Binding var UserInfo : FamilyUser
    
    @Binding var ViewRegisted : Bool;
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Registered Events")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    
                    
                    Button(action : {
                        self.ViewRegisted.toggle()
                    }) {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis").foregroundColor(Color("Fav")).font(.system(size: 35))
                    }
                    
                    
                    
                    
                    
                }.padding(.horizontal, 40)
                ForEach (0..<FosterOrgEvents.FosterEvent.count, id : \.self) { i in
                    VStack {
                        
                        if (RegistedEventsByUser.contains(FosterOrgEvents.FosterEvent[i].DocumentID)) {
                            PostRow(IfOrg: false, ProfileDetail: self.$ProfileDetails, FosterEvent: FosterOrgEvents.FosterEvent[i] , FosterCare: FosterOrgEvents.FosterOrg[i]).shadow(radius: 7)
                        }
                        
                        
                    }.onAppear {
                        
                        //print("\(UserInfo.UserName) Events Registered: \(UserInfo.RegisteredEvents) && -- && \(FosterOrgEvents.FosterEvent[i].DocumentID)")
                    }
                    .padding()
                    .padding(.bottom,8)
                }
                
                Spacer()
            }.background(Color.white)
        }
        
    }
}
