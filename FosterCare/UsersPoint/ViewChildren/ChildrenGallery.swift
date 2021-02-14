//
//  ChildrenGallery.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct ChildrenGallery: View {
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 40), count: 2)
    @Binding var Detail : Bool
    @Binding var OrgProfile : Bool
    var ChildrenProfiles: [ChildProfileStruct]
    var body: some View {
        
        
        //        LazyVGrid(columns: self.columns,spacing: 50){
        VStack  {
            
            VStack{
                HStack {
                    Text("Meet the Kids")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        
                        // reducing to row.....
                        
                        withAnimation(.easeOut){
                            
                            if self.columns.count == 2{
                                
                                self.columns.removeLast()
                            }
                            else{
                                
                                self.columns.append(GridItem(.flexible(), spacing: 15))
                            }
                        }
                        
                    } label: {
                        
                        Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }.padding(.horizontal,30)
                TopHomePage(DetailsTapped: $Detail, KidsStruct: ChildrenProfiles)  
                
                
                
                
                
                
            }
            Divider().padding(.horizontal,40)
            ForEach(0..<ChildrenProfiles.count){game in
                
                // GridView....
                VStack {
                    
                    if self.columns.count == 2 {
                        if (game < ChildrenProfiles.count) {
                            GalleryPic(Detail: self.$Detail, OrgProfile: self.$OrgProfile, ChildProfile: self.ChildrenProfiles[game]).padding(10).shadow(radius: 7)
                        }
                    }
                    else {
                        if (game < ChildrenProfiles.count) {
                        GalleriesAllToOne(game: game, ChildrenProfiles: self.ChildrenProfiles , Detail: $Detail).padding(10)
                        }
                        
                        
                        
                    }
                }
                
            }
        }.background(Color.white)
        //   }
        
    }
}
struct GalleriesAllToOne : View {
    
    var game : Int
    var ChildrenProfiles: [ChildProfileStruct]
    @Binding var Detail : Bool
    var body: some View {
        
        
        
        HStack {
            if (game % 3 == 0) {
                ForEach(game..<game+3) { i in
                    VStack {
                        if i < self.ChildrenProfiles.count {
                            WebImage(url: URL(string: self.ChildrenProfiles[i].ImageUrl)).resizable().frame(width: UIScreen.main.bounds.width/3-10 , height: UIScreen.main.bounds.width/3-10).aspectRatio(contentMode: .fit).background(Color("Color2"))
                            
                            //.cornerRadius(20).padding(6).shadow(radius: 12).background(Color.white).cornerRadius(20).padding(3).shadow(radius: 4)
                            //  Text("Age: 8").font(.body).foregroundColor(Color.black)
                            // Text("Emily of Age 8").font(.body).foregroundColor(Color.black)
                        }
                    }.onTapGesture {
                        withAnimation(.spring()){
                            // detail.show.toggle()
                            ChildSelected = ChildrenProfiles[i]
                            self.Detail.toggle()
                            
                        }                             }
                    
                    
                    
                    
                    
                }
                
            }
        }
        
    }
}


struct GalleryPic: View  {
    @Binding var Detail : Bool
    @Binding var OrgProfile: Bool
    var ChildProfile : ChildProfileStruct
    
    var body: some View {
        
        VStack(spacing: 15){
            HStack {
                WebImage(url : URL(string : "\(ChildProfile.ImageUrl)")).resizable()
                    
                    .cornerRadius(15).frame(width: UIScreen.main.bounds.width / 2.8 , height: UIScreen.main.bounds.width / 2.8)
                //                Image("p7")
                
                
                
                VStack {
                    HStack {
                        Text("Name: \(ChildProfile.name)").fontWeight(.bold).foregroundColor(Color.black).font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text("Age: \(ChildProfile.age)").font(.body).foregroundColor(Color.black)
                        Spacer()
                    }
                    
                    
                    
                    //                if (Int.random(in: 1...6) % 2 == 0 ) {
                    Text("'\(ChildProfile.Desc)'").font(.body).foregroundColor(.gray).lineLimit(3)
                    //                }
                    
                    
                    //
                }
            }
            
            HStack {
                Button(action: {
                    withAnimation(.spring()){
                        // detail.show.toggle()
                        SelecetedOrg = ChildProfile.FosterOrg
                        self.OrgProfile.toggle()
                    }
                    
                    
                }) {
                    Text(ChildProfile.FosterOrg.name).fontWeight(.bold).frame(width: UIScreen.main.bounds.width/3)
                        .foregroundColor(.white)
                        
                        .padding(12)
                        .background(Color("Color3")).cornerRadius(12)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }.shadow(color: Color("Color3"), radius: 4)
                Spacer()
                Button(action: {
                    withAnimation(.spring()){
                        //  tabData.selectedItem = item
                        //tabData.isDetail.toggle()
                        //  self.Selected.ChildSelected = ChildProfile
                        ChildSelected = ChildProfile
                        self.Detail.toggle()
                    }
                    
                }) {
                    Text("View Profile").fontWeight(.bold).frame(width: UIScreen.main.bounds.width/3)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color("Color2")).cornerRadius(12)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }.shadow(color: Color("Color2"), radius: 7)
            }
        }.background(Color.white).cornerRadius(12).padding(5).cornerRadius(12).shadow(radius: 2)
    }
    
    
    
    
}
