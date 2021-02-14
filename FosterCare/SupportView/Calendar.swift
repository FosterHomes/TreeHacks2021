//
//  Calendar.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import SwiftUI

struct CalendarView: View {
    @State var date = Date()
    @State var data :  DateType!
    var body: some View {
       
       
            
            VStack {
                
                if self.data != nil {
                    ZStack {
                        VStack(spacing: 15) {
                            ZStack {
                                HStack {
                                    Spacer()
                                    Text(self.data.Month).font(.title).foregroundColor(Color.black)
                                    Spacer()
                                }
                                .padding(.vertical)
                                
                                HStack {
                                    Button(action: {
                                        self.date = Calendar.current.date(byAdding: .month, value: -1, to : self.date)!
                                        self.UpdateDate()
                                        
                                    }) {
                                        Image(systemName: "arrow.left")
                                             
                                    }
                                    Spacer()
                                    
                                    Button(action: {
                                        self.date = Calendar.current.date(byAdding: .month, value: 1, to : self.date)!
                                        self.UpdateDate()
                                    }) {
                                        Image(systemName: "arrow.right")
                                            
                                    }
                                    
                                    
                                }
                                .padding(10)
                                
                            }
                            .background(Color.red)
                            
                            
                            
                           
                            Text(self.data.Date).font(.system(size: 65)).fontWeight(.bold).foregroundColor(Color.black)
                            Text(self.data.Day).font(.title).foregroundColor(Color.black)
                            Divider()
                            Text(self.data.Year).font(.title).foregroundColor(Color.black)
                                .padding(.bottom,12)
                            
                        }
                        
                        HStack {
                            Button(action: {
                                self.date = Calendar.current.date(byAdding: .day, value: -1, to : self.date)!
                                self.UpdateDate()
                            }) {
                                Image(systemName: "arrow.left").foregroundColor(Color.black)
                                     
                            }
                            Spacer()
                            Button(action: {
                                self.date = Calendar.current.date(byAdding: .day, value:  1, to : self.date)!
                                self.UpdateDate()
                            }) {
                                Image(systemName: "arrow.right").foregroundColor(Color.black)
                                    
                            }
                            
                            
                        }.padding(10)
                        
                    }.foregroundColor(.white)
                    
                    .frame(width: UIScreen.main.bounds.width/1.2)
                    .background(Color.white)
                    .cornerRadius(15 )
                }
            }.shadow(radius: 6)
        .background(Color.black.opacity(0.06))
        .onAppear {
            self.UpdateDate()
        }
            Spacer()
        
    }
    
    func UpdateDate() {
        
        let Current = Calendar.current
        let date = Current.component(.day, from: self.date)
        let monthNo = Current.component(.month, from: self.date)
        let Month = Current.monthSymbols[monthNo - 1]
        let year = Current.component(.year, from: self.date)
        let weekNo = Current.component(.weekday, from: self.date)
        let day = Current.weekdaySymbols[weekNo - 1]
        
        self.data = DateType(Day: "\(day)", Date: "\(date)", Year: "\(year)", Month: Month)
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

struct DateType {
    
    var Day: String
    var Date : String
    var Year : String
    var Month : String
    
}
