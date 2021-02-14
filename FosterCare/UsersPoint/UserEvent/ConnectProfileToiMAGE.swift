//
//  ConnectProfileToiMAGE.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

// MainHome(edges: $show, selectedTab: $index, show: $FosterOrgEvents, Index: IfOrg, WebsiteShown: $ViewProgram).background(Color.white)
struct TabBar: View {
    @Namespace var animation
    @StateObject var detailObject = DetailViewModel()
    @Binding var Detail : Bool
    @Binding var DetailProgram : Bool
    @Binding var ProfileDetail: Bool 
    
    // Firebase Events
    @Binding var ChildrenProfiles : [ChildProfileStruct]
    @Binding var FosterEvents : EventAndOrg
    @Binding var AllPrograms: [Programs]
    @Binding var Selected: String
    
    @Binding var ViewRegistered: Bool
    
    
   
    var body: some View {
        
        ZStack {
            

         
                
            MainUserPage( selectedTab: $Selected, Detail: $Detail , DetailProgram : $DetailProgram, ViewOrgProfile: $ProfileDetail , Children : $ChildrenProfiles, FosterOrgEvents: $FosterEvents, AllPrograms: $AllPrograms, ViewRegistered: self.$ViewRegistered)
                    .environmentObject(detailObject)
                    .tabItem{
                        
                        Image("today")
                            .renderingMode(.template)
                        
                        Text("Today")
                    }.opacity(detailObject.show ? 0 : 1)
                
            
            ViewPopUps(DetailProgram: $DetailProgram, ProfileDetail: $ProfileDetail, ChildrenProfile: ChildrenProfiles, Detail: $Detail, AllPrograms: $AllPrograms)
            
            // hiding tab bar when detail page opnes...
            //.opacity(detailObject.show ? 0 : 1)
            
           
        }.background(Color("Color1"))
        .frame(maxWidth: .infinity, maxHeight: .infinity).matchedGeometryEffect(id: "content", in: animation)
    }
}

// Today

var SelecetedOrg = FosterCare(Contact: [""], Location: "", OrgImage: "", name: "", SiteUrl: "")
struct ViewPopUps: View {
    @Binding var DetailProgram : Bool
    @Binding var ProfileDetail: Bool
    var ChildrenProfile : [ChildProfileStruct]
    @StateObject var detailObject = DetailViewModel()
    @Binding var Detail : Bool
    @Binding var AllPrograms : [Programs]
    
    var body: some View {
        if detailObject.show || self.Detail {
            
            
            Home(Detail : $Detail, detail: detailObject).edgesIgnoringSafeArea(.all)
            
            
          //  Detail(detail: detailObject, animation: animation)
        } else if DetailProgram {
            ProgramDesc(Detail : self.$DetailProgram).edgesIgnoringSafeArea(.all)
        } else if ProfileDetail{
            ViewOrgProfile(ProfileDetail : $ProfileDetail, SelectedOrg: SelecetedOrg, Detail : $Detail, AllPrograms: $AllPrograms, ChildrenProfiles: ChildrenProfile).edgesIgnoringSafeArea(.all)
        }
    }
    
}

struct Detail: View {
    // Getting Current Selected Item...
    @ObservedObject var detail : DetailViewModel
    var animation: Namespace.ID
    
    @State var scale : CGFloat = 1
    
    var body: some View {

        ScrollView{
            
            VStack{
                
                // Updated Code For Avoiding Top Scroll
                GeometryReader{reader in
                    
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        
                        
                        
                    }
                        .offset(y: (reader.frame(in: .global).minY > 0 && scale == 1) ? -reader.frame(in: .global).minY : 0)
                    // Gesture For Closing Detail View....
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                
               
        }
        .scaleEffect(scale)
        .ignoresSafeArea(.all, edges: .top)
    }
    }
}

// DetailViewModel

import SwiftUI

class DetailViewModel: ObservableObject {

    @Published var selectedItem = TodayItem(title: "", category: "", overlay: "", contentImage: "", logo: "")
    
    @Published var show = false
}

// Today Item

import SwiftUI

// Model And Model Data...

struct TodayItem: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var category: String
    var overlay: String
    var contentImage: String
    var logo: String
}

var items = [

    TodayItem(title: "Forza Street", category: "Ultimate Street Racing Game", overlay: "GAME OF THE DAY", contentImage: "b1", logo: "l1"),
    
    TodayItem(title: "Roblox", category: "Adventure", overlay: "Li Nas X Performs In Roblox", contentImage: "b2", logo: "l2")
]


