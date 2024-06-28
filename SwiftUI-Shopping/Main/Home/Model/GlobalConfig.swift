//
//  GlobalConfig.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/25.
//

import Foundation
import UIKit

let LNConfig = LNNetworkConfiguration(baseURL: URL(string: "https://smart-shop.itheima.net/index.php?s=/api"))

let ScreenWidth = UIScreen.main.bounds.width

let ScreenHeight = UIScreen.main.bounds.height

let NavigationBarHeight = UIDevice.xp_navigationFullHeight()

let TabBarHeight = UIDevice.xp_tabBarFullHeight()

let StateBarHeight = UIDevice.xp_statusBarHeight()

let TopSafeHeight = UIDevice.xp_safeDistanceTop()

let BottomSafeHeight = UIDevice.xp_safeDistanceBottom()


public let RGBAlpa:((Float,Float,Float,Float) ->UIColor) = { (r:Float, g:Float, b:Float, a:Float) ->UIColor in

    return UIColor.init(red:CGFloat(CGFloat(r)/255.0), green:CGFloat(CGFloat(g)/255.0), blue:CGFloat(CGFloat(b)/255.0), alpha:CGFloat(a))

}

// 通过 十六进制与alpha来设置颜色值  HexRGBAlpha(0xe47833,1)

public let HexRGBAlpha:((Int,Float) ->UIColor) = { (rgbValue :Int, alpha :Float) ->UIColor in

    return UIColor(red:CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255), green:CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255), blue:CGFloat(CGFloat(rgbValue & 0xFF)/255), alpha:CGFloat(alpha))

}

