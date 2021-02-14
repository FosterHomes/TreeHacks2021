//
//  UsersEventType.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021..
//

import SwiftUI

struct UsersEventType: View {
    
    @EnvironmentObject var detail : DetailViewModel
    var body: some View {
        VStack {
        ForEach (1...5, id : \.self) { i in
           
              
                HStack(spacing : 15) {
                    VStack {
                        Headings(Heading: "March 25th")
                        Text("Pre-requisites Required -- Kidsave’s NEW VIRTUAL Weekend Miracles Host Training is a four-part series, February 3, 10, 17, 24 totaling 12 hours. All four segments must be completed to fulfill host training requirements. Each segment is three hours. Host Training takes place via an online webinar and is facilitated by trainer Lori Switanowski, LMFT, who will provide you with insight on trauma youth have endured and the tools necessary to help them succeed.").lineLimit(5)
                        
                        Headings(Heading: "Find Out more>").foregroundColor(Color.blue)
                    }
                    Image("p7").resizable().frame(width: 140, height : 175).cornerRadius(7)
                }.padding(20)
                
            
            }
            
        }.background(Color.white).cornerRadius(15)
        .padding(15)
        .cornerRadius(15)
        
    }
}

struct UsersEventType_Previews: PreviewProvider {
    static var previews: some View {
        UsersEventType()
    }
}
