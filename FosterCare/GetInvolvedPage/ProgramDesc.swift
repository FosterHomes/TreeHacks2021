//
//  ProgramDesc.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProgramDesc: View {
    
    
    @Binding var Detail : Bool
    
    var NameOfEvent: String = ShowEvent ? SelectedFosterEvent.Title : SelectedProgram.name
    var Desc : String = ShowEvent ? SelectedFosterEvent.Desc : SelectedProgram.Desc
    var Imagelink : String = ShowEvent ? SelectedFosterEvent.ImageUrl : SelectedProgram.ImageUrl
    @State var WebsiteLink : String = ShowEvent ? SelectedFosterEvent.Venue : SelectedProgram.SiteUrl
    
    var body: some View {
        ScrollView {
            ZStack {
                
                
                VStack {
                    if ShowEvent == true && SelectedFosterEvent.ImageUrl !=  "" {
                        WebImage(url: URL(string: Imagelink)).resizable().frame(width: UIScreen.main.bounds.width + 40, height: UIScreen.main.bounds.height/3)
                    } else if ShowEvent == false && SelectedProgram.ImageUrl != ""  {
                        WebImage(url: URL(string: SelectedProgram.ImageUrl) ).resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                    } else {
                        Text("").padding(100)
                    }
                    VStack {
                        Section(header: Text(NameOfEvent)
                                    .font(.title)
                                    .fontWeight(.bold)) {
                            
                            Text(Desc)
                        }.padding(12)
                        Spacer()
                        WebsiteConnect(NameOfEvent: NameOfEvent , Website: $WebsiteLink)
                        Spacer()
                    }.padding(20)
                }
                Xmark(Detail: $Detail)
                
            }
        }.ignoresSafeArea(.all, edges: .all)
        .background(Color.white.ignoresSafeArea(.all, edges: .all))
    }
}

struct Xmark : View {
    @Binding var Detail: Bool
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
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
                }.padding(20)
            }.padding(40)
            Spacer()
        }
    }
}
