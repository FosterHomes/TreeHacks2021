//
//  MainUserPage.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct MainUserPage: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Binding var selectedTab : String 
    
    @State var show: Bool = false;
    @State var Index: Int = 0;
    
    @State var WebsiteShown : String = "https://www.kidsave.org/donate/"
    @Namespace var animation
    @Binding var Detail : Bool
    @Binding var DetailProgram: Bool
    @Binding var ViewOrgProfile : Bool
    @State var search: String = ""
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    
    // All Firebase Documents
    
    @Binding var Children: [ChildProfileStruct]
    @Binding var FosterOrgEvents : EventAndOrg
    @Binding var AllPrograms: [Programs]
    
    
    @Binding var ViewRegistered: Bool 
    var body: some View{
        
        
       
        VStack {
            
            
            HStack {
                
                Text("Bubble")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Fav"))
                Spacer()
            }.padding(.horizontal, 40).padding(.top , 40)
            Divider().padding(20)
//            HStack(spacing: 20){
//
//                ForEach(tabs,id: \.self){title in
//
//                    TabButton(selectedTab: $selectedTab, title: title, animation: animation)
//                }
//            }.padding(10)
//            .padding()
//            .background(Color("Color2"))
//            .cornerRadius(15)
//            .padding(.vertical)
            
//            Divider().padding(20)
                            
//                            TextField("Search", text: self.$search)
//                                .padding(.vertical,20)
//                                .padding(.horizontal)
//                                .background(Color.white)
//                                .cornerRadius(10)
//                                .padding(.horizontal, 20)
//                                .padding(10).shadow(radius: 12)
//
            
            
            
            
            
            // StickyView
            //  CreateNewEvent()
            ScrollView(.vertical, showsIndicators: false) {
                
                
                if ViewRegistered {
                    RegisteredEvents(ProfileDetails: $DetailProgram, FosterOrgEvents: $FosterOrgEvents, ViewRegisted: self.$ViewRegistered )
                }
                else if selectedTab == "Events" {
                
//                    TopHomePage(DetailsTapped: $Detail, KidsStruct: $Children).padding(12)
//                
                    EventsPage(IfOrg: false, ProfileDetails : $DetailProgram ,  FosterOrgEvents: $FosterOrgEvents, ViewRegistered: self.$ViewRegistered)
                }
                else if selectedTab == "Programs" {
                     
                
                    ProgramsView(Detail: $DetailProgram, AllPrograms: $AllPrograms)
                    
                }
                
                
                else {
                    
                    ChildrenGallery(Detail: $Detail , OrgProfile: $ViewOrgProfile, ChildrenProfiles: Children )
                    
                }
                
                
                
            }
            
            
            
        }.background(Image("ZOver").ignoresSafeArea(.all, edges: .all)) .matchedGeometryEffect(id: "content", in: animation)
    }
}

var Usertabs = ["Events","Children's", "Organisation"]




