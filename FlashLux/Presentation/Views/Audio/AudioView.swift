//
//  AudioView.swift
//  FlashLux
//
//  Created by Sophio Kopaliani on 08.02.25.
//

import AVKit
import SwiftUICore
import SwiftUI

class AudioPlayer: ObservableObject {
  private var player: AVPlayer?

  func play(from urlString: String) {
    guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
      print("Invalid URL")
      return
    }

    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setActive(true)

      let playerItem = AVPlayerItem(url: url)
      player = AVPlayer(playerItem: playerItem)
      player?.play()
    } catch {
      print("Audio setup error: \(error)")
    }
  }
}

struct AudioView: View {
  @StateObject private var audioPlayer = AudioPlayer()
  let audioURL: String

  var body: some View {
    Button("Play") {
      audioPlayer.play(from: audioURL)
    }
  }
}
