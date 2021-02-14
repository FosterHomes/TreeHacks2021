//
//  ContentView.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//
// Buy education courses on udemy & other places and allow it on foster organisation
// Gallaries : https://www.kidsave.org/galleries/us-gallery/
import SwiftUI


struct DebugOnly: View {
    @Binding var ClickedUser : Bool;
    @ObservedObject var FirebaseEvents : FirebaseFoster
    
    var body: some View {
        if (ClickedUser ) {
           
            Navigation(FosterOrgEvents: self.$FirebaseEvents.FosterOrgEvents , ChildrenProfile : self.$FirebaseEvents.Galleries , AllPrograms : self.$FirebaseEvents.AllPrograms, ChildrenRequests: $FirebaseEvents.ChildrenRequests).environment(\.colorScheme, .light)
        } else {
            BottomTabBar(ChildrenProfiles: self.$FirebaseEvents.Galleries, FosterEvents: self.$FirebaseEvents.FosterOrgEvents, AllPrograms: self.$FirebaseEvents.AllPrograms ).background(Color("Color1")).environment(\.colorScheme, .light)
           
        }
    }
    
}
struct ContentView: View {
   
    @State var DebugClicked: Bool = false;
    @State var ClickedUser : Bool = false;
    
    init () {
     //  PostToFirebase().Sample()
    }
    var body: some View {
        // Home()
        
        
        //User Side
      //  BottomTabBar()
       //
        if (DebugClicked) {
            DebugOnly(ClickedUser: $ClickedUser, FirebaseEvents: FirebaseFoster(OrgUser: ClickedUser)).environment(\.colorScheme, .light)
        }
        else {
            DebugType(Clicked: $DebugClicked, ShowUser: $ClickedUser).environment(\.colorScheme, .light)
        }
        
    }
    
    
    // n Organization point of view
   
    
    //        VStack {
    //            TopHomePage()
    //            Text("Space")
    //           Spacer()
    //
    //        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
