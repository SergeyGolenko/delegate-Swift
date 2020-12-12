import Foundation

/*И к тому же мы использовали некий сторонний код «снаружи» классов официанта и повара, которому необходимо иметь доступ к private свойствам и методам этих классов. А как официанту передать "изнутри" себя, используя встроенные свойства и методы своего класса? Тот же вопрос со стороны повара: "Как ему приготовить то, что известно только официанту, используя свойства и методы своего класса?"


Тут на помощь приходит "лифт". В этот лифт официант кладет записку с заказом. А повар берет записку из лифта и ставит в лифт готовое блюдо для передачи повару. Такой "лифт" реализуется через протокол "Взаимообмен через лифт":*/
protocol InterchngeVialElevatorProtocol{
    func cookOrder(order:String) -> Bool
}
/*В данном случае мы говорим, что у лифта есть "интерфейс", который должен быть понятен и официанту, и повару. То есть правила взаимообмена через этот лифт. Правила взаимообмена должны знать и официант, и повар. Они простые: официант кладет записку, а повар готовит по ней.*/



// Создаём класс официанта
class Waiter{
    
    // Далее официанту добаим свойство "получатель заказа через лифт". Официанту известно, что этот получатель знает правила и приготовит то, что в записке.
    
    //Это свойство и есть делегат!!!
    var  receiverOfOrderViaElevator: InterchngeVialElevatorProtocol?
    
    ///Свойство заказ - опциональная информация о текущем заказе. О заказе может узнать только официант, поэтому "private".
    private var order: String?
    
    ///Метод "принять заказ".
    func takeOrder(_ food: String){
        print("What would you like?")
        print("Yes, of course!")
        order = food
        sendeOrderToCook()
    }
    
    /*Можно теперь доделать у класса «Официант» метод передачи заказа, чтобы официант мог делать это «изнутри себя», то есть используя свои собственные свойства и методы, а не указания со стороны.*/
    ///Метод "отправить заказ повару". Мог бы сделать только официант. Но как?
    func sendeOrderToCook(){
        // ? Как передать повару заказ?
        // А вот так бляатььь
        receiverOfOrderViaElevator?.cookOrder(order: order!)
    }
    
    
    /// Метод "доставить блюдо клиенту". Умеет только официант.
    private func serveFood(){
        print("Your \(order!). Enjoy your meal!")
    }
}






// Создаем класс повара

class Cook: InterchngeVialElevatorProtocol {
    /// Свойство "cковорода". Есть только у повара.
    private let pan: Int = 1
    
    /// Свойство "плита". Есть только у повара.
    private let stove: Int = 1
    
    ///Метод "приготовить". Умеет только повар.
    private func cookFood(_ food:String) -> Bool{
              print("Let's take a pan")
              print("Let's put \(food) on the pan")
              print("Let's put the pan on the stove")
              print("Wait a few minutes")
              print("\(food) is ready!")
              return true
    }
    
    //Необходимый метод, согласно правилу(протоколу):
    //В этом методе мы вызовем ранее созданный метод cookFood, который повар умеет выполнять.
    func cookOrder(order: String) -> Bool {
        cookFood(order)
    }
    
}


// Создаём класс шеф-повара

class Chef : InterchngeVialElevatorProtocol{
    
    
    private let pan: Int = 1
    private let stove: Int = 1
    
    private func cookFood(_ food: String) -> Bool {
             print("Let's take a pan")
             print("Let's put \(food) on the pan")
             print("Let's put the pan on the stove")
             print("Wait a few minutes")
             print("\(food) is ready!")
             return true
    }
    // Необходимый метод, согласно правилу (протоколу):
    func cookOrder(order: String) -> Bool {
        cookFood(order)
    }
    
    //Шеф-повар умеет нанимать официантов в свое кафе:
    func hireWaiter() -> Waiter {
        return Waiter()
    }
    
}



/*
 Отлично. А теперь представим, что появился новый шеф-повар, который рассказывает официанту ещё при найме на работу, что его «получателем заказа через лифт» будет сам шеф-повар.
 */

class SmartChief: Chef {
    
    override func hireWaiter() -> Waiter {
        let waiter = Waiter()
        waiter.receiverOfOrderViaElevator = self
        return waiter
    }
    
}



//Теперь создаем их экземпляры(нанимаем на работу) и просим официанта получить заказ(курицу):

//Нанимаем на работу официанта и повара (создаем экземпляры):
let waiter = Waiter()
let cook = Cook()
//Создаем экземпляр шеф-повара
let chief = Chef()
//Шеф-повар нанимает официанта:
chief.hireWaiter()
//Добавим официанту заказ
waiter.takeOrder("Apple")

//сначала скажем официанту получить заказ.Допустим, он получает курицу:
waiter.takeOrder("Chiken")


/*
 Как теперь официанту передать повару, что ему приготовить?


 Конечно, можно было бы написать ниже вот так, если бы свойства и методы официанта и повара не были private. Но так как у них уровень доступа private, то это не сработает:
 */

// Теперь скажем официанту, что его  "получатель заказа через лифт" - это наш повар:
waiter.receiverOfOrderViaElevator = cook
// Обучаем официанта, что его "получатель заказа через лифт" - это наш шеф-повар:
waiter.receiverOfOrderViaElevator = chief

waiter.sendeOrderToCook()

//Теперь официант может нашего "получателя через лифт" попросить приготовить заказ:
//waiter.receiverOfOrderViaElevator?.cookOrder(order: waiter.order!) так не работает потому что метод private







