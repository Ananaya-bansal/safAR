import SwiftUI
import SceneKit

struct ARView: View {
    var usdzFileName: String // Property to hold the filename or path of the USDZ file
    var sceneOne: SCNScene? // Optional SCNScene
    
    var options: SceneView.Options = [.autoenablesDefaultLighting, .allowsCameraControl]
    
    init(usdzFileName: String) {
        self.usdzFileName = usdzFileName
        self.sceneOne = SCNScene(named: usdzFileName)
        if usdzFileName == "TajMahal.usdz" {
               self.sceneOne?.background.contents = UIColor.darkGray
        } else {
               // Set background color for other USDZ files
               // For example:
               self.sceneOne?.background.contents = UIColor.systemGray3
           }
    }
    
    var body: some View {
            ZStack {
            if let scene = sceneOne {
                SceneView(scene: scene, options: options)
            } else {
                Text("Under Development ! Kindly look at first 2 monuments for reference !!")
                    .foregroundColor(.white)
                    
            }
        }
    }
}




