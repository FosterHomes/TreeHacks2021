//
//  StickyView.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.

import SwiftUI
import SDWebImageSwiftUI
struct Headings : View{
    var Heading: String
    var body: some View {
        HStack {
          
            Text(Heading).fontWeight(.bold)
            Spacer()
            
        }
    }
    
}

struct StickyView: View {
    
    @Binding var firstMinY: CGFloat
    @Binding var minY: CGFloat
    @Binding var lastMinY: CGFloat
    @Binding var scale: CGFloat
    
    var body: some View {
        
        
        GeometryReader{reader -> AnyView in
            
            // Eliminating The Header View Height From Image...
            
            let minY = self.firstMinY - reader.frame(in: .global).minY
            
            // Scaling View....
            // to avoid negatives....
            
            // your own value for scaling Effect...
            let progress = (minY > 0 ? minY : 0) / 200
            
            let scale = (1 - progress) * 1
            
            // Image Scaling....
            
            // Only 0.1 Scaling For Inner Image....
            let imageScale = (scale / 0.6) > 0.9 ? (scale / 0.6) : 0.9
            
            // Image Offset.....
            
            let imageOffset = imageScale > 0 ? (1 - imageScale) * 200 : 20
            DispatchQueue.main.async {
                if self.firstMinY == 0{
                    self.firstMinY = reader.frame(in: .global).minY
                }
                self.minY = minY
                
                // Getting Last MInY Value When The Scale Reached 0.4....
                
                if scale < 0.4 && lastMinY == 0{
                    
                    self.lastMinY = minY
                }
 
                
                self.scale = scale
            }
            
            return AnyView(
            
                WebImage(url: URL(string: ChildSelected.ImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getScreen().width, height: getScreen().height - firstMinY)
                    .cornerRadius(1)
                    .ignoresSafeArea()
                    .scaleEffect(scale < 0.6 ? imageScale : 1.1)
                    .offset(y: scale < 0.6 ? imageOffset : -5)
                    .overlay(
                    
                        ZStack{
                            
                            VStack{
                                
                                Text("Meet \(ChildSelected.name)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                
                                Text("Age 16")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .multilineTextAlignment(.center)
                                    .padding(.top,10).foregroundColor(Color.black)
                            }.padding().background(Color.white.opacity(0.8)).cornerRadius(15).padding(20)
                            .foregroundColor(.white)
                            .offset(y: 15)
                            // Hiding...
                            // Hiding Before scale 0.6....
                            .opacity(Double(scale - 0.7) / 0.3)
                            
                            // Showing Info Details...
                            
                        }
                    )
                    .background(
                    
                        ZStack{
                            
                            // Only SHowing After o.6...
                            if scale < 0.6 {
                                
                                // BG And Info Card...
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.6))
                                
                                VStack{
                                    
                                    HStack{
                                        
                                        Text("\(ChildSelected.name)")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        
                                        ForEach(1...3,id: \.self){_ in
                                            
                                            
                                            Circle()
                                                .fill(Color.gray)
                                                .frame(width: 15, height: 15)
                                        }
                                    }
                                    .padding()
                                    
                                    Spacer()
                                }
                            }
                        }
                    )
                    // Limiting....
                    .scaleEffect(scale > 0.6 ? scale : 0.6)
                    // Loginc to move view Up When It Reaches Button....
                    .offset(y: minY > 0 ? minY > lastMinY + 60 && lastMinY != 0 ? lastMinY + 60 : minY : 0)
                // Offset....
                    .offset(y: scale > 0.6 ? (scale - 1) * 200 : -80)
            )
        }
        .frame(width: getScreen().width, height: getScreen().height - firstMinY)
        .overlay(
        
            // Bottom Details...
            
            VStack{
                
                Text(ChildSelected.FosterOrg.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Button(action: {}, label: {
                    Text("View organization Profile")
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .padding(.vertical)
                        .padding(.horizontal,30)
                        .background(Color.white)
                })
                .padding(.top,10)
            }
            .padding(.bottom, 70)
            // Disabling Scroll...
            .offset(y: minY > 0 ? minY > lastMinY + 60 && lastMinY != 0 ? lastMinY + 60 : minY : 0)
            // thas all the logic when ever the scroll reached button it will eanble full scroll....
            ,
            alignment: .bottom
        )
    }
}
