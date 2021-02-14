//
//  WebsiteConnect.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI
import SafariServices
struct WebsiteConnect: View {
    @State var show = false
    // var PageName: String
    // var Website: String;
    var NameOfEvent : String
    @Binding var Website: String
    var body: some View {
        
        Button(action: {
            self.show.toggle()
        }) {
            Text("\(NameOfEvent)").foregroundColor(Color.blue).padding().frame(width: 300).shadow(radius: 20)
        }.background(Color.yellow).cornerRadius(12).padding(20).sheet(isPresented: $show) {
            Safari(Website: self.Website)
        }
        
    }
}


struct Safari : UIViewControllerRepresentable {
    var Website: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Safari>) ->  SFSafariViewController {
        
        
        let controler = SFSafariViewController(url:  URL(string: Website) ?? URL(string: "https://www.kidsave.org/")!)
        return controler
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<Safari>) {
        
    }
}
