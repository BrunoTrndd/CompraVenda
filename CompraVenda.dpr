program CompraVenda;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uPessoa in 'uPessoa.pas',
  uProduto in 'uProduto.pas',
  uEmpresa in 'uEmpresa.pas',
  uOrdem in 'uOrdem.pas',
  uParcela in 'uParcela.pas',
  uBaixaParcela in 'uBaixaParcela.pas',
  uEnums in 'uEnums.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
