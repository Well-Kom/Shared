//
//  QuestionsMainView.swift
//  QuestionnaireSample
//
//  Created by Lokesh Sahni on 28/06/21.
//

import SwiftUI


struct QuestionsMainView: View {
    
    
    /// List of sample questions
    @State var questions: [Question] = [
        Question(id: 0, question: "Physical Health", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 1, question: "Leisure", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 2, question: "Social friends", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 3, question: "Working atmosphere", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 4, question: "Family", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 5, question: "Work colleagues", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 6, question: "Job security", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 7, question: "Working atmosphere", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 8, question: "Family", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 9, question: "Work colleagues", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: ""),
        Question(id: 10, question: "Job security", options: ["Very dissatisfied","Dissatisfied","Neutral","Satisfied","Very satisfied"],selectedanswer: "")
           ]
    
    // 2
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(1) * 2.5
        return geometry.size.width - offset
    }
    
    @State var questionindex:Int = 0
    @State var selecteddimension: String = ""
    @State var selecteddimensionid: String = ""
    
    // 3
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(questions.count - 1 - id) * 4.0
    }
    
    private var maxID: Int {
        return self.questions.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Rectangle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 1.5)
                
                VStack(spacing: 45) {
                    
                    DimensionUIView()
                    ZStack {
                        
                        ForEach(self.questions.reversed(), id: \.self) { question in
                            Group {
                                // Range Operator
                                if 0...self.maxID ~= question.id {
                                    QuestionCardView(question: question, onRemove: { removedUser in
                                        // Remove that user from our array
                                        self.questions.removeAll { $0.id == removedUser.id }
                                    })
                                        .animation(.spring())
                                        .frame(width: self.getCardWidth(geometry, id: question.id), height: 400)
                                        .offset(x: 0, y: self.getCardOffset(geometry, id: question.id))
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }.padding()
    }

}

struct QuestionsMainView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsMainView()
    }
}
