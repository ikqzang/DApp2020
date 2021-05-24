pragma solidity >=0.5.0;

contract Delottery {
    struct player {
        address playerId;
        uint lottoNum;
        uint amount;
    } 
    mapping (address => player) players;

    function bookLotto(uint _lottoNum,uint _amount) public returns (address,bool){            
        bool result = false;                                                          
        address _user = msg.sender;                                                   
        players[_user] = player({                                                     
        playerId : _user,                                                             
        lottoNum : _lottoNum,                                                         
        amount : _amount                                                              
        });                                                                           
        result = true;                                                                
        return (_user,result);                                                              
    }

    function getBooking(address _playerid,uint _lottoNum,uint _amount) public view returns (uint) {
        uint result = 0;   
         
        player memory booking = players[_playerid];
        if (booking.playerId == _playerid){
            result += 1;
        } 
        if (booking.lottoNum == _lottoNum){
            result += 1;
        } 
        if (booking.amount == _amount){
            result += 1;
        } 
        
        return (result);
    }


}
    
