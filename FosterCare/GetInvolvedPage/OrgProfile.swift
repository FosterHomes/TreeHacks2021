//
//  OrgProfile.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct OrgProgramsProfile: View {
    @Binding var AllPrograms : [Programs]
    var body: some View {
        
        
        VStack(spacing: 15) {
            ForEach(0..<AllPrograms.count) {i in
                if (AllPrograms[i].ImageUrl != "") {
                 
                    VStack(spacing: 15) {
                        
                        HStack {
                            
                            
                            // displaying only posted user...
                            
                            
                            Spacer()
                            Menu(content: {
                                
                                Button(action: {}) {
                                    
                                    Text("Edit")
                                }
                                
                                Button(action: {
                                    //    PostToFirebase().DeletChildProfile(childrenStruct)
                                }) {
                                    
                                    Text("Delete Program")
                                }
                                
                            }, label: {
                                
                                Image(systemName: "pencil.circle.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.black)
                            })
                        }
                        
                        Text(AllPrograms[i].name)
                        WebImage(url: URL(string: AllPrograms[i].ImageUrl)).resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 250)
                            .cornerRadius(15)
                        Text(AllPrograms[i].Desc).padding(5).lineLimit(4)
                       
                        
                    }.padding()
                        .background(Color.white)
                    .cornerRadius(15).shadow(radius: 12)
                  
                
               
                
            }
            }
        
        
        
        
        }
}
}

