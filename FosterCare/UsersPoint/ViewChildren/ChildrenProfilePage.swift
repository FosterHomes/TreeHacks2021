//
//  ChildrenProfilePage.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct ChildrenProfilesUser : View {

   
    var childrenStruct : ChildProfileStruct
    @Binding var columns : [GridItem]
    @Namespace var namespace
    
    
    var body: some View{
        
//2crPILBBFwNBxlOW210R
        VStack{
            
         
                
                // Row View....
                
                // adding animation...
                
                HStack(spacing: 15){
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        
                        WebImage(url: URL(string: childrenStruct.ImageUrl))
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width - 45) / 2,height: 175)
                            .cornerRadius(15)
                    }
                    .matchedGeometryEffect(id: "image", in: self.namespace)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        
                        HStack(spacing: 10){
                            
                            
                            // displaying only posted user...
                            
                        
                                Spacer()
                                Menu(content: {
                                    
                                    Button(action: {}) {
                                        
                                        Text("Edit")
                                    }
                                    
                                    Button(action: {
                                        PostToFirebase().DeletChildProfile(childrenStruct)
                                    }) {
                                        
                                        Text("Delete Profile")
                                    }
                                    
                                }, label: {
                                    
                                    Image(systemName: "pencil.circle.fill")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.black)
                                })
                            }
                        
                        Text(childrenStruct.name)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "title", in: self.namespace)
                        
                        // Rating Bar...
                        
                        Text(childrenStruct.Desc).lineLimit(4)
                        
                    }
                }
                .padding(.trailing)
                .background(Color.white)
                .cornerRadius(15)
            
        }
    }
}


struct Game : Identifiable {
    
    var id : Int
    var name : String
    var image : String
    var rating : Int
}

var datas = [

    Game(id: 0, name: "Riley", image: "p7", rating: 3),
    Game(id: 1, name: "Amunique", image: "p7", rating: 5),
    Game(id: 2, name: "Monica", image: "p6", rating: 3),
    Game(id: 3, name: "Katrina", image: "p5", rating: 2),
    Game(id: 4, name: "James Blunt", image: "p7", rating: 1),
    Game(id: 5, name: "The Evil Within 2", image: "p7", rating: 2),
    Game(id: 6, name: "Tomb Raider 2014", image: "p7", rating: 4),
    Game(id: 7, name: "Shadow Of The Tomb Raider", image: "p5", rating: 4),

]
