pragma solidity >=0.5.0;

contract Delottery {
    struct Lotto {
        uint id;
        uint buyCount;
        address owner;
    }

    event BuyLotto(uint id, address buyer);
    mapping (uint => Lotto) lottos;
    mapping (uint => address[]) buying;

 

    function addLottoByMaxId(uint _Maxid) public returns (bool) {
        bool result = false;
        _Maxid = 99; // only in test maxid = 99
        for (uint i = 0; i < _Maxid; i ++) {
            addLotto(i,0,0xB44BEcab8629635ecE3f30E389c4f3C9657421A4);
            result = true;
        }
        return (result);           
    }
  

    function getBuyCount(uint _id) public view returns (uint) {
        Lotto memory lotto = lottos[_id];
        return (lotto.buyCount);
    }

    function buyLotto(uint _id,uint price) public returns (uint _buyId,uint _buyprice,bool _buyResult){
        Lotto storage lotto = lottos[_id];
        address _buyer = msg.sender;
        lotto.buyCount += price;
        buying[_id].push(_buyer);
        emit BuyLotto(_id, _buyer);
        bool result = true;
        return (_id,price,result);
    }

}

