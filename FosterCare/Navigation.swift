//
//  Navigation.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 06/02/2021.
//

import SwiftUI

struct Navigation: View {
   
    
    @Binding var FosterOrgEvents: EventAndOrg
    @Binding var ChildrenProfile : [ChildProfileStruct]
    @Binding var AllPrograms : [Programs]
    @Binding var ChildrenRequests: [FamilyUser]
    
    
    
    var body: some View {
        Nav(IfOrg: true, FosterOrgEvents: $FosterOrgEvents, ChildrenProfile: $ChildrenProfile, AllPrograms: $AllPrograms, Requests: $ChildrenRequests )
    }
}

 

struct Nav : View {
    
    @State var index = 0
    @State var show = false
    @State var OtherClicked : Bool = false;
    @State var ViewProgram : Bool = false
   
    var IfOrg : Bool
    @Binding var FosterOrgEvents: EventAndOrg
    @Binding var ChildrenProfile : [ChildProfileStruct]
    @Binding var AllPrograms : [Programs]
    @Binding var Requests : [FamilyUser]
    @State var ViewRegistered = false
    var body: some View {
        
        ZStack{
            
            // Menu...
            
            HStack{
                
                VStack(alignment: .leading, spacing: 12) {
                    
                   
                    
                    Text("Kid")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Text("Save")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        
                        self.index = 0
                        
                        // animating Views...
                        
                        // Each Time Tab Is Clicked Menu Will be Closed...
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                          
                            
                            Text("Main")
                                .foregroundColor(self.index == 0 ? Color("Fav") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color.black.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    .padding(.top,25)
                    
                    Button(action: {
                        
                        self.index = 1
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                          
                            
                            
                            Text("Add Event")
                            .foregroundColor(self.index == 1 ? Color("Fav") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color.black.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 2
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            
                            Text("Add New Program")
                            .foregroundColor(self.index == 2 ? Color("Fav") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 2 ? Color.black.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 3
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            Text("Inquiries")
                            .foregroundColor(self.index == 3 ? Color("Fav") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color.black.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 4
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            Text("Connect")
                            .foregroundColor(self.index == 3 ? Color("Fav") : Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color.black.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                    }
                    
                    
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical,30)
                    
                    Button(action: {

                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image("out")
                                .foregroundColor(Color.white)

                            
                            Text("Sign Out")
                            .foregroundColor(Color.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,25)
                .padding(.horizontal,20)
                
                Spacer(minLength: 0)
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            // MainView...
            
            NavSupportView(index: $index, show: $show, OtherClicked: $OtherClicked, ViewProgram: $ViewProgram, ChildrenProfiles: $ChildrenProfile, FosterEvents: $FosterOrgEvents, AllPrograms: $AllPrograms, ChildrenRequests: $Requests, ViewRegistered: self.$ViewRegistered)
            
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

// Mainpage View...



// All Other Views...

struct NavSupportView : View {
    
    @Binding var index : Int
    @Binding var show : Bool
    @Binding var OtherClicked : Bool
    @Binding var ViewProgram : Bool
    
    @Binding var ChildrenProfiles : [ChildProfileStruct]
    @Binding var FosterEvents : EventAndOrg
    @Binding var AllPrograms: [Programs]
    @Binding var ChildrenRequests : [FamilyUser]
    
    @Binding var ViewRegistered: Bool
    var body: some View {
        
        
        VStack(spacing: 20){
            
            GeometryReader{_ in
                
                VStack{
                    
                    // Changing Views Based On Index...
                    MainHome(show: $show, Index: $index, ProfileDetail: $ViewProgram, FosterOrgEvents: $FosterEvents, Children: $ChildrenProfiles, ChildrenRequests: $ChildrenRequests, AllPrograms: $AllPrograms, IfOrg: true, ViewRegistered: self.$ViewRegistered).background(Color.white)
                   
                    
                }
            }
        }
        .background(Color.white)
        //Applying Corner Radius...
        .cornerRadius(self.show ? 30 : 0)
        // Shrinking And Moving View Right Side When Menu Button Is Clicked...
        .scaleEffect(self.show ? 0.9 : 1)
        .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
        // Rotating Slighlty...
        .rotationEffect(.init(degrees: self.show ? -5 : 0))
        
    }
    
}
           
        

struct Orderss : View {
    
    var body: some View{
        
        VStack{
            
            Text("Your Orders")
        }
    }
}

struct Favourites : View {
    
    var body: some View{
        
        VStack{
            
            Text("Favourites")
        }
    }
}
