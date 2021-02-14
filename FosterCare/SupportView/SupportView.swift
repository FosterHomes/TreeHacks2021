//
//  SupportView.swift
//  FosterCare
//
//  Created by Harshil Bhatt on 12/02/2021.
//

import Foundation
import SwiftUI


class Selections : ObservableObject {
    @Published var ChildSelected : ChildProfileStruct = ChildProfileStruct(age: "", name: "", lastName: "", ImageUrl: "", FosterRef: "", Desc: "", Location: "", SiteUrl: "")
  //  @Published var OrgProfileSelected :
}

