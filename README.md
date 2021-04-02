# lazarus-to-linenotify
สำหรับการส่งข้อความ line application โดย lazarus


การลง Component sendlinenotify
ให้ install sendlinenotify ใน  lazarus


copy file
libeay32.dll กับ  ssleay32.dll ไปไว้ใน folder program ด้วยทุกครั้ง

ตัวอย่างการเรียกใช้งาน

procedure TfrmSendLine.btnSendClick(Sender: TObject);
begin

  LineNotify1.Send(tokenid,'ข้อความ','ไฟล์รูปภาพ',1,1);
end;

การส่ง line notify 
จะรับค่าอย่างน้อย 2 ตัวครับ
1.  token id *** จำเป็น
2.  message ที่จะส่ง  *** จำเป็น
3.     ไฟล์รูปภาพ  // ไม่บังคับ เป็น string ถ้าส่ง sticker ไม่ส่งรูปใส่ค่าว่างไว้
4. sticker package id // ถ้าไม่ต้องการส่งไม่ต้องใส่อะไร
5  sticker id // ถ้าไม่ต้องการส่งไม่ต้องใส่อะไร

line sticker id ดูได้จากลิ้งค์นี้
https://developers.line.biz/media/messaging-api/sticker_list.pdf

Component ที่เกี่ยวข้อง  indy10

