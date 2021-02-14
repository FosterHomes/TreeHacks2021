//
//  CreateNewEvent.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct CreateNewEvent: View {
   
    @State var FosterEvent : FosterEvents = FosterEvents(Title: "", Venue: "", Location: "", Desc: "", EventDate: "", ImageUrl: "")
     
        @State var show = false
    
    var body: some View {
        ScrollView {
            VStack {
            ZStack {
                
                VStack {
                    Text("")
                    //
                    
                    // CalendarView()
                    TextFields(show: $show, FosterEvent: $FosterEvent).frame(width: UIScreen.main.bounds.width/1.2)
                    
                }
                
                .background(Color.white).frame(height: UIScreen.main.bounds.height)
                VStack{
                    
                    Spacer()
                    
                    RadioButtons(show: self.$show).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                
            }.animation(.default).onTapGesture {
                
                
                
            }
            }
        }
        
        
    }
}
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

var Contacts = [Contact]()
struct TextFields : View  {
    @EnvironmentObject var obj : Observed
    
    @State var NumItems = -1;
    @State var Update : Bool = false;
    
    @Binding var show : Bool
    @State var Multi: String = ""
    @Binding var FosterEvent : FosterEvents
    
     
   
    // TextFields
    @State var name : String = ""
    @State var Link: String = ""
    @State var Desc: String = ""
    @State var DateTime = Date()
    @State var Contacts = [Contact]()
    @State var ContactName: String = ""
    @State var ContactEmail : String = ""
    var body: some View {
        
        ScrollView {
        VStack(spacing : 15) {
                    
                    //                DatePicker("Time of Event" , selection: $DateTime, displayedComponents: .hourAndMinute).padding(40).shadow(radius: 8)
                    //
            HStack {
                Text("Create New Event")
                    .font(.title)
                    .fontWeight(.bold).foregroundColor(Color("Fav"))
                Spacer()
            }.padding(.horizontal, 40)
                    
                    HStack {
                        Spacer()
                        DatePicker("" , selection: $DateTime , displayedComponents: .date).padding(30).accentColor(Color("Fav"))
                             
                        DatePicker("" , selection: $DateTime , displayedComponents: .hourAndMinute).padding(30).accentColor(Color("Fav"))
                             
                        Spacer()
                    
                    }.background(Color.white).cornerRadius(24).padding(12).shadow(color: Color("Fav") , radius: 3)
                    
                    TextField("Event Name", text: $name)
                        //Style your Text Field
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(8)
                        .padding().frame(width : UIScreen.main.bounds.width / 1.01).accentColor(Color.green)
                    TextField("Venue/Link to event", text: $Link)
                        //Style your Text Field
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(8)
                        .padding().frame(width : UIScreen.main.bounds.width / 1.01)
                    TextSide(Texts: "Event Description").padding()
                    MultiTextField(Text: self.$Desc).padding().background(lightGreyColor).cornerRadius(10).frame(width : UIScreen.main.bounds.width / 1.07, height: UIScreen.main.bounds.height / 3)
                    
                    
                    if (NumItems != -1) {
                        ForEach(0...NumItems, id : \.self){item in
                            TextSide(Texts: "Contact \(item + 1)").padding()
                            TextField("Contact Name", text: $ContactName)
                                //Style your Text Field
                                .padding()
                                .background(lightGreyColor)
                                .cornerRadius(8)
                                .padding().frame(width : UIScreen.main.bounds.width / 1.01)
                            TextField("Contact Email/Phone", text: $ContactEmail)
                                //Style your Text Field
                                .padding()
                                .background(lightGreyColor)
                                .cornerRadius(8)
                                .padding().frame(width : UIScreen.main.bounds.width / 1.01)
                            
                            
                        }
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            self.NumItems += 1
                            self.Update.toggle()
                            
                        }) {
                            HStack {
                                Text("Add Contact")
                                Image(systemName: "plus.circle.fill").foregroundColor(Color.blue).font(.title).padding(.trailing , 30).shadow(radius: 12)
                            }
                        }
                        
                    }
                    
                    Button(action: {
                        
                        self.AddEvent()
                        self.show.toggle()
                       
                        
                    }) {
                        Text("Add New Event").fontWeight(.bold).frame(width: UIScreen.main.bounds.width/1.7)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .padding(.horizontal,30)
                            .background(Color("Fav")).cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width)
                    }.shadow(color: Color("Fav") , radius: 7)
            Text("").padding(40)
                     
                    
                    
                    
                }.padding(20).background(Color.white).onTapGesture {
                    self.hideKeyboard()
                }
        }
                
                
                
                
                
            
        
        
        
        
    }
    
    func AddEvent() {
        
        self.name  = ""
        self.Link  = ""
        self.Desc  = ""
        self.DateTime = Date()
        self.Contacts = [Contact]()
        self.ContactName  = ""
        self.ContactEmail   = ""
        
        
        
        
        FosterEvent.Title = name
        FosterEvent.Venue = Link
        FosterEvent.Desc = Desc
        FosterEvent.EventDate = "\(DateTime)"
        FosterEvent.RegisteredUsers = [String]()
        FosterEvent.OrgID = OrgIdFb
        FosterEvent.Venue = "https://zoom.us/j/6834024525?pwd=WER3MHhuMmwyM0hlNjhXcjIveXhNZz09"
        
        let Contact1 = Contact(Email: ContactEmail, Name: ContactName)
        
        FosterEvent.Contacts = Contact1
        FosterEventCreated = FosterEvent
        PostToFirebase().PostNewEvent(FosterEvent, AddDate: DateTime)
    }
    
}
