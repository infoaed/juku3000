program Loeleo;
  var cnt: integer;
      key, a, b: integer;
      hex :string[16];
(*$I Screen.H  *)
(*$I Utilit.H  *)
begin
hex:='0123456789ABCDEF';
RstTimer;
Inverse;
Writeln('PASCALi UTILITi loenduri test 2025');
Normal;
Writeln;
Writeln('Katkestamiseks ESC, nullimiseks muu!');
Writeln;
repeat
    Up;
    cnt:=Timer;
    (* Writeln(cnt); *)
    a:=shr(cnt,8);
    b:=shr(shl(cnt,8),8);
    write(hex[a div 16+1]);
    write(hex[a mod 16+1]);
    write(hex[b div 16+1]);
    writeln(hex[b mod 16+1]);
    ClrEoLn;
    key:=ReadKey;
    if key>0 then
      begin
        RstTimer;
      end;
until key=27;
end.
