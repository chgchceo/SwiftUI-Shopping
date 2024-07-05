//
//  GoodsDetailPageModel.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/5.
//

import UIKit

class GoodsDetailPageModel: BaseModel {

    var status:Int? = 0
    var message:String? = ""
    var data:GoodsDetail?
    
    
}

class GoodsDetail:BaseModel{
    
   
    var detail:GoodsDetailData?
    
}


class GoodsDetailData:BaseModel{
    
    var goods_name:String = ""
    var content:String = ""
    var goods_sales:String = ""
    var goods_price_min:String = ""
    var goods_price_max:String = ""
    var goods_images:[GoodsImageModel]?
    
}

class GoodsImageModel:BaseModel{
    
    var preview_url:String = ""
}

class GoodsCommentListData:BaseModel{
    
    var status:Int? = 0
    var message:String? = ""
    var data:GoodsComData?
}

class GoodsComData:BaseModel{
    
    var total:String = "0"
    var list:[GoodsCommentDetailData]?
}

class GoodsCommentDetailData:BaseModel{
    
    var content:String = ""
    var score:Int = 0
    var create_time = ""
    var user:CommentUserData?
}

class CommentUserData:BaseModel{
    
    var nick_name:String = ""
    var avatar_url:String = ""
}


