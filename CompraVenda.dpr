program CompraVenda;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Generics.Collections,
  uPessoa in 'uPessoa.pas',
  uProduto in 'uProduto.pas',
  uEmpresa in 'uEmpresa.pas',
  uOrdem in 'uOrdem.pas';

<<<<<<< Updated upstream
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
=======
var vEmpresa  : TEmpresa;
    vIndice   : Integer;
    vOrdem    : TOrdem;
    vProduto  : TProduto;
    vOrdens   : TList<TOrdem>;
    vPessoas  : TList<TPessoa>;
    vProdutos : TList<TProduto>;
    vTexto : string;

function EscolherTipoOrdem():TTipoOrdem;
begin
  repeat
    Writeln('Qual o tipo da ordem que deseja criar?');
    Writeln('1 - Compra');
    Writeln('2 - Venda');
    Readln(vTexto);

    if vTexto = '1' then
    begin
      Result := TTipoOrdem.Compra;
    end else if vTexto = '2' then
    begin
      Result := TTipoOrdem.Venda;
    end else
    begin
      Writeln('Digite um valor valido');
    end;

  until (vTexto = '1') or (vTexto = '2');
end;


   function GetProduto(callback: TProc<TProduto>): TProduto;
   var
     vEncontrou : boolean;
     vConsulta : string;
   begin
     result:= nil;

     write('Produto: ');
     readln(vConsulta);
     vEncontrou:= false;

     for vProduto in vProdutos do
     begin
       if(vConsulta = vProduto.Nome )then
       begin
         Result := vProduto;
         callback(vProduto);
         vEncontrou := true;
       end;
     end;

   if not vEncontrou then
     raise Exception.Create('Verifique o produto informado.');

begin
  try
    try
      vEmpresa   := TEmpresa.Create;
      vOrdens    := TList<TOrdem>.Create;
      vPessoas   := TList<TPessoa>.Create;
      vProdutos  := TList<TProduto>.Create;
      repeat
        {MENU:}
        Writeln('--------------------------------------------------------------');
        Writeln('SISTEMA DE COMPRA E VENDA');
        Writeln('--------------------------------------------------------------');
        Writeln('11   : Cadastrar Pessoa                  | 12 : Cadastrar Produto    | 13 : Cadastrar Ordem de Compra   | 14 : Cadastrar Ordem de Venda');
        Writeln('21   : Consultar Pessoa                  | 22 : Consultar Produto    | 23 : Consultar Ordem de Compra/Venda');
        Writeln('31   : Alterar Pessoa                    | 32 : Alterar Produto      | 33 : Alterar Ordem de Compra/Venda');
        Writeln('41   : Listar Parcelas de Compra Vencidas|                           | 42 : Listar Parcelas de Venda Vencidas');
        Writeln('51   : Listar Itens da Ordem             |                           |');
        Writeln('61   : Efetuar Baixa de Parcelas         |                           |');
        Writeln('0    : Sair');
        Writeln('--------------------------------------------------------------');
        Readln(vIndice);
        case vIndice of
          10:{Informacoes iniciais da empresa}
            begin
              Writeln(vEmpresa.ToString());
            end;
          11:{Cadastrar Pessoa}
            begin
              //EVERTON
            end;
          12:{Cadastrar Produto}
            begin
	      try
              begin
                vProduto := TProduto.Create;
                vProduto.SolicitarInformacao();
                vProdutos.Add(vProduto);
              end
              except
                vProduto.Free;
              end;
            end;
          13:{Cadastrar Ordem de Compra}
            begin
              vOrdem.Create();
              vOrdem.SolicitarInformacoes(EscolherTipoOrdem());
            end;
          14:{Cadastrar Ordem de Venda}
            begin
              //BRUNO
            end;
          21:{Consultar Pessoa}
            begin

            end;
          22:{Consultar Produto}
            begin
	 GetProduto(
                          procedure (prProduto: TProduto)
                          begin
                            prProduto.ToString();
                          end
                        )
            end;
          23:{Consultar Ordem de Compra/Venda}
            begin

            end;
          31:{Alterar Pessoa}
            begin

            end;
          32:{Alterar Produto}
            begin
	GetProduto(
                          procedure (prProduto: TProduto)
                          begin
                            prProduto.SolicitarInformacao();
                          end
                        )

            end;
          33:{Alterar Ordem de Compra/Venda}
            begin

            end;
          41:{Listar Parcelas de Compra Vencidas}
            begin

            end;
          42:{Listar Parcelas de Venda Vencidas}
            begin

            end;
          51:{Listar Itens da Ordem}
            begin

            end;
          61:{Efetuar Baixa de Parcelas}
            begin

            end;
        end;
      until (vIndice = 0);
    finally

    end;
>>>>>>> Stashed changes
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
