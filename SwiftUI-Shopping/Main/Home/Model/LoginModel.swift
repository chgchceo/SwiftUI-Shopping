//
//  LoginModel.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/26.
//

import Foundation

class LoginImageModel:BaseModel{
    
    var status:Int? = 0
    var message:String? = ""
    var data:ImgData?
    
}

class ImgData:BaseModel{
    
    var base64:String = ""
    var key:String = ""
    var md5:String = ""
}
