//import UIKit

public class BlinkingLabel: UILabel {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func startBlinking() {

        var options : UIView.AnimationOptions = .repeat
        
        options.insert( .autoreverse )

        UIView.animate(withDuration: 0.25, delay: 0.0, options: options, animations: {

                self.alpha = 0

            }, completion: nil)

        Report().getResponse()
    }

    public func stopBlinking() {

        alpha = 1

        layer.removeAllAnimations()

    }

}

public final class Fiserv_QR_SDK {
    public static func configureAPIKey(_ apiKey: String) {
        Fiserv_QR_SDK_MAIN.setAPIKey(apiKey)
    }
}
