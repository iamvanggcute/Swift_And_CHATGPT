import Foundation
struct User {
    let username : String
    var password : String
}
enum authRealt {
    case success
    case fail(reason : String)
}
protocol Authenticatable {
    func login (user : User) -> authRealt
}
extension Authenticatable {
    func PrintLogin (for user : User){
        var status = login(user: user)
        switch status{
        case .success:
            print("PAID SUCCESS")
        case .fail(let reason):
            print("FAIL \(reason)")
        }
        
    }
}
struct LocalAuth : Authenticatable {
    func login(user: User) -> authRealt {
        return .success
    }
}
struct Remoteauth : Authenticatable {
    func login(user: User) -> authRealt {
        guard user.password.count >= 6 else {
            return .fail(reason: "Qua Ngan")
        }
        return .success
    }
}
let A = User(username: "Vang", password: "123456")
let  B = User(username: "Vang", password: "123")
let Dung = LocalAuth ()
let Sai = Remoteauth()
Dung.PrintLogin(for: A)
Sai.PrintLogin(for: B)

struct Package {
    let weitgh : Double
    let distanse : Double
}
protocol shippable {
    func calculateFe(packege : Package) -> Double
}

extension shippable {
    func PrintTb (for package :Package) {
        let fe = calculateFe(packege: package)
        print("fe \(fe)")
    }
}
struct Bikeshippig : shippable {
    func calculateFe(packege: Package) -> Double {
        return packege.distanse * 5000
    }
}
struct Carshippable : shippable {
    func calculateFe(packege: Package) -> Double {
        return packege.distanse * 10000
    }
}
struct ExpressShipping : shippable {
    func calculateFe(packege: Package) -> Double {
        return packege.distanse * 2000 + packege.weitgh * 2000
    }
}
let ShipA = Package(weitgh: 2, distanse: 10)
let Xemay = Bikeshippig()
let Oto = Carshippable()
let Caocap = ExpressShipping()

Xemay.PrintTb(for: ShipA)
Oto.PrintTb(for: ShipA)
Caocap.PrintTb(for: ShipA)
struct Stundent{
    let name : String
    var score : Double
}
protocol Gradable {
    var score : Double {get}
}
extension Stundent: Gradable {}
extension Gradable {
    func XepLoai (for stundent : Stundent) {
        if ( score >= 8 && score <= 10 ) {
            print("A")
        }
        if ( score > 7.5 && score < 8) {
            print("B")
        }
        if ( score >= 6 && score < 7.5) {
            print("C")
        }
        if ( score >= 5 && score < 6) {
            print("D")
        }
        if ( score  < 5 ) {
            print("F")
        }
    }
}
func SinhTTb (stundent : [Stundent]) -> Int {
    var Sum : Int = 0
    for Dem in stundent {
        if ( Dem.score >= 5 ) {
            Sum += 1
        }
    }
    return Sum
}
let HocSinhA = Stundent(name: "Vang", score: 4)
HocSinhA.XepLoai(for: HocSinhA)


struct BankAccount {
    let id : String
    var balance : Double
}
protocol Withdrawable {
  mutating  func withdraw(amount: Double) -> Bool
}

extension Withdrawable {
    
}
struct SavingAccount :  Withdrawable{
    var account : BankAccount
   mutating func withdraw(amount: Double) -> Bool {
        if  account.balance - amount < 0 {
            return false
        }
        account.balance -= amount
        return true
       
    }
}
struct CreditAccount  : Withdrawable{
    var account : BankAccount
    let creditLimit : Double = -5000
   mutating func withdraw(amount: Double) -> Bool {
        if account.balance - amount < creditLimit {
            return false
        }
        account.balance -= amount
        return true
    }
}
extension Withdrawable {
    mutating func logWithdraw(amount: Double) {
        if withdraw(amount: amount) {
            print("Withdraw \(amount) SUCCESS")
        } else {
            print("Withdraw \(amount) FAILED")
        }
    }
}
var saving = SavingAccount(
    account: BankAccount(id: "S01", balance: 3000)
)

var credit = CreditAccount(
    account: BankAccount(id: "C01", balance: 1000)
)

saving.logWithdraw(amount: 2000)   // SUCCESS
saving.logWithdraw(amount: 1500)   // FAILED

credit.logWithdraw(amount: 4000)   // SUCCESS (âm)
credit.logWithdraw(amount: 3000)   // FAILED

protocol Playable {
    var title : String {get}
    func play()
}
struct Song : Playable {
    var title: String
    func play() {
        print("Nhac\(title)")
    }
}
struct Video : Playable{
    var title: String
    func play() {
        print("Phim\(title)")
    }
}
struct Podcast : Playable {
    var title: String
    func play() {
        print("Hahah\(title)")
    }
}
extension Playable {
    func thongbao (){
        print(" Play Now \(title)")
    }
}
let song = Song(title: "Lac Troi")
let video = Video(title: "Avengers")
let podcast = Podcast(title: "Swift Basics")

song.thongbao()
song.play()

video.thongbao()
video.play()
podcast.thongbao()
podcast.play()


enum OrderStatus {
    case pending
    case shipping
    case completed
   case cancelled(reason: String)
    
}
struct Order{
    let id : String
    var status : OrderStatus
}
func TrangThai (status : OrderStatus) {
    switch status {
    case .pending:
        print("Dang Xu Ly")
    case .shipping:
        print("Dang Van Chuyen")
    case .completed:
        print("Da Hoan Thanh")
    case .cancelled(let reason):
        print(reason)
    }
}
let order1 = Order(id: "O01", status: .pending)
let order2 = Order(id: "O02", status: .cancelled(reason: "Hết hàng"))

TrangThai(status: order1.status)
TrangThai(status: order2.status)

struct Emplopy {
    let name : String
    var baseSalary : Double
}
protocol Payable {
    func calculateSalary() -> Double
    var name: String { get }
}
struct FullTimeEmployee : Payable {
    let emplopy : Emplopy
    var name: String {
        emplopy.name
    }
    func calculateSalary() -> Double {
        return emplopy.baseSalary
    }
}
struct PartTimeEmployee : Payable {
    var name: String
    var hour : Int
    var rate : Double
    func calculateSalary() -> Double {
        return  Double(hour) * rate
    }
}
extension Payable {
    func printSalary() {
        print("Employee: \(name) - Salary: \(calculateSalary())")
    }
}
let full = FullTimeEmployee(
    emplopy: Emplopy(name: "Vang", baseSalary: 10_000_000)
)

let part = PartTimeEmployee(
    name: "An",
    hour: 80,
    rate: 50_000
)

full.printSalary()
part.printSalary()

protocol Vehicle {
    var speed : Double {get}
    func move()
}
struct Car : Vehicle{
    var speed: Double
    func move() {
        print("Go \(speed)km/h")
    }
}
struct Bike : Vehicle {
    var speed: Double
    func move() {
        print("Go \(speed)km/h")
    }
}
struct Truck : Vehicle {
    var speed: Double
    func move() {
        print("Go \(speed)km/h")
    }
}
extension Vehicle {
    func PrintSpeed () {
        print("Seed : \(speed) km/h")
    }
    
}
let car = Car(speed: 80)
let bike = Bike(speed: 30)
let truck = Truck(speed: 60)

car.PrintSpeed()
car.move()

bike.PrintSpeed()
bike.move()

truck.PrintSpeed()
truck.move()

protocol Discountable {
    var price: Double { get }
}
struct Product : Discountable{
    var price: Double
}
extension Discountable {
    
    func giamGia (phanTram : Double) -> Double {
        guard (phanTram >= 0 && phanTram <= 100 ) else {
            return price
        }
        return price * (1 - phanTram / 100)
    }
}
func TinhTong (product :[Discountable]) -> Double {
    var Sum : Double = 0
    for Tong in product  {
        Sum += Tong.price
    }
    return Sum
}
let p1 = Product(price: 100)
let p2 = Product(price: 200)

print(p1.giamGia(phanTram: 10)) // 90
print(p2.giamGia(phanTram: 50)) // 100

let total = TinhTong(product: [p1, p2])
print(total) // 300


protocol Loggable {
    func log(message: String)
}
struct FileLogger : Loggable {
    func log(message: String) {
        print("Lydo :\(message)")
    }
}
struct ConsoleLogger : Loggable {
    func log(message: String) {
        print("Lydo :\(message)")
    }
}
struct NetworkLogger : Loggable {
    func log(message: String) {
        print("Lydo :\(message)")
    }
}
extension Loggable {
    func PrintTT (message : String){
        log(message: message)
    }
}
let file = FileLogger()
let console = ConsoleLogger()
let network = NetworkLogger()

file.PrintTT(message: "Lỗi file")
console.PrintTT(message: "Lỗi console")
network.PrintTT(message: "Lỗi mạng")
