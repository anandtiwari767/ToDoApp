//
//  data.swift
//  Todoapp
//
//  Created by Anand Tiwari on 30/08/19.
//  Copyright © 2019 Cogitate Technology Solutions. All rights reserved.
//

import Foundation

class Datafetch : Encodable , Decodable{
    var title : String = ""
    var done : Bool = false
}
