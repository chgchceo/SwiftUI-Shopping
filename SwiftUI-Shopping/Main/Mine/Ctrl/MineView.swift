
import SwiftUI



struct MineView: View {
    
    @Binding var isCurrentPage:Bool
    
    @State var isRefresh = false
    @State var isMore = false
    @State var isHasMore = true
    @State var textArr : Array<String> = []
    @State var count = 20
    
    var body: some View {
        
       
        ZStack{
            
            Rectangle()
                .foregroundColor(bgColor)
                .ignoresSafeArea(.all)
            
            MineTopView()
        }
        .onAppear(){
            
            self.isCurrentPage = true
            //加载网络数据
            self.loadData()
            
        }
        .onDisappear(){
            
            
        }
    }
    
    func loadData(){
        textArr.removeAll()
        for i in 0...count{
            textArr.append(String("\(i) Hello, world!"))
        }
    }
}


struct MineTopView:View {
    
    var body: some View{
        
        HStack {
            
            Image("banner1")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: 80,height: 80)
                .cornerRadius(40)
                .padding(20)
            VStack {
                
                Text("去登录")
                Text("hahahaha")
            }
            Spacer()
            
        }
        .frame(width: ScreenWidth-40)
        .cornerRadius(20)
        .background(Color.white)
        .padding(.horizontal,20)
    }
}
