//
//  ViewController.swift
//  ThreeRows
//
//  Created by Jonathan Wåger on 2023-09-12.
//

import UIKit

enum Player {
    case player1
    case player2

    var symbol: String {
        switch self {
        case .player1: return "X"
        case .player2: return "O"
        }
    }
    var turn: String{
        switch self {
        case .player1: return "1"
        case .player2: return "2"
        }
    }
}

class ViewController: UIViewController {
    
    var currentPlayer: Player = .player1
    var boardCount = 0
    
    @IBOutlet var btns: [UIButton]!

    
 
    @IBOutlet var status: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Hello
        status.text = "Player \(currentPlayer.turn)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        /*let fontSize: CGFloat = 50
            let font = UIFont.systemFont(ofSize: fontSize)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
            ]
            
            let attributedTitle = NSAttributedString(string: "X", attributes: attributes)
            sender.setAttributedTitle(attributedTitle, for: .normal)
         */
        if sender.title(for: .normal) == nil {
            let fontSize: CGFloat = 50
            let font = UIFont.systemFont(ofSize: fontSize)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
            ]
            let attributedTitle = NSAttributedString(string:currentPlayer.symbol, attributes: attributes)
            sender.setAttributedTitle(attributedTitle, for: .normal)
            boardCount += 1
            if checkWin() {
                // Handle win condition
                status.text = "Player \(currentPlayer.turn) wins!"
                disableAllButtons()
            } else if isBoardFull() {
                status.text = "Draw"
                disableAllButtons()
            } else {
                togglePlayer()
            }
        }
    }
    
    func checkWin() -> Bool {
        let board = btns.map { $0.attributedTitle(for: .normal) }

        for i in stride(from: 0, to: 9, by: 3) {
            if let title1 = board[i], let title2 = board[i + 1], let title3 = board[i + 2],
               title1 == title2 && title1 == title3 {
                return true
            }
        }

        for i in 0..<3 {
            if let title1 = board[i], let title2 = board[i + 3], let title3 = board[i + 6],
               title1 == title2 && title1 == title3 {
                return true
            }
        }

        if let title0 = board[0], let title4 = board[4], let title8 = board[8],
           title0 == title4 && title0 == title8 {
            return true
        }
        if let title2 = board[2], let title4 = board[4], let title6 = board[6],
           title2 == title4 && title2 == title6 {
            return true
        }

        return false
    }

    
    /*func isBoardFull() -> Bool {
     //Working draw
        return boardCount==9
    }
     */
    func isBoardFull() -> Bool {
        for button in btns {
            if button.attributedTitle(for: .normal) == nil {
                return false
            }
        }
        return true
    }


    
    func togglePlayer() {
        currentPlayer = (currentPlayer == .player1) ? .player2 : .player1
        status.text = "Player \(currentPlayer.turn)"
    }
    
    func disableAllButtons() {
        for button in btns {
            button.isEnabled = false
        }
    }

}

