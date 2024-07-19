//import UIKit

public class BlinkingLabel: UILabel {

    @SharedInstance(\.testRepositoryProvider) private var testRepository: TestService
    
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
