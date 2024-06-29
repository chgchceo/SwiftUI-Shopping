
import SwiftUI

struct CategoryView: View {
    
    @Binding var isCurrentPage:Bool
    
    @State private var progress = 0.5
  
    var body: some View {
        
        NavigationView {
            VStack(spacing: 20) {
                ProgressView(value: progress)
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                
                
                Text("Loading...")
                
                Button("Increase Progress") {
                    withAnimation {
                        progress += 0.1
                        if progress > 1 {
                            progress = 1
                        }
                    }
                }
            }.navigationBarTitle("分类", displayMode: .inline)
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
            
        }
        .onDisappear(){
            
            
        }
        .padding()
    }
}
