import Foundation

class ClockUtil{
    
    private var count :Int = 0
    
    var callBackClock: CallBackClock?
    
    var timer: Timer?
    
    var isRunning: Bool {
          return timer != nil
      }
        
    func start(){
        
        guard timer == nil else { return } 

        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true){
                [weak self] _ in self?.tickAccourd()
            }
        
    }
    
    func stop(){
        timer?.invalidate()
        timer = nil
        count = 0
    }
    
    func pause(){
        timer?.invalidate()
        timer = nil
    }
    
    func resume(){
        start()
    }
    
    @objc private func tickAccourd(){
        
        count += 1
        
        if count > 8 {
            count = 1
        }
        
        callBackClock?.tick(ticks: count)
        print("Tick - \(count)")
        
        }
    
        deinit {
        stop()
    }
}

protocol CallBackClock : AnyObject{
    func tick(ticks: Int)
    
}
