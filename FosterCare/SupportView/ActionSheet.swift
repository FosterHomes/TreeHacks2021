//
//  ActionSheet.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

var FosterEventCreated = FosterEvents(Title: "", Venue: "", Location: "", Desc: "", EventDate: "", ImageUrl: "", DocumentID: "", OrgID: "", Registered: false, RegisteredUsers: [String]())
struct RadioButtons : View {
      
      
      @Binding var show : Bool
        
      var body : some View  {
          
          VStack {
            VStack {
            Text(FosterEventCreated.Title).font(.title).fontWeight(.bold)
                Text("")
            Text(FosterEventCreated.Desc).font(.title2).foregroundColor(Color.white)
                Text("")
            Text("Event Link : \(FosterEventCreated.Venue)").font(.title2).foregroundColor(Color.white)
            }.padding(20)
              VStack{
                  
                   
                  
                  
                       
                Text("A new Event has been Created Successfully").font(.title2).foregroundColor(Color.white).padding(20)
                       
                   
                   
                Button(action: {
                    
                   self.show.toggle()
                   
                }) {
                    
                    Text("Done").fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .padding(.vertical)
                        .padding(.horizontal,30)
                        .background(Color.white)
                    
                }.padding(40).cornerRadius(12)
                 
                  
                  
              }
              
          }
          .padding(.bottom , 150)
          .frame(width: UIScreen.main.bounds.width)
          .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 45)
          .background(Color.yellow)
          .cornerRadius(30).shadow(radius: 45)
           
      }
  }
  
   
   
