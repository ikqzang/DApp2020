pragma solidity >=0.5.0;

contract Delottery {
    struct player {
        uint lottoNum;
        uint amount;
    } 
    mapping (address => player) players;

    function bookLotto(address playerAdress,uint _lottoNum,uint _amount) public returns (bool){            
        bool result = false;                                                                                                           
        players[playerAdress] = player
        ({                                                                                                                  
        lottoNum : _lottoNum,                                                         
        amount : _amount                                                              
        });

        result = true;

        return (result);                                                              
    }

    function getBooking(address playerAddress) public view returns (uint,uint) {    
        player memory booking = players[playerAddress];
        return (booking.lottoNum,booking.amount);
    }
