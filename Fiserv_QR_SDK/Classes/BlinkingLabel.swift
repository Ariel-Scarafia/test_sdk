//import UIKit

public class BlinkingLabel: UILabel {

    @SharedInstance(\.testRepositoryProvider) private var testRepository: TestService
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    public func startBlinking() {

        var options : UIViewAnimationOptions = .repeat
        
        options.insert( .autoreverse )

        UIView.animate(withDuration: 0.25, delay: 0.0, options: options, animations: {

                self.alpha = 0

            }, completion: nil)

    }

    public func stopBlinking() {

        alpha = 1

        layer.removeAllAnimations()

        Task {
            do {
                let response = try await testRepository.getData()
                print("**** Data is: \(response.first)")
            } catch {
                print("There was an error: \(error)")
            }
        }
    }

}

extension Fiserv_QR_SDK {
    public static func configureAPIKey(_ apiKey: String) {
        self.setAPIKey(apiKey)
    }
}
