program CompraVenda;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uPessoa in 'uPessoa.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
