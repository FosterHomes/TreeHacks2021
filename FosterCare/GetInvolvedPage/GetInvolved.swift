//
//  GetInvolved.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProgramsView: View {
    
    @State var index = 0
    @Binding var Detail: Bool
    @Binding var AllPrograms : [Programs]
     
    
    var body: some View {
        
        VStack {
             
          
                HStack {
                    Text("Get Involved")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal, 40)
                
            //ForEach(ConnectData().keys.sorted(), id: \.self) { key in
             //   TabView(selection: self.$index){
                    ForEach(0..<AllPrograms.count, id: \.self) { index in
                      //  if index < AllPrograms.count  {
                        VStack {
                        GetInvolved(IFOrg: false, Detail: $Detail, Program: self.AllPrograms[index])
                            .frame(height: self.index == index ?  280 : 130)
                            .tag(index+1)
                        //            }
                   // }
                                
                        }
//                    ForEach(0..<AllPrograms.count){index in
//
//                        GetInvolved(IFOrg: false, Detail: $Detail, Program: self.AllPrograms[index])
//                            .frame(height: self.index == index ?  280 : 130)
//                            .tag(index)
//
//                    }
                    }
            //
        //}
                .frame(height: 230)
                .padding(.top,25)
                .tabViewStyle(PageTabViewStyle())
                .animation(.easeOut)
                Divider().padding(20)
            
                
            
            
        }
           
        
    }
    
    func ConnectData() -> [String : [Programs]]  {
        var Maps = [String : [Programs]]()
        
        for i in self.AllPrograms {
           
            if (i.OrgName != "") {
            if Maps.keys.contains("") {
                var S = Maps[i.OrgName]
                S!.append(i)
                Maps[i.OrgName] = S
            } else {
                Maps[i.OrgName] = [i]
            }
            }
         //
        }
        print(Maps)
        return Maps
         
        
        
    }
    
}


struct GetInvolved: View {
    @State private var IsExpanded = true;
    var IFOrg : Bool
    @State var WebsiteShown = "https://www.kidsave.org/donate/"
    @State var isSmall = UIScreen.main.bounds.height < 750
    @Binding var Detail : Bool
    
    var Program : Programs
    
    var body: some View {
        
        HStack(spacing: 10){
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("\(Program.name)")
                    .font(isSmall ? .title2 : .title)
                    .fontWeight(.heavy).lineLimit(3)
                    .foregroundColor(.white).lineLimit(3)
                    
                
                
                HStack {
                    Spacer()
                    
                    Text(Program.Desc).foregroundColor(.white).font(.body).lineLimit(3)
                    Button(action: {
                        
                        withAnimation(.spring()){
                            //  tabData.selectedItem = item
                            //tabData.isDetail.toggle()
                            ShowEvent = false
                            SelectedProgram = Program
                            self.Detail.toggle()
                            
                        }
                        
                    }) {
                        
                        Text("View more")
                            .fontWeight(.light)
                            .foregroundColor(Color.blue)
                            .padding(.vertical , 12)
                            .padding(.horizontal,12)
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                    .padding(isSmall ? 10 : 15)
                }
            }
            .padding(.leading,10)
            .offset(y: 27)
            
            Spacer(minLength: 0)
            
            //               Image("p7")
            //                   .resizable()
            //                   .aspectRatio(contentMode: .fit)
            //                  // .matchedGeometryEffect(id: "p7", in: animation)
            //                   .frame(height: UIScreen.main.bounds.height / 3)
        }.padding(.vertical , 50)
        .padding()
        .background(
            ZStack {
                Color.blue.cornerRadius(15)
                
                
                WebImage(url: URL(string: Program.ImageUrl)) .resizable().opacity(0.6).cornerRadius(15)
                
            }.padding(20)
            // for identifying current index....
            
            
        ).padding(12).cornerRadius(15)
    }
}
