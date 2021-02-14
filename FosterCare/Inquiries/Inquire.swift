//
//  Inquire.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct Inquire : View {
    @State var Inquired: Bool = false;
    
    @Binding var ChildrenRequests : [FamilyUser]
    @Binding var EventsRegistered: [FosterEvents]
    var body: some View {
        ZStack {
            
            VStack {
                VStack {
                    HStack {
                        Text("Children's Inquiries")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(.horizontal, 40)
                VStack {
                    ForEach (0..<ChildrenRequests.count, id : \.self) { i in
                        
                        InquireChat(UsersRequested: ChildrenRequests[i], ChildName: ChildrenRequests[i].RequestedChild , Inquired: self.$Inquired)
                        if (i != ChildrenRequests.count-1){
                            Divider()
                        }
                    }
                    
                }.padding(20).background(Color.white).cornerRadius(12).shadow(radius: 12).padding()
                Divider()
                    HStack {
                        Text("Number of Registrants")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(.horizontal, 40)
                
                    VStack {
                ForEach (0..<EventsRegistered.count, id : \.self) { i in
                    if EventsRegistered[i].RegisteredUsers.count != 0 {
                        HStack {
                            Text("\(EventsRegistered[i].Title)")
                            Spacer()
                            Text("\(EventsRegistered[i].RegisteredUsers.count)").fontWeight(.bold).foregroundColor(Color.white).padding(20).background(
                                Circle()
                                    .fill(Color("Fav"))
                            )
                        }
                        .padding(5)
                        .background(Color.white).padding(.horizontal,10)
                        Divider().padding(20)
                    }
                }
                    }.padding(20).background(Color.white).cornerRadius(12).shadow(radius: 12).padding()
                //
                }
                
                
            }.opacity(self.Inquired ? 0 : 1)
            
            VStack {
                if Inquired {
                    FamilyPage(Detail: $Inquired).edgesIgnoringSafeArea(.all)
                }
            }
        }
        
        
    }
}

struct InquireChat: View {
    
    var UsersRequested : FamilyUser
    var ChildName : String
    @Binding var Inquired: Bool
    var body : some View {
        HStack {
            VStack {
                HStack {
                Text("\(UsersRequested.UserName)").font(.title2).fontWeight(.light)
                 Spacer()
                }
                HStack {
                Text("Inquiry on: \(ChildName)")
                    .font(.title3).fontWeight(.light).foregroundColor(.gray)
                    Spacer()
                }
                
            }
            Spacer()
            
            Button(action: {
                FamilyInfoSelected = UsersRequested
                self.Inquired.toggle()
            }, label: {
                Text("View")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(14)
                    .padding(.horizontal,15)
            })
            .background(
                Capsule()
                    .fill(Color("Fav"))
            )
        }
        
    }
    
    
    
    
    
}






