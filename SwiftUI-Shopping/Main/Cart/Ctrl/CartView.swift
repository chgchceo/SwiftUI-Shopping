import SwiftUI
import SwiftUIRefresh // 导入 SwiftUIRefresh 库
  
struct CartView: View {
    @State private var isRefreshing = false
    @State private var items = ["Item 1", "Item 2", "Item 3"]
  
    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
        .pullToRefresh(isShowing: $isRefreshing) {
            // 在这里执行刷新操作
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.items.insert("New Item", at: 0)
                self.isRefreshing = false
            }
        }
    }
}
//
//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
