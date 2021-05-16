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

2.2 ในส่วนของ Smart Contract</br>
* struct  ในการสร้างฐานข้อมูล </br></br>
* function ที่ 1 สร้างฐานข้อมูล สลากทุกหมายเลข จากการรับค่าหมายเลขสูงุสุดที่ต้องการ </br>
โดยคืนค่าเป็นผลลัพท์ในการสร้าง ในการทดลองสร้างทั้งหมด 100 ใบ(00-99)

```
การทำงาน เริ่มจากรับ ค่าตัวแปร หมายเลขสูงุสุดที่จะมีในการออกสลาก
วนรูป ตามจำนวนรอบของ ต่าตัวแปรหมายเลขสูงุสุด
  ทำการสร้างสลาก ที่ละหมายเลข
หลังจากวนลูปเสร็จ คืนค่าผลลัพท์เป็น สำเร็จ
```
</br>

* function ที่ 2 จองสลาก Address ของผู้จอง หมายเลขที่จอง พร้อม จำนวนการสั่งจอง  </br>
จากนั้นคืนค่า่ หมายเลขที่จอง จำนวนการสั่งจอง พร้อมผลลัพท์การจอง
```
การทำงาน เริ่มจากรับ ค่าตัวแปร Address ของผู้จอง หมายเลขที่จอง พร้อม จำนวนการสั่งจอง
บันทึก Address ของผู้จอง หมายเลขที่จอง และ จำนวนการสั่งจอง
เปลี่ยนค่าผลลัพท์เป็น สำเร็จ
คืนค่า หมายเลขที่จอง จำนวนการสั่งจอง พร้อมผลลัพท์การจอง
```


2.3 ในส่วนของ Front-End </br>
* สร้างช่องว่างสำหรับรับค่า หมายเลขที่สนใจ และ ปริมาณการสั่งจอง 
* สร้างปุ่มยืนยันการจองเพื่อส่งข้อมูลสู่ (Back-End) 
* สร้างพื้นที่สำหรับแสดงผลการจอง



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

}
    

```
สร้างฐานข้อมูล ชื่อ  player โดยเก็บข้อมูลดังนี้ 

    ข้อมูล      |   ชื่อตัวแปร   |    ชนิด
    รหัสผู้เล่น   |   playerId   |    address
    หมายเลข   |   lottoNum   |    uint
    จำนวน     |   amount   |    uint
</br>
</br>

```


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

```
## 4.ผลการทดสอบ (Testing) แสดงผลลัพธ์ที่ได้จากโครงการ

