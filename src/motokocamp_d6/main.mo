
import Time "mo:base/Time";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import List "mo:base/List";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Option "mo:base/Option";
import Debug "mo:base/Debug";
import HTTP "http";
// actor {

//     type Time = Time.Time;
//     public type Health = {
//         #invicible;
//         #alive : Nat;
//         #dead : Time;
//     };

//     public func medical_check(h : Health) : async Text {
//         switch(h){
//             case(#invicible) {
//                 return("Woah I've never seen someone with s much energy !");
//             };
//             case(#alive(n)){
//                 return("You seem to be in good shape, you have " # Nat.toText(n) # " energy points");
//             };
//             case(#dead(t))
//                 return("💀 since " # Int.toText(t));
//             };
//         };
//     };
// }


actor {
//c1 
    public type TokenIndex = Nat;
    public type Error = {
        #ok  : Text;
        #err : Text;
    };
//c2
    let registry : HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash);

//c3 

    stable var nextTokenIndex : Nat = 0;
    public shared({caller}) func mint() : async Result.Result<Text, Text>{
        switch(Principal.toText(caller) == "2vxsx-fae"){
            case true { #err("Error: because of anonymous principal")};
            case false { 
                registry.put(nextTokenIndex, caller);
                nextTokenIndex += 1;
                #ok("Your mint success !!")
            };
        };
    };


//c4
    public func transfer(to: Principal, tokenIndex: Nat): async Result.Result<Text, Text>{
        let principal_ : ?Principal = registry.get(tokenIndex);
        switch(principal_){
            case (?_) {
                let before_princpal : ?Principal = registry.remove(tokenIndex);
                registry.put(tokenIndex, to);
                #ok("Transfer Success");
            };
            case (null) {
                #err("Transfer Error");
            };
        };
    };






}