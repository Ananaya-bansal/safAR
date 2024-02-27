import SwiftUI

struct HomeView: View {
    
    let imagesData = [
        ("Lotus Temple", "LotusTemple", "Lotus_Temple.usdz", "Bahá'í House of Worship", "Lotus_Temple"),
        ("Taj Mahal", "TajMahal", "TajMahal.usdz", "A Marvel of Love", "TajMahal"),
        ("Black Taj Mahal", "BlackTajmahal", "BlackTajMahal.usdz", "Eternal Tribute to Undying Love", "blacktajmahal"),
        ("India Gate", "IndiaGate", "India_Gate.usdz", "Memorial of Indian Soldiers", "India_Gate"),
        ("Charminar", "charminar", "Charminar.usdz", "Icon of Hyderabad", "charminar"),
        ("Amer Fort", "AmerFort","merFort", "A Royal Heritage", "amer_fort_audio"),
         ("Agra Fort", "AgraFort", "AgraFort","A Mughal Masterpiece", "agra_fort_audio"),
       ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(imagesData, id: \.1) { imageData in
                        NavigationLink(destination: ContentView(title: imageData.0, tagline: imageData.3, usdzFileName: imageData.2, audioFileName: imageData.4, expandSheet: .constant(true), animation: Namespace().wrappedValue)) {
                            VStack {
                                Image(imageData.1)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 180 , maxHeight: 150)
                                    .border(.yellow)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    
                                
                                Text(imageData.0)
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                    .foregroundColor(.black)
                                    
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.white)
            .navigationTitle("Discover")
            .padding(.bottom, 15)
        }
        
       
    }}




    

