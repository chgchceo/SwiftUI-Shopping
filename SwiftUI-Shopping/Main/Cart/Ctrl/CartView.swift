import SwiftUI
import SwiftUIRefresh // 导入 SwiftUIRefresh 库
  
struct CartView: View {
    
    @Binding var isCurrentPage:Bool
    
    @State private var items = ["Item 1", "Item 2", "Item 3","Item 1", "Item 2", "Item 3"]
  
    var body: some View {
        
        NavigationView {

            VStack{
                
                
                TopView()
                
                
                ScrollView {
                VStack{
                    
                        
                        MiddleView()
                        MiddleView()
                        MiddleView()
                    }
                }
                    .frame(height: ScreenHeight-TabBarHeight-NavigationBarHeight-90-BottomSafeHeight)
                
                BottomView()
                ThickDivider(color: bgColor, thickness: 0.5)
                
            }
            .background(bgColor)
            .padding(0)
            .navigationBarTitle("购物车", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {

                    print("ss")
                }, label: {
                    Text("搜索")
                        .foregroundColor(.black)
                }),trailing: Button(action: {

                    print("sz")
                }, label: {
                    Text("设置")
                        .foregroundColor(.red)
                }))
        }
        .onAppear(){
            
            self.isCurrentPage = true
            //加载网络数据
            
        }
        .onDisappear(){
            
            
        }
    }
}

struct TopView:View {
    
    var num:Int = 0
    var body: some View {
        
        HStack(spacing: 0){
            
            Text("共")
                .padding(.leading,15)
            Text("\(num)")
                .foregroundColor(.red)
            Text("商品")
            
            Spacer()
            
            HStack{
                Image(systemName: "pencil")
                Text("编辑")
            }.onTapGesture {
                
                print("edit")
            }
            .padding(.trailing,15)
        }
        .frame(height: 40)
    }
}

struct MiddleView:View {
    
    var body: some View{
        
        ZStack{
            
            HStack{
                
                
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                                .padding(.leading,5)
                                        
                            Image("banner1")
                                .frame(width: 120,height: 120)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(20)
                                .clipped()
                                .padding(.vertical,20)
                
                            VStack{
                                
                                Text("商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称")
                                    .padding(10)
                                    .frame(width: 200,alignment: .leading)
                                    .lineLimit(4)
                                    .font(.system(size: 14))
                                
                                HStack{
                                    
                                    Text("¥9999.00")
                                        .foregroundColor(.red)
                                    
                                    Text("-")
                                    
                                    .frame(width: 20,height: 30)
                                    .background(bgColor)
                                    Text("0")
                                        .frame(width: 40,height: 30)
                                        .background(bgColor)
                                        .padding(.horizontal,1)
                                    Text("+")
                                        .frame(width: 20,height: 30)
                                        .background(bgColor)
                                }
                                .padding(.bottom,15)
                            }
                        }
        }
        .padding(5)
        .background(Color.white)
        .frame(minWidth: ScreenWidth-30,maxWidth: ScreenWidth-30)
        .cornerRadius(20)
    }
}


struct BottomView:View {
    
    var body: some View{
        
        HStack{
            
            HStack{
                
                Button(action: {}, label: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.green)
                    Text("全选")
                    
                    Spacer()
                })
            }
            
        }
        .frame(height: 50)
        .background(Color.white)
    }
}

struct ThickDivider: View {
    let color: Color
    let thickness: CGFloat
  
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: thickness) // 设置分割线的厚度
    }
}
