//
//  ContentView.swift
//  FestiveSoundboard
//
//  Created by The Coding Sprite on 19/12/2024.
//

import SwiftUI
import AVFoundation

/// Atributions for sounds - All from freesound.org
// Jingle bells.wav by juskiddink -- https://freesound.org/s/110158/ -- License: Attribution 4.0
// Sleigh Bells 154BPM.wav by JustinAmolsch -- https://freesound.org/s/547582/ -- License: Attribution 3.0
// Ho Ho Ho, Merry Christmas! by Cloud-10 -- https://freesound.org/s/536245/ -- License: Creative Commons 0
// Silencyo_CC_Fire in Fireplace_Close Up_Reverberant.aif by silencyo -- https://freesound.org/s/81800/ -- License: Creative Commons 0
// Christmas Elf Talking by AudioRichter -- https://freesound.org/s/328387/ -- License: Attribution 4.0
// 221214_2264_FR_BrassBandIndoor.wav by kevp888 -- https://freesound.org/s/666573/ -- License: Attribution 4.0

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    let sounds: [(name: String, color: Color, file: String)] = [
        ("Jingle Bells", .red, "jingle-bells"),
        ("Santa", .green, "santa"),
        ("Sleigh Bells", .blue, "sleigh-bells"),
        ("Fireplace", .purple, "fireplace"),
        ("Brass Band", .orange, "brass-band"),
        ("Elf Chatter", .yellow, "elf-chatting")
    ]
    
    
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                Text("Festive Soundboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .padding(.top)
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                
                Spacer()
                
                // Sound Buttons
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(sounds, id: \.0) { sound in
                        Button {
                            playSound(named: sound.file)
                        } label: {
                            Text(sound.name)
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                                .background(sound.color)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 3)
                    .overlay(Color.black.opacity(0.2))
                    .ignoresSafeArea()
                )
        }
    }
    
    /// Unpack the file with thr right extension before we can play the sound
    func playSound(named fileName: String) {
        // Attempt to load .mp3 file
        if let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
            playAudio(from: url)
            return
        }
        
        // Attempt to load .wav file
        if let url = Bundle.main.url(forResource: fileName, withExtension: "wav") {
            playAudio(from: url)
            return
        }
        
        // Attempt to load .aiff file
        if let url = Bundle.main.url(forResource: fileName, withExtension: "aiff") {
            playAudio(from: url)
            return
        }
        
        print("Sound file \(fileName) not found.")
    }
    /// Play the sound
    private func playAudio(from url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    ContentView()
}
