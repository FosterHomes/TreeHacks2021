//
//  ViewProfiles.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021..
//

import SwiftUI
struct ViewProfiles: View {
    var body: some View {
        VStack {
            grid()
        }.background(Color.white)
    }
}

struct ViewProfiles_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfiles()
    }
}


struct grid: View {
    let items = 1...10

        let rows = [
            GridItem(.fixed(200)),
        ]

        var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(items, id: \.self) { item in
                        Image("p7")
                    }
                }
            }
        }
    }

