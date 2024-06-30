//
//  HomeModel.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit
import HandyJSON

class BaseModel:HandyJSON,Identifiable{
    
    required init() {
        
    }
}

class HomeModel: BaseModel {

    var status:Int? = 0
    var message:String? = ""
    var data:DataModel?
}

class DataModel:BaseModel{
    
    var pageData:PageDataModel?

}


class PageDataModel:BaseModel{
    
    
    var items:[ItemsModel]?
    
}

class ItemsModel:BaseModel{
    
    var name:String = ""
    var type:String = ""
    var data:[DetailModel]?
}

class DetailModel:BaseModel{
   
    
    var imgUrl:String?
    var imgName:String?
    var link:[String:Any] = [:]
    var text:String?
    
    var goods_id:String?
    var goods_image:String?
    var goods_price_max:String?
    var goods_price_min:String?
    var goods_name:String?
    var goods_sales:String?
}
