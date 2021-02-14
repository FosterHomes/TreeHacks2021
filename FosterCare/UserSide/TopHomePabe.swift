//
//  TopHomePabe.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct TopHomePage: View {
    var Pics = ["p6" , "p7" , "p5" , "p7" , "p6" , "p7"]
    @State var selected : Int = 0
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    @Binding var DetailsTapped : Bool
    @State var Reload : Bool = false
    var KidsStruct: [ChildProfileStruct]
    var body: some View {
        VStack(spacing : 0) {
            TabView(selection: $selected){
                
                // Images...
                ForEach(0..<6,id: \.self){  index in
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                        
                        // Geometry Reader For Parallax Effect...
                        
                        GeometryReader{reader in
                            
                            if index < KidsStruct.count {
                            WebImage(url: URL(string: KidsStruct[index].ImageUrl))
                          //  Image(Pics[index])
                                .resizable()
                                
                                .aspectRatio(contentMode: .fill)
                                
                                // moving view in opposite side
                                // when user starts to swipe...
                                // this will create parallax Effect...
                                .offset(x: -reader.frame(in: .global).minX)
                                .frame(width: width ,height: height / 4).onTapGesture {
                                    
                                    withAnimation(.spring()){
                                        ChildSelected = KidsStruct[index]
                                        self.DetailsTapped.toggle()
                                    }
                                }
                            }
                            
                            
                        }
                        .frame(height: height / 4)
                        .cornerRadius(15)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(15)
                        // shadow...
                         
                        .shadow(color: Color("Color2"), radius: 3, x: 5, y: 5)
                        .shadow(color: Color("Color2"), radius: 3, x: -5, y: -5)
                        // decreasing width by padding...
                        // so outer view only decreased..
                        // inner image will be full width....
                        
                        // Bottom Image...
                        if index < KidsStruct.count {
                        WebImage(url: URL(string: KidsStruct[index].ImageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .padding(5)
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(x: -15, y: 25)
                        }
                    })
                    .padding(.horizontal,15)
                    
                }
            }.padding(.horizontal,8)
            // page Tab View...
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .frame(width: width/1.09  , height: height / 3)
    }
    
}




