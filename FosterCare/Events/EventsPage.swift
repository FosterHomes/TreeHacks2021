//
//  EventsPage.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 13/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
var SelectedFosterEvent = FosterEvents(Title: "", Venue: "", Location: "", Desc: "", EventDate: "", Contacts: Contact(Email: "", Name: ""), ImageUrl: "", DocumentID: "", OrgID: "")
var SelectedProgram = Programs()
var ShowEvent = false;
 


var RegistedEventsByUser : [String] = [String]()
struct EventsPage: View {
    var IfOrg : Bool
    @Binding var ProfileDetails : Bool
    @Binding var FosterOrgEvents : EventAndOrg
    
    
    @Binding var ViewRegistered : Bool
    var body: some View {
        
        VStack {
            HStack {
                Text("Upcoming Events")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                
                
                if !IfOrg {
                    Button(action : {
                        self.ViewRegistered.toggle()
                    }) {
                        Image(systemName: "square.and.pencil").foregroundColor(Color("Color2")).font(.system(size: 35))
                    }
                }
                
                
                
                
                
            }.padding(.horizontal, 40)
            ForEach (0..<FosterOrgEvents.FosterEvent.count, id : \.self) { i in
                VStack {
                    
                  //  if (i < FosterOrgEvents.FosterOrg.count) {
                    PostRow(IfOrg: IfOrg, ProfileDetail: self.$ProfileDetails, FosterEvent: FosterOrgEvents.FosterEvent[i] , FosterCare: FosterOrgEvents.FosterOrg[i]).shadow(radius: 7)
                    //                    VStack(alignment: .leading, spacing: 10) {
                    //                        Text("Hola").fontWeight(.heavy)
                    //                        Text("These children are the ones that dont have love and affection that is needed by every child")
                    //                    }//                    Image("p6").resizable().frame(width: 110, height: 135)
                    //                        .cornerRadius(20)
                  //  }
                    
                    
                    
                }
                .padding()
                .padding(.bottom,8)
            }
        }.background(Color.white)
    }
}



struct PostRow: View {
    
    //var ChildEvents : [ChildEvent] = [ChildEvent]()
    var IfOrg : Bool
    @Binding var ProfileDetail: Bool
    var FosterEvent : FosterEvents
    var FosterCare : FosterCare
    @State var Bookmarked = true;
    @State var show: Bool = false;
    var body: some View {
        
        VStack(spacing: 15){
            
            
           
            
            HStack{
                
                Text(FosterEvent.EventDate)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        
                        HStack(spacing: 10){
                            
                            
                            // displaying only posted user...
                            
                            
                            
                            if IfOrg {
                                
                                    
                                Menu(content: {
                                    
                                    Button(action: {}) {
                                        
                                        Text("Edit")
                                    }
                                    
                                    Button(action: {
                                        PostToFirebase().DeleteEvent(FosterEvent)
                                        
                                    }) {
                                        
                                        Text("Delete")
                                    }
                                    
                                }, label: {
                                    
                                    Image(systemName: "pencil.circle.fill")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundColor(.black).shadow(radius: 6)
                                }).cornerRadius(30).font(.system(size: 32)).foregroundColor(.green).cornerRadius(30).background(Color.yellow).cornerRadius(30).padding(10).cornerRadius(30)
                                
                            }
                            else {
                                 
                                    
                                    Button(action: {
                                        RegistedEventsByUser.append(FosterEvent.DocumentID)
                                //        UserBasedFirebase().SendInquiry(Registered: "events", UserInfo: "likedHmMTzu0Mbcn6zWJ", DocumentID: FosterEvent.DocumentID)
                                        self.Bookmarked.toggle()
                                        
                                    }) {
                                        if Bookmarked == true {
                                            Image(systemName: "bookmark.circle").cornerRadius(30).font(.system(size: 32)).foregroundColor(.white).cornerRadius(30).background(Color.black).cornerRadius(30) .cornerRadius(30).shadow(color: Color("Color3") , radius: 5 )
                                            
                                        }
                                        else {
                                            Image(systemName: "bookmark.circle.fill").cornerRadius(30).font(.system(size: 32)).foregroundColor(.green).cornerRadius(30).background(Color.black).cornerRadius(30) .cornerRadius(30).shadow(color: Color("Color3") , radius: 5)
                                        }
                                    }.cornerRadius(30)
                                    
                                 
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
            
                
            }
            .padding(.top,5)
            
            if (FosterEvent.ImageUrl != "") {
                WebImage(url: URL(string: FosterEvent.ImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 250)
                    .cornerRadius(15)
                    
            }
            
            
            HStack {
                Text("\(FosterEvent.Title)").fontWeight(.bold).font(.title3)
            Spacer()
            
            }
           
           
            
            if IfOrg == false {
                HStack {
                    Button(action: {
                       
                        self.show.toggle()
                    }) {
                        Text("Join Event").fontWeight(.bold).frame(width: UIScreen.main.bounds.width/3)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,30)
                            .background(Color("Color3")).cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width / 3)
                        
                        
                        
                        
                        
                    }.shadow(color: Color("Color3"), radius: 2)
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()){
                            // detail.show.toggle()
                            SelectedFosterEvent = FosterEvent
                            ShowEvent = true
                            self.ProfileDetail.toggle()
                            
                            
                        }
                        
                        
                        
                    }) {
                        Text("Learn More").fontWeight(.bold).frame(width: UIScreen.main.bounds.width/3)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,30)
                            .background(Color("Color2")).cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width / 3)
                    }.shadow(color: Color("Color2"), radius: 7)
                }
            }
            
        }.onTapGesture {
            self.hideKeyboard()
        }.sheet(isPresented: $show) {
            Safari(Website: self.FosterEvent.Venue)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}

// NewPost
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
