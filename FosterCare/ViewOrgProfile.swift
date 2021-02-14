//
//  ViewOrgProfile.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 11/02/2021.
//

import SwiftUI
var MainTabs = [ "Programs " , "About Us"   , "Galleries"]

import SDWebImageSwiftUI
struct ViewOrgProfile: View {
    @State var CurrentTab = "Programs"
    @Binding var ProfileDetail : Bool
     var SelectedOrg : FosterCare
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 40), count: 2)
    @Binding var Detail : Bool
    @State var Reload = false;
    
    @Binding var AllPrograms : [Programs]
     
    
    @State var AboutUs : Bool = false
   
    
   var ChildrenProfiles: [ChildProfileStruct]
    
    var body: some View {
        
        ZStack {
            VStack {
                WebImage(url: URL(string: ImageID) ).resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                
                HStack(spacing: 0){
                    Spacer()
                    ForEach(MainTabs,id: \.self){ tab in
                        
                        Button(action: {
                                self.CurrentTab = tab
                            self.Reload.toggle()
                          
                            self.AboutUs = false
                            if ("About Us" == self.CurrentTab) {
                                self.AboutUs = true
                            }
                             
                             
                            
                            
                            print("selected \(self.CurrentTab)")
                        }) {
                            
                            Text(tab)
                                .fontWeight(.bold)
                                .foregroundColor(self.CurrentTab == tab ? .black : .gray)
                        }
                        
                        if tab != tabs.last {
                            Spacer(minLength: 0)
                        }
                    }
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack {
                        if (self.CurrentTab == "Galleries") {
                            
                            ForEach(0..<ChildrenProfiles.count){game in
                                GalleriesAllToOne(game: game, ChildrenProfiles: self.ChildrenProfiles , Detail: $Detail).padding(10)
                                
                                
                            }
                        }
                        if AboutUs   {
                            AboutUS(OrgProfile: SelectedOrg)
                            
                        }
                        else {
                            ProgramsView(Detail: $Detail, AllPrograms: $AllPrograms)
                        }
                        
                        
                    }
                }
                Spacer()
                
                
                
            }
            
            VStack {
                HStack{
                    
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        withAnimation(.spring()){
                            //$detailObject.detail.toggle
                            withAnimation(.spring()){
                                // detail.show.toggle()
                                self.ProfileDetail.toggle()
                            }
                            
                        }
                    }) {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black.opacity(0.7))
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 2)
                // since we ignored top area...
                .padding(.top,UIApplication.shared.windows.first!.safeAreaInsets.top + 10)
                Spacer()
            }.padding(.horizontal,12)
            
        }.ignoresSafeArea(.all, edges: .all)
        .background(Color.white.ignoresSafeArea(.all, edges: .all))
    }
}


var ImageID  = "data:image/png;base64,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"
