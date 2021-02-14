//
//  Inquiries.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct Inquiries: View {
    
    var listOfInquiries : [String] = ["A" , "B" , "C" , "D" , "E" , "F"]
    
    var body: some View {
        ChatBodyy().background(Color.white)
//        ForEach(listOfInquiries ,id: \.self ) {i in
//            VStack {
//                Text(i).fontWeight(.bold)
//                Text("Is interested in XYZ Event").font(.title2)
//                Text("Get Profile, Info")
//            }.background(Color.white).padding(10)
//        }
    }
}

struct Inquiries_Previews: PreviewProvider {
    static var previews: some View {
        Inquiries()
    }
}
struct ChatBodyy : View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var selectedTab = "Chats"
    @Namespace var animation
    
    var body: some View{
        
        VStack(spacing: 0){
            
            ZStack{
                
                Color("top")
                
                Color("bg")
                    .clipShape(CustomCorner(corner: .topRight, size: 65))
                 
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 20){
                        
                        HStack{
                            
                            Text("Chats")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer(minLength: 0)
                            
                            Button(action: {}, label: {
                                
                                Image(systemName: "slider.horizontal.3")
                                    .font(.system(size: 22))
                                    .foregroundColor(.primary)
                            })
                        }
                        .padding([.horizontal,.top])
                        
                        ForEach(data,id: \.groupName){gData in
                            
                            // Group Name..
                            HStack{
                                
                                Text(gData.groupName)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal)
                            
                            // Group Data....
                            
                            ForEach(gData.groupData){chatData in
                                
                                // Chat View...
                                
                                ChatView(chatData: chatData)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                })
                //.clipShape(CustomCorner(corner: .topRight, size: 65))
                // its cutting off inside view may be its a bug....
            }
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
    }
}


struct CustomCorner : Shape {
    
    var corner : UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct ChatView : View {
    
    var chatData : Chat
    
    var body: some View{
        
        HStack(spacing: 10){
            
            WebImage(url: URL(string: chatData.image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(chatData.name)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(chatData.msg)
                    .font(.caption)
                    .lineLimit(1)
            })
            
            Spacer(minLength: 0)
            
            Text(chatData.time)
                .font(.system(size: 15))
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}

// Model And Sample Data....

struct Chat : Identifiable {
    
    var id = UUID().uuidString
    var name : String
    var image : String
    var msg : String
    var time : String
}

// were going to do custom grouping of views....

struct HomeData {
    
    var groupName : String
    var groupData : [Chat]
}

var FriendsChat : [Chat] = [

    Chat(name: "Johnson",image: "https://3.bp.blogspot.com/-azRv36eEpQ8/W9Et4PVU6nI/AAAAAAAA0so/QBlX4kyuX2gd1bZI2X2_DVP6CYKMUhgsQCLcBGAs/s400/IMG_8422-132.jpg", msg: "Hey EveryOne !!!", time: "02:45"),
    Chat(name: "Smith",image: "https://1.bp.blogspot.com/-jyRfg88mRIc/W9Et4nuFE-I/AAAAAAAA0sw/XYR7gcKA50IQsWVqsf__xtZF8MavpKdvQCLcBGAs/s640/IMG_8492-202.jpg", msg: "Learn - Develop - Deploy", time: "03:45"),
    Chat(name: "Brown",image: "https://i.pinimg.com/564x/a0/9a/24/a09a247bde7289c1da5f03f052eee7f8.jpg", msg: "New Framework For iOS", time: "04:55"),
    Chat(name: "Jone Family",image:"https://i.pinimg.com/564x/a0/9a/24/a09a247bde7289c1da5f03f052eee7f8.jpg", msg: "New Framework For iOS", time: "06:25"),
    Chat(name: "Allen's Family",image: "https://i.pinimg.com/564x/a0/9a/24/a09a247bde7289c1da5f03f052eee7f8.jpg", msg: "New Framework For iOS",   time: "07:19"),
    Chat(name: "Baker Family",image: "https://i.pinimg.com/564x/a0/9a/24/a09a247bde7289c1da5f03f052eee7f8.jpg",   msg: "I dont Know How To Spend Money :)))", time: "08:22"),
]

var GroupChat : [Chat] = [

    Chat(name: "Johnsons Family",image: "https://i.pinimg.com/564x/a0/9a/24/a09a247bde7289c1da5f03f052eee7f8.jpg" ,msg: "Hey EveryOne !!!", time: "02:45"),
    Chat(name: "Davis Family",image: "https://i.pinimg.com/564x/a0/9a/24/a09a247bde7289c1da5f03f052eee7f8.jpg" , msg: "Next Video :))))", time: "03:45"),
    Chat(name: "Miller Family",image: "https://i.pinimg.com/564x/a0/9a/24/a09a247bde7289c1da5f03f052eee7f8.jpg"  ,msg: "New File Importer/Exporter", time: "04:55"),
]

var data = [

    // Group 1
    HomeData(groupName: "Today", groupData: FriendsChat),
    HomeData(groupName: "Past Week", groupData: FriendsChat),
    HomeData(groupName: "Over a Month", groupData: FriendsChat),
    // Group 2
   
]
