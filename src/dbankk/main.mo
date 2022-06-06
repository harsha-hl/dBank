import Debug "mo:base/Debug"; //Used to access print function
import Time "mo:base/Time";
import Float "mo:base/Float";
//Create class DBank that holds our canister
actor DBankk{ //See motoko language docs/ style guides for more info.
  stable var currentValue: Float = 300; //Stable provides orthogonal persistence, so even after cycles/redeploying the value of currenvalue is retained and is not intialised back to 300.
  // currentValue := 100;   //This replaces whatever value with 100(doesnt matter if its stable variable or not)
  // let id = 3943094309; //Initialise a constant...id value cannot be changed/updated
  stable var startTime = Time.now();
  // startTime := Time.now();
  // Debug.print("Hello"); this works as it is text passed
  // Debug.print(debug_show(id)); //To display a variable,constant etc anything thats not a string
  public func topUp(amount: Float){  //Not Pr ivate function as it has public keyword and can be accessed from outside this class as well,otherwise it can be accessed only within this class(actor)
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };  //important to end even funcitons with ;
  // topUp();  //TO call this function outside , run 'dfx deploy' and then 'dfx canister call dbank topUp' in terminal. Note dbank is project name , not class name
  public func withdraw(amount: Float){
    let amt: Float = currentValue - amount;
    if(amt >= 0){
      currentValue -= amount;
    Debug.print(debug_show(currentValue));
    }
    else Debug.print("Amount to large to withdraw. Insufficient balance");
  };

  public func compound(){
    let currentTime = Time.now();
    var timeElapsed = (currentTime - startTime)/1000000000;
    currentValue := currentValue * (1.00005 ** Float.fromInt(timeElapsed));
    startTime := currentTime;
  };

  //topUp and withdraw are update methods(modify on the bloclchain), checkBalance is query method(doesn't modify anything on blockchain)
  public query func checkBalance(): async Float{ //Nat indicates return data type and it should be asynchronous for query methods
    return currentValue;
  };

}
