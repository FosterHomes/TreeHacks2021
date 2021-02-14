import SwiftUI
struct MultiTextField : UIViewRepresentable {
    func makeCoordinator() -> MultiTextField.Cord {
        return MultiTextField.Cord(parent1: self)
    }
    @EnvironmentObject var Obj: Observed
    @Binding var Text : String
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 19)
        view.text = "Type something"
        view.textColor = UIColor.black.withAlphaComponent(0.35)
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        self.Obj.size = view.contentSize.height
        view.isEditable = true;
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        return view
        
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        
        
        
    }
    
    class Cord : NSObject, UITextViewDelegate {
        var Parent : MultiTextField
        
        init(parent1: MultiTextField) {
            Parent = parent1
            
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
            
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.Parent.Obj.size = textView.contentSize.height
            Parent.Text = textView.text
        }
    }
    
    
    
    
    
}
struct TextSide : View {
    var Texts : String
    var body: some View {
        HStack {
            Text(Texts).fontWeight(.bold).font(.headline)
            Spacer()
        }
    }
}
class Observed : ObservableObject {
    @Published var size : CGFloat  =  0
}
struct TabssBarss : View {
    @Binding var selected : String
    var body: some View {
        HStack (spacing: 60) {
           
            Button(action : {
                self.selected = "Programs"
            }) {
                VStack {
                    Image(systemName: "newspaper.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.white)
                        .opacity(selected == "Programs" ? 1 : 0)
                }
            }
            
            Button(action : {
                self.selected = "Events"
            }) {
                VStack {
                    Image(systemName: "house.circle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.white)
                        .opacity(selected == "Events" ? 1 : 0)
                }
            }
            
            Button(action : {
                self.selected = "Gallery"
            }) {
                VStack {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.white)
                        .opacity(selected == "Gallery" ? 1 : 0)
                }
            }
            
            
        }
        .frame(height: 84)
        .frame(maxWidth: .infinity)
        .background(Color("Fav"))
        .cornerRadius(20)
    }
}
