//
//  LoginPageView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/4.
//

import SwiftUI

struct LoginPageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isShowToast = false
    @State var message:String = ""
    
    @State var base64String = ""
    @State var phoneNum:String = ""
    @State var imgCode:String = ""
    @State var smsCode:String = ""
    @State var captchaKey:String = ""
    var body: some View {
        
       
        ZStack{
            
            VStack{
                
                Text("手机号登录")
                    .font(.title.bold())
                    .frame(width: ScreenWidth-60,alignment: .leading)
                    .padding(.top,35)
                
                Text("未注册的手机号登录后将自动注册")
                    .frame(width: ScreenWidth-60,alignment: .leading)
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                    .padding(.top,1)
                
                TextField("请输入手机号码", text: $phoneNum)
                    .padding(.horizontal, 30)
                    .font(.system(size: 16))
                    .padding(.top,40)
                    .foregroundColor(.black)
                
                HStack{
                    
                    TextField("请输入图形验证码", text: $imgCode)
                        .padding(.leading, 30)
                        .font(.system(size: 16))
                        .padding(.top,20)
                        .foregroundColor(.black)
                        .frame(height: 50)
                    
                    Button(action: {
                        
                        self.loadImgData()
                        
                    }, label: {
                        
                        if  base64String.count > 0 {
                            
                            Image(uiImage: imageFromBase64(base64String)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100,height: 30)
                                .padding(.trailing,40)
                                .padding(.top,15)
                            
                        }
                    })
                    
                }
                HStack{
                    
                    TextField("请输入短信验证码", text: $smsCode)
                        .padding(.leading, 30)
                        .font(.system(size: 16))
                        .padding(.top,20)
                        .foregroundColor(.black)
                        .frame(height: 50)
                    
                    Button(action: {
                        
                        self.loadSmsData()
                    }, label: {
                        
                        Text("获取验证码")
                            .foregroundColor(.orange)
                            .font(.system(size: 16))
                            .padding(.trailing,50)
                            .padding(.top,15)
                    })
                    
                }
                
                Button(action: {
                    self.loginAction()
                    
                }, label: {
                    Text("登录")
                        .frame(width: ScreenWidth-60,height: 50)
                        .background(Color.orange)
                        .cornerRadius(25)
                        .foregroundColor(.white)
                        .padding(.top,35)
                })
                
                
            }
            ToastView(isVisible: $isShowToast, message: message)
        }
        
        .onAppear(){
            
            self.loadImgData()
        }
        .navigationTitle("会员登录")
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
        
    }

    
    //加载图形验证码数据
    func loadImgData() -> Void{
        
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/captcha/image") { request, responseData in
            
          let model =  LoginImageModel.deserialize(from: responseData as! Dictionary<String, Any> as Dictionary)
            if model?.status == 200{
                
                captchaKey = (model?.data!.key)!
                let base64String = (model?.data!.base64)!
                self.base64String = base64String.replacingOccurrences(of: "data:image/png:base64,", with: "")
            }
        }
    }
    
    //请求短信验证码
    func loadSmsData() {
        
        if phoneNum.count <= 0{
            
            message = "请输入手机号码"
            isShowToast = true
            return
        }
        if imgCode.count <= 0{
            
            message = "请输入图形验证码"
            isShowToast = true
            return
        }
        
        let param = ["captchaCode":imgCode,"captchaKey":captchaKey,"mobile":phoneNum]
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/captcha/sendSmsCaptcha",parameters: param) { request, responseData in
            
            let model = LoginImageModel.deserialize(from: responseData as? Dictionary<String,Any>)
            
            if model?.status == 200 {
                
                message = model?.message ?? "短信发送成功，请注意查收"
                isShowToast = true
            }
        }
    }
    //登录
    
    func loginAction() -> Void {
        
        if phoneNum.count <= 0{
            
            message = "请输入手机号码"
            isShowToast = true
            return
        }
        if imgCode.count <= 0{
            
            message = "请输入图形验证码"
            isShowToast = true
            return
        }
        if imgCode.count <= 0{
            
            message = "请输入短信验证码"
            isShowToast = true
            return
        }
        let param = [
            "form":[
            "isParty":false,
            "partyData":[:],
            "smsCode":smsCode,
            "mobile":phoneNum
        ]]
        
        
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\r\n    \"form\": {\r\n        \"smsCode\": \"\(smsCode)\",\r\n        \"mobile\": \"\(phoneNum)\",\r\n        \"isParty\": false,\r\n        \"partyData\": {}\r\n    }\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://smart-shop.itheima.net/index.php?s=/api/passport/login")!,timeoutInterval: Double.infinity)
        request.addValue("H5", forHTTPHeaderField: "platform")
        request.addValue("Apifox/1.0.0 (https://apifox.com)", forHTTPHeaderField: "User-Agent")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           guard let data = data else {
              print(String(describing: error))
               message = String(describing: error) 
               isShowToast = true
               
              semaphore.signal()
              return
           }
            let res = String(data: data, encoding: .utf8)!
            
            let dic:Dictionary<String,Any> = stringToDictionary(jsonString: res) ?? [:]
            
            let model = LoginImageModel.deserialize(from: dic)
            
            if model?.status == 200 {
                
                let userId = model?.data?.userId
                let token = model?.data?.token
                
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.set(token, forKey: "token")
                
            }
            message = model?.message ?? "登录成功"
            isShowToast = true
            
           semaphore.signal()
            //主线程
            DispatchQueue.main.async {
                
                presentationMode.wrappedValue.dismiss()
            }
        }

        task.resume()
        semaphore.wait()
        
    }
    
    
    func imageFromBase64(_ base64String: String) -> UIImage? {
        // 移除Base64字符串的MIME类型前缀
        let cleanBase64String = base64String.replacingOccurrences(of: "data:image/png;base64,", with: "", options: .caseInsensitive, range: nil)
          
        // 将清理后的Base64字符串解码为Data
        guard let data = Data(base64Encoded: cleanBase64String, options: .ignoreUnknownCharacters) else {
            return nil
        }
          
        // 使用解码后的Data创建UIImage
        return UIImage(data: data)
    }
}
//
//#Preview {
//    LoginPageView()
//}
