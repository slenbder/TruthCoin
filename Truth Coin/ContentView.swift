import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                CoinView()
                    .frame(width: 350, height: 350)
                    .background(Color.clear)
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}

struct CoinView: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene()
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = UIColor.clear
        
        if let coinScene = SCNScene(named: "Coin.scn") {
            if let coinNode = coinScene.rootNode.childNodes.first {
                let parentNode = SCNNode()
                parentNode.addChildNode(coinNode)
                
                // Масштабируем родительский узел
                parentNode.scale = SCNVector3(0.01, 0.01, 0.01) // Уменьшаем размер монеты
                
                // Устанавливаем позицию родительского узла
                parentNode.position = SCNVector3(0, 0, 0) // Центруем монетку
                
                sceneView.scene?.rootNode.addChildNode(parentNode)
                
                let rotationAnimation = CABasicAnimation(keyPath: "rotation") // Вертим монетку на хуе
                rotationAnimation.fromValue = SCNVector4(0, 1, 0, 0)
                rotationAnimation.toValue = SCNVector4(0, 1, 0, CGFloat.pi * 2)
                
                parentNode.addAnimation(rotationAnimation, forKey: "rotation")
            }
        }
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
