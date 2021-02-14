//
//  DebugType.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct DebugType: View {
    @Binding var Clicked : Bool
    @Binding var ShowUser : Bool
    var body: some View {
        VStack {
            
            Text("*Test Mode Only*").font(.title).fontWeight(.bold)
            
         
            
            Button(action: {
                self.Clicked.toggle()
                self.ShowUser = false;
            }, label: {
                Text("User")
                    .font(.title)
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
            })
            .background(
                Capsule()
                    .fill(Color("Color2"))
            )
            Text(" Or ").font(.title2).fontWeight(.bold)
            Button(action: {
                self.Clicked.toggle()
                self.ShowUser = true
            }, label: {
                Text("Foster Care")
                    .font(.title)
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
            })
            .background(
                Capsule()
                    .fill(Color("Fav"))
            )
            
        }.background(Color.white).edgesIgnoringSafeArea(.all
        )
    }
}

 
