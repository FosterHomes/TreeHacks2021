//
//  SwiftUIView.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI
var ChildSelected = ChildProfileStruct(age: "", name: "", lastName: "", ImageUrl: "", FosterRef: "", Desc: "", Location: "", SiteUrl: "")
struct Home: View {
    //  @Binding var detail : DetailViewModel
    //var animation: Namespace.ID
    @Binding var Detail : Bool
    @State var firstMinY: CGFloat = 0
    @State var show = false
    // Stoping Bounces On SCrollView...
    
    @ObservedObject var detail : DetailViewModel
    
    @State var minY: CGFloat = 0
    @State var lastMinY: CGFloat = 0
    @State var scale : CGFloat = 0
    @State var Website: String = ""
    
    @State var Inquired : Bool = false;
    var body: some View {
        ZStack {
            VStack {
               
             // HeaderView()
               
               ScrollView {
                   
                   // Top Sticky View...
                StickyView(firstMinY: $firstMinY,minY: $minY,lastMinY: $lastMinY,scale: $scale).ignoresSafeArea()
                   
                   VStack(alignment: .leading, spacing: 15, content: {
                       
                       
                           
                    Section(header: Text("\( ChildSelected.name)")
                                       .font(.title)
                                       .fontWeight(.bold)) {
                              
                        
                        
                            
                        Text("\( ChildSelected.Desc)")
                           }.padding(12)
                        
                    Button(action : {
                        UserBasedFirebase().SendInquiry(Registered: "children", UserInfo: "likedHmMTzu0Mbcn6zWJ", DocumentID: ChildSelected.DocumentID)
                    }) {
                        Text(Inquired ? "Inquiry sent": "Inquire" ).fontWeight(.bold).frame(width: UIScreen.main.bounds.width/1.7)
                           .foregroundColor(.black)
                           .padding(.vertical)
                           .padding(.horizontal,7)
                           .background(Color.yellow).cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width)
                        
                    }
                    
                    
                    Button(action : {
                        
                        self.Website = "https://www.kidsave.org/weekend-miracles-host-application/"
                        self.show.toggle()
                    }) {
                        Text("Apply to Host")
                            .fontWeight(.bold).frame(width: UIScreen.main.bounds.width/1.7)
                            .foregroundColor(.black)
                            .padding(.vertical)
                                .padding(.horizontal,30)
                                .background(Color.yellow).cornerRadius(12)
                                .frame(width: UIScreen.main.bounds.width)
                         }
                         
                         Button(action : {
                            self.Website = "https://www.kidsave.org/weekend-miracles-inquiry/"
                            self.show.toggle()
                         }) {
                             Text("Contact Us Today!").fontWeight(.bold).frame(width: UIScreen.main.bounds.width/1.7)
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .padding(.horizontal,7)
                                .background(Color.yellow).cornerRadius(12)
                                .frame(width: UIScreen.main.bounds.width)
                                
                         }
                    
                    Text("").padding(40)
                         
                       
                   })
                   .padding(10)
                   // since were moving view up...
                   .padding(.bottom,lastMinY)
                   .background(Color.white)
                   .offset(y: scale > 0.4 ? minY : lastMinY)
                   .opacity(scale < 0.3 ? 1 : 0)
                
              
               
                
            
            
            
               }
            
           }.padding(10)
           .ignoresSafeArea(.all, edges: .top)
           .background(Color.yellow.ignoresSafeArea(.all, edges: .all)).ignoresSafeArea(.all, edges: .top)
        
            
            VStack {
            HStack{
                
              
                Spacer(minLength: 0)
                
                Button(action: {
                    withAnimation(.spring()){
                        //$detailObject.detail.toggle
                        withAnimation(.spring()){
                           // detail.show.toggle()
                            self.Detail.toggle()
                                                        }
                       
                    }
                }) {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black.opacity(0.7))
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 2)
            // since we ignored top area...
            .padding(.top,UIApplication.shared.windows.first!.safeAreaInsets.top + 10)
                Spacer()
            }.padding(50)
            
            
            
       }.sheet(isPresented: $show) {
        Safari(Website: self.Website)
    }.ignoresSafeArea(.all, edges: .top)
        .background(Color.yellow.ignoresSafeArea(.all, edges: .all))
        
       }
   }
   
   let subTitles = ["Award Winning\nWeb Designs"]
   
  
   
   // Extending View To Get Screen Rect...
   
   extension View{
       
       func getScreen()->CGRect{
           
           return UIScreen.main.bounds
       }
   }
   
   


