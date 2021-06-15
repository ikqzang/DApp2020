pragma solidity >=0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Delottery.sol";

contract TestDelottery {
  Delottery delotto = Delottery(DeployedAddresses.Delottery());

  uint expectedLottoNum = 1;
  uint expectedAmount = 100;
  bool expectedResult = true;
  address expectedId = msg.sender;
  

  function testbookLottoByID() public  {
    (bool returnResult)  = delotto.bookLotto(expectedId,expectedLottoNum,expectedAmount);
    Assert.equal(returnResult, expectedResult, "buyLotteryByID of the expected result should match what is returned.");
  }
  
  
  function testgetBookingById() public {
    (uint returnLottoNum,uint returnAmount) = delotto.getBooking(expectedId);
    Assert.equal(returnLottoNum, expectedLottoNum, "getBookingById of the expected LottoNum should match what is returned.");
    Assert.equal(returnAmount, expectedAmount, "getBookingById of the expected Amount should match what is returned.");
  }
  
}
