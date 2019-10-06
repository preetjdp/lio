class Encryption{

  var Encapsulator = [' ','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','0','1','2','3','4','5','6','7','8','9','!','@','#','?','.'];


  String encrypt(String data){
  String encrypted ="";
  for(var m in data.split('')){
    if(Encapsulator.contains(m)){
      encrypted = encrypted + Encapsulator.indexOf(m).toString();
    }
    else{
      encrypted = encrypted + m;
    }
    encrypted = encrypted + " ";
  }
  return encrypted;
}




  String decrypt(String data){
  String decrypted = "";
  for(var m in data.split(' ')){
    var a;
    try{
      a = Encapsulator[int.parse(m)];
    }
    catch(e){
      a = m;
    }
    finally{
      decrypted = decrypted+a;
    }
  }
  return decrypted;
}

}