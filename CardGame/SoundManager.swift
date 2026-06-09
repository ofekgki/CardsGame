import AVFoundation
import Foundation

class SoundManager {
    
    static let shared = SoundManager()
        
    private var backgroundPlayer: AVAudioPlayer?
    
    private var effectPlayer: AVAudioPlayer?
    
    private init() {}

    // MARK: - Background Music
    
    func playBackgroundMusic(_ resource: String) {
            
            if backgroundPlayer?.isPlaying == true {
                return
            }
            
            guard let url = Bundle.main.url(forResource: resource, withExtension: "mp3") else {
                print("Music file not found: \(resource).mp3")
                return
            }
            
            do {
                backgroundPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundPlayer?.numberOfLoops = -1
                backgroundPlayer?.volume = 0.25
                backgroundPlayer?.prepareToPlay()
                backgroundPlayer?.play()
            } catch {
                print("Error playing background music: \(error)")
            }
        }

    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
        backgroundPlayer?.currentTime = 0
    }
    
    func pauseBackgroundMusic() {
        backgroundPlayer?.pause()
    }
    
    func resumeBackgroundMusic() {
        backgroundPlayer?.play()
    }
    
    func backgroundMusicWhileGame(){
        backgroundPlayer?.volume = 0.1
    }
    
    func backgroundMusicAfterGame(){
        backgroundPlayer?.volume = 0.25
    }
    
    //MARK: Sound Effects
    
    func playSoundEffect(_ resource: String) {
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "mp3") else {
            print("Sound effect not found: \(resource).mp3")
            return
        }
        
        do {
            effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer?.volume = 1.0
            effectPlayer?.prepareToPlay()
            effectPlayer?.play()
        } catch {
            print("Error playing sound effect: \(error)")
        }
    }
    
    func stopSoundEffect() {
        effectPlayer?.stop()
        effectPlayer?.currentTime = 0
    }
    
    
    func stopAllSounds() {
        backgroundPlayer?.stop()
        backgroundPlayer?.currentTime = 0
        
        effectPlayer?.stop()
        effectPlayer?.currentTime = 0
    }
}

