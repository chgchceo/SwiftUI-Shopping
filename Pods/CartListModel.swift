//
//  CartListModel.swift
//  SwiftUI-Shopping
//
//  Created by 程广成 on 2024/7/4.
//

import Foundation



class CartListModel:BaseModel{
    
    var status:Int? = 0
    var message:String? = ""
    var data:CartData?
    
}

class CartData:BaseModel{
    
    var cartTotal = 0
    var list:[CartDetailData]?
}

class CartDetailData:BaseModel{
    
    var goods:CartGoodsData?
    var goods_num = "1"
    var goods_id = ""
}

class CartGoodsData:BaseModel{
    
    var goods_name = ""
    var goods_image = ""
    var goods_price_max = ""
    var goods_price_min = ""
    var goods_id = ""
    
}
