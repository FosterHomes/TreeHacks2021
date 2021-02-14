//
//  NewReference.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct NewReference: View {
    @State var Name: String = ""
    @State var Desc : String = ""
    @State var Reference: String = ""
    @State var ImageReference : String = ""
    @State var FosterPrograms = Programs()
    @State var show = false
    var body: some View {
        
        ZStack {
        VStack {
            TextSide(Texts: "Reference Description").padding()
            TextField("Reference Name", text: $Name)
                //Style your Text Field
                .padding()
                .background(lightGreyColor)
                .cornerRadius(8)
                .padding().frame(width : UIScreen.main.bounds.width / 1.01)
            MultiTextField(Text: $Desc).padding().background(lightGreyColor).cornerRadius(10).frame(width : UIScreen.main.bounds.width / 1.08 , height: UIScreen.main.bounds.height / 2)
            TextField("Reference Website", text: $Reference)
                //Style your Text Field
                .padding()
                .background(lightGreyColor)
                .cornerRadius(8)
                .padding().frame(width : UIScreen.main.bounds.width / 1.01)
            
            Button(action: {
                
                //self.PostProgram()
                self.show.toggle()
            }) {
                Text("Add New Reference").fontWeight(.bold).frame(width: UIScreen.main.bounds.width/1.7)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .padding(.horizontal,30)
                    .background(Color.yellow).cornerRadius(12)
                    .frame(width: UIScreen.main.bounds.width)
            }
            Text("")
        }.background(Color.white).frame(height : UIScreen.main.bounds.height).onTapGesture {
            self.hideKeyboard()
        }
            
            VStack{
                
                Spacer()
                
                RadioButtons(show: self.$show).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func PostProgram() {
        self.FosterPrograms.name = Name
        self.FosterPrograms.Desc = Desc
        self.FosterPrograms.OrgId = OrgIdFb
        self.FosterPrograms.ImageUrl = ""
        self.FosterPrograms.SiteUrl = Reference
        self.FosterPrograms.RegIsers = [String]()
        self.FosterPrograms.type = "type"
        
        
        self.Name = ""
        self.Desc = ""
        self.Reference = ""
        PostToFirebase().PostNewProgram(FosterPrograms)
        
      //  FirebaseFoster(OrgUser: <#Bool#>).PostNewProgram(FosterPrograms)
  
    }
}

struct NewReference_Previews: PreviewProvider {
    static var previews: some View {
        NewReference()
    }
}
