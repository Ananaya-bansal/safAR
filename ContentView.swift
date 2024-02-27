import SwiftUI
import AVKit
import SceneKit

struct ContentView: View {
    let title: String
    let tagline: String
    let usdzFileName: String
    let audioFileName: String
    
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animationContent: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                   .fill(.ultraThickMaterial)
                    .overlay(
                        content: {
                            Rectangle()
                                .fill(Color.clear)
                                .background(
                                    Image("charminar")
                                        .blur(radius: 50)
                                        .grayscale(0.5)
                                        
                                )
                        }
                    )
                
                VStack(spacing: 15) {
                    GeometryReader { innerGeometry in
                        let size = innerGeometry.size
                        ARView(usdzFileName: usdzFileName)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .frame(height: geometry.size.width - 50)
                    .padding(.vertical, geometry.size.height < 700 ? 10 : 30)
                    
                    PlayerView(geometry.size)
                }
                .padding(.top, geometry.safeAreaInsets.top + (geometry.safeAreaInsets.bottom == 0 ? 10 : 0))
                .padding(.bottom, geometry.safeAreaInsets.bottom == 0 ? 10 : geometry.safeAreaInsets.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .ignoresSafeArea(.container, edges: .all)
        }
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
    }
    
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print("Error loading audio: \(error)")
        }
    }
    
    private func playAudio() {
        player?.play()
        isPlaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: .center, spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text(tagline)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                           
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .padding(12)
                                .background{
                                    Circle().fill(.ultraThinMaterial).environment(\.colorScheme, .light)
                                }
                        }
                    }
                    VStack(alignment: .leading, spacing: 4) {  
                        Slider(value: Binding(get: {
                            currentTime
                        }, set: { newValue in
                            seekAudio(to: newValue)
                        }), in: 0...totalTime)
                        .accentColor(.white)
                        
                        HStack {
                            Text(timeString(time: currentTime))
                                .foregroundColor(.white)
                            Spacer()
                            Text(timeString(time: totalTime))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: size.height / 2.5, alignment: .top)
                    
                    HStack(spacing: size.width * 0.18) {
                        Button {
                           
                        } label: {
                            Image(systemName: "backward.fill")
                                .font(size.height < 300 ? .title3 : .title)
                        }
                        
                        Button {
                            isPlaying ? stopAudio() : playAudio()
                        } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(size.height < 300 ? .largeTitle : .system(size: 50))
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "forward.fill")
                                .font(size.height < 300 ? .title3 : .title)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: spacing) {
                        HStack(spacing: 15) {
                            Image(systemName: "speaker.fill")
                                .foregroundColor(.white)
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .environment(\.colorScheme, .light)
                                .frame(height: 5)
                            
                            Image(systemName: "speaker.wave.3.fill")
                                .foregroundColor(.white)
                        }
                        
                        HStack(alignment: .top, spacing: size.width * 0.18) {
                            VStack(spacing: 6) {
                                Button {
                                   
                                } label: {
                                    Image(systemName: "airpodspro.chargingcase.wireless.fill")
                                        .font(.title2)
                                }
                                Text("Airpods")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        .foregroundColor(.white)
                        .blendMode(.overlay)
                        .padding(.top, spacing)
                    }
                    .frame(height: size.height / 2.5, alignment: .bottom)
                }
            }
        }
    }
}

