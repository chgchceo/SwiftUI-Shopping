//
//  SearchHistoryListView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/1.
//

import SwiftUI

struct SearchHistoryListView: View {
    
    @State var showToase = false
    
    @State var message = ""
    
    @State private var goResultView = false
    
    @State var data:[String]? = []
    
    @State var keyword = ""
    
    @State private var isPresented = false
     
       var body: some View {
           ZStack {
               
               bgColor
               
               VStack{
                   
                   HStack{
                       
                       TextField("请输入搜索关键字", text: $keyword)
                           .frame(width: ScreenWidth-160,height: 45)
                           .padding(.leading,30)
                       Button {
                           
                           
                           goSearchResultPageView()
                           
                       } label: {
                           
                           Text("搜索")
                               .frame(width: 130,height: 45,alignment: .center)
                               .background(Color.red)
                               .foregroundColor(.white)
//                               .cornerRadius(5)
                           
                           NavigationLink(destination: SearchGoodsListView(firstShowDetail: $goResultView, key: keyword), isActive: $goResultView) {
                               
                               
                           }
                           
                       }

                       
                   }
                   .frame(width: ScreenWidth-30,height: 45)
                   .background(Color.white)
                   .cornerRadius(5)
                   .padding()
                   
                   HStack{
                       
                       Text("搜索历史")
                       Spacer()
                       Image(systemName: "trash.circle")
                           .onTapGesture {
                               
                               UserDefaults.standard.set("", forKey: "searchList")
                               self.data = []
                           }
                   }
                   .padding()
                   
                   ScrollView{
                   LazyVGrid(columns:[GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())]) {
                       
                       
                       
                       if self.data != nil{
                           
                           ForEach(self.data!,id: \.self) { title in
                               
                               
                               Text(title)
                                   .onTapGesture {
                                       keyword = title
                                       goSearchResultPageView()
                                   }
                                   .padding()
                                   .frame(width: 110, height: 40, alignment: .center)
                                   .background(Color.white)
                                   .cornerRadius(20)
                               
                           }.padding()
                       }
                               
                       }
                       
                   }
                                    .frame(width: ScreenWidth, height: ScreenHeight-NavigationBarHeight-TabBarHeight-200, alignment: .center)
                   
                   Spacer()
               }
               
               ToastView(isVisible: $showToase, message: message)
           }
           .navigationTitle("搜索历史")
           .onAppear(){
               
               self.initData()
           }
       }
    
     func initData() -> Void {
        
        let list:String = (UserDefaults.standard.object(forKey: "searchList") as? String) ?? ""
        
        if list.count > 0{
            
            let data = list.components(separatedBy: "#%#")
            self.data = data
        }
    }
    
    func goSearchResultPageView() -> Void {
        
        //
        
        if keyword.count > 0{
            
            let index = (self.data?.firstIndex(of: keyword)) ?? -1
            if index >= 0 && index < self.data?.count ?? -1{
                
                self.data?.remove(at: index)
            }
            self.data?.insert(keyword, at: 0)
            let str = self.data?.joined(separator: "#%#")
            UserDefaults.standard.set(str, forKey: "searchList")
        }
       
        goResultView = true
        
    }
}



//struct SearchHistoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchHistoryListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
