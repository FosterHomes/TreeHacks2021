//
//  ChildProfile.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import SwiftUI

struct ChildProfile: View {
    var animation: Namespace.ID
    @EnvironmentObject var detail : DetailViewModel
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @Binding var Children: [ChildProfileStruct]
    
    var body: some View {
        
       // LazyVGrid(columns: self.columns,spacing: 25){
        VStack {
            ForEach(0..<Children.count , id : \.self){ index in
                ChildrenProfilesUser(childrenStruct: Children[index], columns: $columns).cornerRadius(15).shadow(radius: 12)
            }
       // }
        .padding([.horizontal,.top])
        
        }.background(Color.white)
    }
}






