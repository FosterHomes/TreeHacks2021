//  Created by Harshil Bhatt on 13/02/2021.

import SwiftUI
//import SDWebImageSwiftUI

struct MainHome: View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var selectedTab = "Events"
    @State var current = "Events"
    @Binding var show: Bool;
    @Binding var Index: Int;
    
    @State var WebsiteShown : String = "https://www.kidsave.org/donate/"
    
    
    @Binding var ProfileDetail: Bool
    @Namespace var animation
    @Binding var FosterOrgEvents : EventAndOrg
    @Binding var Children : [ChildProfileStruct]
    
    @Binding var ChildrenRequests : [FamilyUser]
    @Binding var AllPrograms : [Programs]
    var IfOrg : Bool
    
    @Binding var ViewRegistered: Bool
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
        VStack(spacing: 0){
            
            VStack{
                
                ZStack{
                    
                    HStack{
                        Button(action: {
                            
                            withAnimation{
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            // close Button...
                            
                            Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                                .resizable()
                                .frame(width: self.show ? 18 : 22, height: 18)
                                .foregroundColor(Color.black.opacity(0.7))
                        }
                        
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {}, label: {
                            
                           
                        })
                        
                    }
                    
                    Text("KidSave")
                        .font(.title2)
                        .fontWeight(.semibold).foregroundColor(Color.white).fontWeight(.bold)
                }
                .padding()
                .padding(.top,edges!.top)
                .foregroundColor(.black).background(Color("Fav").ignoresSafeArea(.all, edges: .all))
                
                if self.Index == 0{
//                    HStack {
//
//                        ForEach(tabs,id: \.self){title in
//
//                            TabButton(selectedTab: $selectedTab, title: title, animation: animation)
//                        }
//                    }
//                    .padding()
//                    .background(Color.yellow)
//                    .cornerRadius(15)
//                    .padding(.vertical)
                }
            }
            .padding(.bottom)
            .background(Color("top"))
            
            
        ZStack{
                
                Color("top")
                
                Color("bg")
                   
                 
                ScrollView {
                    
                    if self.Index != 0 {
                        if (self.Index == 1) {
                            CreateNewEvent()
                        } else if (self.Index == 2) {
                            NewReference()
                        }
                        
                        else if (self.Index == 4){
                            Inquiries() // Chat System
                        }
                        else {
                            Inquire(ChildrenRequests: $ChildrenRequests, EventsRegistered: $FosterOrgEvents.FosterEvent)
                        }
                    }
                    else if current == "Galleries" {
                        //TapChild
                        ChildProfile(animation: animation, Children: $Children)
                       // TopHomePage()
                        
                    }
                    else if current == "Programs" {
                       
                        OrgProgramsProfile(AllPrograms: $AllPrograms).padding(12)
                    }
                    
                    else {
                       
                        EventsPage(IfOrg: IfOrg, ProfileDetails : $ProfileDetail, FosterOrgEvents: $FosterOrgEvents, ViewRegistered: self.$ViewRegistered)
                    }
                    
                }
                //.clipShape(CustomCorner(corner: .topRight, size: 65))
                // its cutting off inside view may be its a bug....
            }
        }
            if self.Index == 0 && ProfileDetail == false  {
                VStack {
                    HStack(spacing: 0){
                        
                        // TabButton...
                        
                        TabButtonRe(title: "Programs", image: "filemenu.and.selection", selected: $current)
                        
                        Spacer(minLength: 0)
                        
                        TabButtonRe(title: "Events", image: "house.circle", selected: $current)
                        
                        
                        Spacer(minLength: 0)
                        
                        TabButtonRe(title: "Galleries", image: "photo.on.rectangle.angled", selected: $current)
                    }
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(Color("Fav"))
                    .clipShape(Capsule())
                    .padding(.horizontal,25)
                }.padding(20)
            }
            
            
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

var tabs = ["Events","Programs","Galleries"]

struct TabButton : View {
    
    @Binding var selectedTab : String
    var title : String
    var animation : Namespace.ID
    
//    var body: some View{
//
//        Button(action: {
//
//            withAnimation{
//
//                selectedTab = title
//            }
//
//        }, label: {
//
//            Text(title)
//                .foregroundColor(.black)
//                .padding(.vertical,10)
//                .padding(.horizontal)
//                // Sliding Effect...
//                .background(
//
//                    ZStack{
//
//                        if selectedTab == title{
//
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.white)
//                                .matchedGeometryEffect(id: "Tab", in: animation)
//                        }
//                    }
//                )
//        })
//    }
    
    var body: some View {
        Button(action: {
                             
            selectedTab = title
        }) {
            
            VStack {
                
                
                
                
                Text(title)
                    .foregroundColor(selectedTab == title ? Color("Color3") : Color.gray.opacity(0.7))
                
                
                Capsule()
                    .fill(selectedTab == title ? Color("Color3") : Color.white)
                    .frame(height: 2)
            }
        }
    }
}


