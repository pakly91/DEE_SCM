pragma solidity ^0.4.18;

pragma solidity ^0.4.0;

contract EnergyBlockchain {

    function  EnergyBlockchain() public payable {}
    mapping(address => int) public tokens;
    event OnValueChanged(address indexed _from, int _value);

    address public pvAddr = 0xd04849700624743A498697d6AdB30E51aAfC48DD;
    address public batteryAddr = 0x488995B31410a04F272c5C8b6a190d9DD3aDc9b3;
    address public chpAddr = 0xA5ef7463BF5f708E4766603166Bb32D298ac5Ccb;
    address public netwAddr = 0xb9b1BdE776fC757E0c26bf3b9D0c9E29755a866E;
    address public loadAddr = 0x329026EBD6c29fa6bb573114F8F0E3a2F44f5C38;

     int public pv_token;
     int public load_token;
     int public battery_token;
     int public netw_token;
     int public chp_token;

     uint public pvAccount;
     uint public batteryAccount;
     uint public chpAccount;
     uint public netwAccount;
     uint public loadAccount;
    
    int public loadPrice;
    int public pvPrice;
    int public batteryPrice;
    int public netwPrice;
    int public chpPrice;


    function bid(int loadPrice1,int pvPrice1, int batteryPrice1, int netwPrice1, int chpPrice1) public{
        loadPrice = loadPrice1;
        pvPrice = pvPrice1;
        batteryPrice = batteryPrice1;
        netwPrice = netwPrice1;
        chpPrice = chpPrice1;
    }


    function energyToken(int pvKw, int loadKw,  int batteryKw, int netwKw, int chpKw) public returns (bool success){

        pv_token = pvKw*pvPrice;
        load_token = loadKw*loadPrice;
        battery_token = batteryKw*batteryPrice;
        netw_token = netwKw*netwPrice;
        chp_token = chpKw*chpPrice;

        return true;
    }

    function payme() payable public{
        if (msg.sender == pvAddr){
            pvAccount += (msg.value);
        }
        if (msg.sender == batteryAddr){
            batteryAccount += msg.value;
        } 
        if (msg.sender == chpAddr){
            chpAccount += msg.value;
        } 
        if (msg.sender == netwAddr){
            netwAccount += msg.value;
        } 
        if (msg.sender == loadAddr){
            loadAccount += msg.value;
        } 
    }



    function depositTokens() public returns (bool success) {
        uint send;
        if (msg.sender == pvAddr){
            send = pvAccount;
        }
        if (msg.sender == batteryAddr){
             send = batteryAccount;
        } 
        if (msg.sender == chpAddr){
             send = chpAccount;
        } 
        if (msg.sender == netwAddr){
             send = netwAccount;
        } 
        if (msg.sender == loadAddr){
             send = loadAccount;
        } 

        if (convertToInt(pv_token + battery_token + netw_token + load_token + chp_token) <= send){

          if (msg.sender == pvAddr){
             pvAccount -= (convertToInt(pv_token + battery_token + netw_token + load_token + chp_token));
        }
        if (msg.sender == batteryAddr){
              batteryAccount -= (convertToInt(pv_token + battery_token + netw_token + load_token + chp_token));
        } 
        if (msg.sender == chpAddr){
              chpAccount -= (convertToInt(pv_token + battery_token + netw_token + load_token + chp_token));
        } 
        if (msg.sender == netwAddr){
              netwAccount -= (convertToInt(pv_token + battery_token + netw_token + load_token + chp_token));
        } 
        if (msg.sender == loadAddr){
              loadAccount -=(convertToInt(pv_token + battery_token + netw_token + load_token + chp_token));
        }    

        //tokens[pvAddr] += pv_token;
        

               pvAddr.transfer(convertToInt(pv_token));
        

    
        //tokens[batteryAddr] += battery_token;
        batteryAddr.transfer(convertToInt(battery_token));
        
        
        //tokens[netwAddr] += netw_token;
        netwAddr.transfer(convertToInt(netw_token));

        //tokens[loadAddr] -= load_token;
        loadAddr.transfer(convertToInt(load_token));

        //tokens[chpAddr] += chp_token;
        chpAddr.transfer(convertToInt(chp_token));

        emit OnValueChanged(pvAddr, tokens[pvAddr]);
        emit OnValueChanged(batteryAddr, tokens[batteryAddr]);
        emit OnValueChanged(netwAddr, tokens[netwAddr]);
        emit OnValueChanged(loadAddr, tokens[loadAddr]);
        emit OnValueChanged(chpAddr, tokens[chpAddr]);
        }
        pv_token = 0;
        load_token = 0;
        battery_token = 0;
        netw_token = 0;
        chp_token = 0;
        return true;

    }
/*
    function withdrawToken(address recipient, int value) public returns (bool success) {
        if (int(tokens[recipient] - value) < 0) {
            tokens[recipient] = 0;
        } else {
            tokens[recipient] -= value;
        }
        emit OnValueChanged(recipient, tokens[recipient]);
        return true;
    }
  */

    function getTokens(address x) public constant returns (int value) {
        return tokens[x];
    }


    function convertToInt(int old) public pure returns (uint converted) {
        if(old < 0) {
                converted = 1000000000000000000*(uint(-old));
        }
        else {
            converted= 1000000000000000000*(uint(old));
    }





}

}