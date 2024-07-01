//
//  CategoryModel.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/1.
//

import SwiftUI



class CategoryModel:BaseModel{
    
    var status:Int? = 0
    var message:String? = ""
    var data:CategoryData?
}

class CategoryData:BaseModel{
    
    var list:[CategoryDetailData]?
}

class CategoryDetailData:BaseModel{
    
    /*"category_id": 10016,
     "name": "热门推荐",
     "parent_id": 0,
     "image_id": 0,
     "status": 1,
     "sort": 1,
     "children": [*/
    
    var name = ""
    var category_id = ""
    var children:[CategoryChildrenData]?
    @State var bColor:Color = bgColor
}

class CategoryChildrenData:BaseModel{
    
    var name = ""
    var category_id = ""
    var image:CategoryUrlData?
    
}

class CategoryUrlData:BaseModel{
    
    var preview_url = ""
}


