//
//  FamilyPage.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI
var FamilyInfoSelected = FamilyUser()
struct FamilyPage: View {
    @Binding var Detail: Bool
    @Namespace var animation
    @State var UserInfo = UserBasedFirebase().UserInfo
     
    var body: some View {
        
        ZStack {
           
            VStack {
                Image("p8").resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                
                Section(header: Text(FamilyInfoSelected.UserName)
                            .font(.title)
                            .fontWeight(.bold)) {
                    
                    HStack {
                        Text("Child inquired for ")
                        Spacer()
                        Text(FamilyInfoSelected.ChildRequestedFor)
                    }
                    HStack {
                        Text("Had Foster Training")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill").foregroundColor(Color.green).font(.system(size: 28))
                    }
                    HStack {
                        Text("Had Fostered before/Currently")
                        Spacer()
                        Image(systemName: "cross.circle.fill").rotationEffect(.degrees(45)).foregroundColor(Color.red).font(.system(size: 28))
                    }
                    
                    Text(FamilyInfoSelected.Desc)
                    HStack {
                        Text("Contact: ")
                        Spacer()
                        Text(FamilyInfoSelected.email)
                    }
                    
                }.padding(12)
                Spacer()
            }.ignoresSafeArea(.all, edges: .top)
            .background(Color.white.ignoresSafeArea(.all, edges: .all))
            VStack {
                HStack{
                    
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        withAnimation(.spring()){
                            //$detailObject.detail.toggle
                            withAnimation(.spring()){
                                // detail.show.toggle()
                                self.Detail.toggle()
                            }
                            
                        }
                    }) {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black.opacity(0.7))
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .clipShape(Circle())
                    }
                }.padding(7)
                
                Spacer()
            }
             
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).matchedGeometryEffect(id: "content", in: animation)
    }
    
}
