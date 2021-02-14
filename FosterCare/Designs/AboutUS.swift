//
//  AboutUS.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import SwiftUI

struct AboutUS: View {
    @State var Link = ""
      var OrgProfile : FosterCare
    var body: some View {
    
        VStack {
            HStack {
            Text(OrgProfile.name)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            }
            Text("Based in \(OrgProfile.Location)")
            Text(OrgProfile.Desc)
           
            VStack {
            Text("Contact us Today!")
                Text("kidSaveInquiry@hotmail.com")
                //Text(OrgProfile.Contact[0])
                //Text(OrgProfile.Contact[1])
             
            }
            
            //Websites(WebsiteLink: Link)
            
            
        }.padding(20)
    }
}
 
