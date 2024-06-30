
import SwiftUI

struct CategoryView: View {
    
    @Binding var isCurrentPage:Bool
    
    @State private var progress = 0.5
  
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
      
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                
                LazyVGrid(columns: columns, spacing: 0) {
                           ForEach(0..<100) { index in
                               Text("Item \(index)")
                                   .padding()
                                   .background(Color.blue.opacity(0.5))
                                   .cornerRadius(10)
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
        
    }
}
