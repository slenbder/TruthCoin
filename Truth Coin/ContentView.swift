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

        if let sceneURL = Bundle.main.url(forResource: "moneta", withExtension: "obj"),
           let sceneSource = SCNSceneSource(url: sceneURL, options: nil) {
            do {
                let scene = try sceneSource.scene(options: nil)
                let node = scene.rootNode.childNodes.first
                node?.scale = SCNVector3(0.01, 0.01, 0.01) // Уменьшаем размер монеты
                sceneView.scene?.rootNode.addChildNode(node!)
            } catch {
                print("Ошибка загрузки сцены: \(error)")
            }
        }
        
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
