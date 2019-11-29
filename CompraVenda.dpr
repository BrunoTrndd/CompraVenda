program CompraVenda;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Generics.Collections,
  uPessoa in 'uPessoa.pas',
  uProduto in 'uProduto.pas',
  uEmpresa in 'uEmpresa.pas',
  uOrdem in 'uOrdem.pas',
  uParcela in 'uParcela.pas',
  uBaixaParcela in 'uBaixaParcela.pas',
  uOrdemProduto in 'uOrdemProduto.pas',
  uEnums in 'uEnums.pas',
  uInclude in 'uInclude.pas',
  uNaturezaMercadoria in 'uNaturezaMercadoria.pas';

var vEmpresa            : TEmpresa;
    vIndice             : Integer;
    vOrdem              : TOrdem;
    vProduto            : TProduto;
    vPessoa             : TPessoa;
    vNaturezaMercadoria : TNaturezaMercadoria;
    vOrdens             : TList<TOrdem>;
    vPessoas            : TList<TPessoa>;
    vProdutos           : TList<TProduto>;
    vNaturezas          : TList<TNaturezaMercadoria>;
    vTexto : string;

//PROCEDURES

//FUNCTIONS
function GetPessoa(): TPessoa;
var
  vConsulta       : string;
  vPessoaConsulta : TPessoa;
  vEncontrou      : Boolean;

begin
  vEncontrou := False;
  Result := nil;
  Writeln('Informe o nome da pessoa: ');
  Readln(vConsulta);
  for vPessoaConsulta in vPessoas do
  begin
    if vPessoaConsulta.Nome = vConsulta then
    begin
      vEncontrou  := True;
      Result      := vPessoaConsulta;
      Exit;
    end;
  end;
  if vEncontrou = False then
    raise Exception.Create('Pessoa nao encontrada.');
end;

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

function GetProduto(): TProduto;
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
     vEncontrou := true;
   end;
  end;

  if not vEncontrou then
 raise Exception.Create('Verifique o produto informado.');
end;

function GetNatureza(): TNaturezaMercadoria;
begin
  result  := nil;
end;

begin
  FormatSettings.DateSeparator:= '-';
  FormatSettings.ShortDateFormat := 'dd-mm-yyyy';
  try
    try
      vEmpresa   := TEmpresa.Create;
      vOrdens    := TList<TOrdem>.Create;
      vPessoas   := TList<TPessoa>.Create;
      vProdutos  := TList<TProduto>.Create;
      vNaturezas := tList<TNaturezaMercadoria>.Create;
      repeat
        {MENU:}
        Writeln('--------------------------------------------------------------');
        Writeln('SISTEMA DE COMPRA E VENDA');
        Writeln('--------------------------------------------------------------');
        Writeln('11   : Cadastrar Pessoa                  | 12 : Cadastrar Produto    | 13 : Cadastrar Ordem                  | 14 : Cadastrar Natureza de Mercadoria');
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
              vPessoa   :=  TPessoa.Create;  //EVERTON
              try
                vPessoa.SolicitarInformacoes();
                vPessoas.Add(vPessoa);
              except
                raise Exception.Create('Nao foi possivel cadastrar a pessoa.');
              end;
            end;
          12:{Cadastrar Produto}
            begin
	            try

                vProduto := TProduto.Create;
                vProduto.SolicitarInformacao();
                vProdutos.Add(vProduto);

              except
                vProduto.Free;
              end;
            end;
          13:{Cadastrar Ordem}
            begin
              try
                vOrdem := TOrdem.Create();
                vPessoa := GetPessoa;
                vOrdem.SolicitarInformacoes(EscolherTipoOrdem(), vPessoa, vProdutos);
                vOrdens.Add(vOrdem);
              except
                on e : Exception do
                begin
                  Writeln(e.Message);
                end;
              end;
            end;
          14:{Cadastrar Natureza de Mercadoria}
            begin
              vNaturezaMercadoria := TNaturezaMercadoria.Create;
              try
                vNaturezaMercadoria.SolicitarInformacao(vNaturezas.Count);
                vNaturezas.Add(vNaturezaMercadoria);
                Writeln('Cadastrado com sucesso!');
              except
                raise Exception.Create('Nao foi possivel criar a Natureza de Mercadoria.');
              end;
            end;
          21:{Consultar Pessoa}
            begin
              GetPessoa().ToString();
            end;
          22:{Consultar Produto}
            begin
	            GetProduto().ToString();
            end;
          23:{Consultar Ordem de Compra/Venda}
            begin

            end;
          31:{Alterar Pessoa}
            begin

            end;
          32:{Alterar Produto}
            begin
            	GetProduto().SolicitarInformacao();
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
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
