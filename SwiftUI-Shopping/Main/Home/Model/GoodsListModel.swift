//
//  GoodsListModel.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/27.
//

import Foundation


class GoodsListModel :BaseModel{
    
    var status:Int? = 0
    var message:String? = ""
    var data:GoodsDataModel?
}

class GoodsDataModel:BaseModel{
    
    var list:GoodsList?
}
class GoodsList:BaseModel{
    

//   var data:[GoodsDetailModel]?
    var data:[DetailModel]?
}

class GoodsDetailModel:BaseModel{
    
    var goods_id:String?
    var goods_image:String?
    var goods_price_max:String?
    var goods_price_min:String?
    var goods_name:String?
    var goods_sales:String?
}
