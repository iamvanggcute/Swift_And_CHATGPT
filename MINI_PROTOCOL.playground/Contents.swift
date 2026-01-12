import Foundation

struct Student {
    let id : Int
    let name : String
    var score : Double
}
protocol Gradable {
    var score : Double {get}
    func grade () -> String
}
extension Gradable {
    func grade () -> String {
        switch score {
        case 8...10 :
            return "A"
        case 7.5..<8:
            return "B"
        case 6..<7.5 :
            return "C"
        case 5..<6:
            return "D"
        default :
            return "F"
        }
    }
}
extension Student: Gradable {}
protocol Loggable {
    func log(message: String)
}

struct ConsoleLogger: Loggable {
    func log(message: String) {
        print("📘 LOG:", message)
    }
}

struct FileLogger: Loggable {
    func log(message: String) {
        print("📂 FILE LOG:", message)
    }
}
struct ClassRoom {
  private(set)  var students: [Student]
    let logger : Loggable
    mutating func addStudent (_ student : Student) {
        students.append(student)
        logger.log(message: "Them Sinh Vien \(student.name)")
    }
    
    mutating func remvoStudent ( id : Int){
        students.removeAll{ $0.id == id}
        logger.log(message: "Da Vua Xoa Id \(id)")
    }
    func countPassed () -> Int {
        students.filter { $0.score >= 5 }.count
    }
    func averageScore() -> Double  {
        var sum : Double = 0
      //  var index = students.count
        for tinhTong in students {
            sum += tinhTong.score
        }
        return sum / Double(students.count)
    }
    func topStudent () -> Student? {
        students.max { $0.score < $1.score}
    }
}
let logger = ConsoleLogger()

var classroom = ClassRoom(students: [], logger: logger)

let s1 = Student(id: 1, name: "Vang", score: 8.5)
let s2 = Student(id: 2, name: "An", score: 4.5)
let s3 = Student(id: 3, name: "Binh", score: 6.8)

classroom.addStudent(s1)
classroom.addStudent(s2)
classroom.addStudent(s3)
classroom.remvoStudent(id: 2)

print("Số sinh viên đạt:", classroom.countPassed())
print("Điểm trung bình:", classroom.averageScore())

if let top = classroom.topStudent() {
    print("Sinh viên giỏi nhất:", top.name, "-", top.grade())
}



