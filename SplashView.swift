import SwiftUI

struct SplashView: View {
    var body: some View {
        // Background image with full screen coverage
        Image("splash")
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Simulate a delay for splash screen, then navigate to the main view
               DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                  
                    let mainView = HomeView()
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: mainView)
                }
            }
    }
}

