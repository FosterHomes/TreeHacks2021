//
//  ViewEvents.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 07/02/2021.
//

import SwiftUI

struct ViewEvents: View {
    var body: some View {
        HStack {
        Text("Events").font(.title).fontWeight(.bold)
        Spacer()
        }
        UsersEventType()
        
    }
}

struct ViewEvents_Previews: PreviewProvider {
    static var previews: some View {
        ViewEvents()
    }
}
