pragma solidity >=0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Delottery.sol";

contract TestDelottery {
  Delottery delotto = Delottery(DeployedAddresses.Delottery());

  uint expectedId = 9;
  uint expectedprice = 8;
  bool expectedresult = true;
  uint expectedBuyCount = 8;

  function testbuyLotteryByID() public {
    (uint returnId,uint returnPrice,bool returnresult)  = delotto.buyLotto(expectedId,expectedprice);
    Assert.equal(returnId, expectedId, "buyLotteryByID of the expected id should match what is returned.");
    Assert.equal(returnPrice, expectedprice, "buyLotteryByID of the expected price should match what is returned.");
    Assert.equal(returnresult, expectedresult, "buyLotteryByID of the expected result should match what is returned.");
  }
  
  function testgetBuyCountById() public {
    uint returnLotto = delotto.getBuyCount(expectedId) ;
    Assert.equal(returnLotto, expectedBuyCount, "getBuyCountById of the expected result should match what is returned.");
  }
  
}