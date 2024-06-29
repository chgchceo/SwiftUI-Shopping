import SwiftUI
  
struct CategoryView: View {
    @State private var isRefreshing = false
    @State private var items = [Int](1...20)
    @State private var isLoadingMore = false
    @State private var showingRefresh = false
    @State private var showingLoadMore = false
  
    var body: some View {
        ScrollView {
            LazyVStack {
                if isRefreshing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(height: 50)
                }
                ForEach(items, id: \.self) { item in
                    Text("Item \(item)")
                        .padding()
                }
                if isLoadingMore {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(height: 50)
                }
            }
            .onAppear {
                // 这里可以添加下拉刷新的逻辑，例如设置一个定时器来模拟异步操作
            }
            .onChange(of: showingRefresh) { newValue in
                if newValue {
                    // 开始刷新
                    isRefreshing = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        // 模拟数据刷新
                        items = [Int](1...20)
                        isRefreshing = false
                        showingRefresh = false
                    }
                }
            }
            .onChange(of: showingLoadMore) { newValue in
                if newValue {
                    // 开始加载更多
                    isLoadingMore = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        // 模拟加载更多数据
                        let newItems = (items.last ?? 0) + 1...items.last! + 10
                        items.append(contentsOf: newItems)
                        isLoadingMore = false
                        showingLoadMore = false
                    }
                }
            }
        }
        .overlay(
            VStack {
                if !isRefreshing && !showingRefresh {
                    Button(action: { showingRefresh = true }) {
                        Text("Pull to Refresh")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, -60) // Adjust this value to show the button above the scroll view
                }
                Spacer()
                if !isLoadingMore && !showingLoadMore && !items.isEmpty {
                    Button(action: { showingLoadMore = true }) {
                        Text("Load More")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20) // Adjust this value to show the button below the scroll view
                }
            }
        )
    }
}
  
struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
