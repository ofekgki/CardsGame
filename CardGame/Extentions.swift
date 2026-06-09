import UIKit
import CoreLocation

//MARK: Toast

extension UIViewController {
    
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        
        let maxWidth = view.frame.width - 48
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        
        toastLabel.frame = CGRect(
            x: 24,
            y: view.frame.height - textSize.height - 100,
            width: maxWidth,
            height: textSize.height + 24
        )
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}

//MARK: Game Scene
extension  GameScene: CallBackClock {
    
    func tick(ticks: Int) {
        updateUI(value: ticks)
    }
    
    }

extension GameScene {
    
    struct Card {
        let name: String
        let value: Int
        let imageName: String
        
    }
}

// MARK: Main Scene

extension MainScene: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {

        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            print("Access to location granted")

        case .denied, .restricted:
            showToast(message: "Location permission denied")
            print("Access to location denied")

        case .notDetermined:
            showToast(message: "Waiting for permission")
            print("Access to location not determined")

        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        print("Latitude: \(latitude)")
        print("Longitude: \(longitude)")
        
        lat = latitude
        
        print(lat)

        // If you only need location once:
        manager.stopUpdatingLocation()
        
        getLocation()
    }

}
