import SwiftUI

struct ContentView: View {
    @State var height: CGFloat = CGFloat(350)
    @State var width: CGFloat = CGFloat(350)
    @ObservedObject var qrCreator = QRCreator()
    @State private var image: Image?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            VStack(alignment: .center, spacing: 10.0) {
                self.qrCreator.result
                    .resizable(resizingMode: .stretch)
                    .scaleEffect(0.9)
                    .aspectRatio(contentMode: .fit)
                    .background(Color.white)
                TextField("Placeholder", text: $qrCreator.text)
                    .background(Color.init(.sRGBLinear, red: 0.0, green: 0.0, blue: 0.0, opacity: 0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.25), lineWidth: 2)
                    )
                    .padding(.all, 3)
                    .font(Font.system(size: 13, weight: .medium, design: .default))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        })
        .onAppear(perform: {
            self.qrCreator.pasteboard()
        })
        //.onReceive(timer) { input in
        //  self.qrCreator.pasteboard()
        //}
        .frame(width: self.width, height: self.height, alignment: .leading)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
