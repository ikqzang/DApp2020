# Assignment 3: Class Project NF507 DApp
โดย นาย จิรกิตติ์ ลิ้มสมบูรณ์ รหัส 1920731303018

## 1.บทนำ แสดงวัตถุประสงค์ของโครงการ

1.1 วัตถุประสง เพื่อ สร้าง decentralized applications ที่ให้บริการจอง สลากออนไลน์
โดยมี business requirement ดังต่อไปนี้
* ระบบจะต้องรับค่า หมายเลขที่สนใจ และ ปริมาณการสั่งจอง จากทางหน้าเว็บ
* ระบบจะต้องบันทึก Address ของผู้จอง หมายเลขที่จอง พร้อม จำนวนการสั่งจอง
* ระบบจะต้อส่งข้อมูล รายงานกลับๆไปที่หน้าเว็บเพื่อเป็นการแสดงว่า การสั่งจองสำเร็จ 
</br>

## 2.การวิเคราะห์และออกแบบ (Analysis & Design) เช่น การออกแบบ Smart Contract ที่ใช้งานในโครงการ, การวิเคราะห์และออกแบบ Front-End/Back-End ที่เกี่ยวข้อง เป็นต้น
จาก  business requirement ทั้ง 3 ข้อ เราสามารถแบ่่งการทำงานออกเป็น 2 ส่วนช คือ Front-End/Back-End </br></br>
2.1 เริ่มต้นจากส่วน Back-End </br>
* สร้างที่เก็บข้อมูล โดย จะต้องเก็บ Address ของผู้จอง หมายเลขที่จอง พร้อม จำนวนการสั่งจอง
* สร้างฟังก์ชั่น การเขียนเพิ่มข้อมูลลงไปในที่เก็บข้อมูล โดยรับข้อมูลจาก หน้าเว็บ(Front-End)
* สร้างฟังก์ชั่น การคืนค่าผลของการจองกลับสู่(Front-End)

</br>

2.2 ในส่วนของ Smart Contract</br>
* struct  ในการสร้างฐานข้อมูล </br></br>
* function ที่ 1 จองสลาก Address ของผู้จอง หมายเลขที่จอง พร้อม จำนวนการสั่งจอง  </br>
จากนั้นคืนค่า หมายเลขที่จอง จำนวนการสั่งจอง พร้อมผลลัพท์การจอง
```
การทำงาน เริ่มจากรับ ค่าตัวแปร Address ของผู้จอง หมายเลขที่จอง พร้อม จำนวนการสั่งจอง
บันทึก Address ของผู้จอง หมายเลขที่จอง และ จำนวนการสั่งจอง
เปลี่ยนค่าผลลัพท์เป็น สำเร็จ
คืนค่า หมายเลขที่จอง จำนวนการสั่งจอง พร้อมผลลัพท์การจอง
```


* function ที่ 2 เช็คข้อมูลในฐานข้อมูลว่ามีการจองอยู่จริง  </br>
โดยนำ Address ของผู้จอง ไปขอข้อมูล หมายเลขที่จอง พร้อม จำนวนการสั่งจอง
แล้วเปรียบเทียบกับข้อมูลข้างต้นที่ได้จาก (Front-End) หากเท่ากัน คืนค่าผลลัพท์การจอง
```
การทำงาน เริ่มจากรับ ค่าตัวแปร Address ของผู้จอง หมายเลขที่จอง พร้อม จำนวนการสั่งจอง
ขอข้อมูล หมายเลขที่จอง พร้อม จำนวนการสั่งจอง จากฐานข้อมูล
เปรียบเทียบ หมายเลขที่จอง พร้อม จำนวนการสั่งจอง
คืนค่า Address ของผู้จอง พร้อมผลลัพท์การจอง
```

</br>

2.3 ในส่วนของ Front-End </br>
* สร้างช่องว่างสำหรับรับค่า หมายเลขที่สนใจ และ ปริมาณการสั่งจอง 
* สร้างปุ่มยืนยันการจองเพื่อส่งข้อมูลสู่ (Back-End) 
* สร้างพื้นที่สำหรับแสดงผลการจอง


</br>
</br>

## 3.การจัดทำ (Implementation) ได้แก่ การอธิบายโค้ดเฉพาะส่วนที่สำคัญ
3.1 การสร้าง Smart Contract </br>
* เริ่มด้วย การสร้างก็คือ สร้างไฟล์ชื่อ DeLotto.sol ในโฟลเดอร์ contracts โดยให้ในไฟล์มีโค้ดดังต่อไปนี้

```
pragma solidity >=0.5.0;

contract Delottery {

}

```

เริ่มที่การกำหนด เวอร์ชั่น เป็น solidity ตั้งแต่ 0.5.0 ขึ้นไป
โดยให้ contract ชื่อ Delottery
</br>
</br>

```
pragma solidity >=0.5.0;

contract Delottery {
  struct player {
        address playerId;
        uint lottoNum;
        uint amount;
    } 
    mapping (address => player) players;

}
    

```

สร้างฐานข้อมูล ชื่อ  player โดยเก็บข้อมูลดังนี้ 

```

   ข้อมูล      //   ชื่อตัวแปร    //    ชนิด      
   ======================================
   รหัสผู้จอง   //   playerId   //   address   (หมายเลขกระเป๋าดิจิตอล)  
   หมายเลข   //   lottoNum   //    uint     (จำนวนเต็มบวก)    
   จำนวน     //   amount     //    uint     (จำนวนเต็มบวก)   
    
```
    
</br>
</br>


สร้าง function ที่ 1 จดบันทึกการจองสลาก โดย จด รหัสผู้จอง หมายเลข และจำนวน 
```
    function bookLotto(uint _lottoNum,uint _amount) public returns (bool){            //บรรทัดที่ 1
        result = flase                                                                //บรรทัดที่ 2
        address _user = msg.sender;                                                   //บรรทัดที่ 3
        players[_user] = player({                                                     //บรรทัดที่ 4
        playerId : _user                                                              //บรรทัดที่ 5
        lottoNum : _lottoNum                                                          //บรรทัดที่ 6
        amount : _amount                                                              //บรรทัดที่ 7
        });                                                                           //บรรทัดที่ 8
        result = true                                                                 //บรรทัดที่ 9
        return (result);                                                              //บรรทัดที่ 10
    }
```
บรรทัดที่ 1 </br>
กำหนดชื่อfunction เป็น bookLotto 
กำหนดรับค่า ตัวแปร lottoNum มีชนิดเป็น uint (จำนวนเต็มบวก)
และ ตัวแปร amount มีชนิดเป็น uint (จำนวนเต็มบวก)
กำหนดต้องคืนค่า ผลลัพท์ เป็น bool (ture or flase)

</br>

บรรทัดที่ 2 </br>
กำหนดให้ผลลัทธ์เป็น false

</br>

บรรทัดที่ 3  </br>
กำหนดตัวแปร user ให้เท่ากับ address ของคนที่เชื่อมต่ออยู่กับ contract นีั

</br>

บรรทัดที่ 4-8  </br>
ให้บันทึก ค่าลงไปใน struct player ผ่าน  mapping players 
โดยมี  key เป็น address 

</br>

บรรทัดที่ 9  </br>
เปลี่ยนผลลัทธ์เป็น true

</br>

บรรทัดที่ 10  </br>
คืนค่าผลลัพท์
    
</br>
</br>



```

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

```
## 4.ผลการทดสอบ (Testing) แสดงผลลัพธ์ที่ได้จากโครงการ

