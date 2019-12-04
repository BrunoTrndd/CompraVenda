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

var FEmpresa            : TEmpresa;
    FIndice             : Integer;
    FOrdem              : TOrdem;
    FProduto            : TProduto;
    FPessoa             : TPessoa;
    FNaturezaMercadoria : TNaturezaMercadoria;
    FBaixa              : TBaixaParcela;
    FOrdens             : TList<TOrdem>;
    FPessoas            : TList<TPessoa>;
    FProdutos           : TList<TProduto>;
    FNaturezas          : TList<TNaturezaMercadoria>;
    FBaixas             : TList<TBaixaParcela>;

//PROCEDURES

procedure ListarNaturezas();
var vNatureza: TNaturezaMercadoria;

begin
  Writeln('----------------------------- Naturezas de Mercadoria -------------------------------');
  for vNatureza in FNaturezas do
  begin
    Writeln(vNatureza.ToString);
  end;
  Writeln('-------------------------------------------------------------------------------------');
end;

procedure ListarOrdens();
var vOrdem : TOrdem;

begin
  Writeln('--------------------------------- Ordens Cadastradas --------------------------------');
  for vOrdem in FOrdens do
  begin
    if vOrdem.Status = Cadastrado then
      Writeln('Handle : ' + IntToStr(vOrdem.Handle) + ' Tipo : ' + vOrdem.ListaTipo + ' Status : ' + vOrdem.ListaStatus);
  end;
  Writeln('-------------------------------------------------------------------------------------');
  end;

//FUNCTIONS

function GetPessoa(): TPessoa;
var vConsulta       : string;
    vPessoa         : TPessoa;
    vEncontrou      : Boolean;

begin
  vEncontrou := False;
  Result := nil;
  Writeln('Informe o nome da pessoa: ');
  Readln(vConsulta);
  for vPessoa in FPessoas do
  begin
    if vPessoa.Nome = vConsulta then
    begin
      vEncontrou  := True;
      Result      := vPessoa;
      Exit;
    end;
  end;
  if vEncontrou = False then
    raise Exception.Create('Pessoa nao encontrada.');
end;

function EscolherTipoOrdem():TTipoOrdem;
var vTexto : string;

begin
  Result  := TTipoOrdem.Compra;
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
var vEncontrou  : boolean;
    vProduto    : TProduto;
    vConsulta   : string;

begin
  result:= nil;
  write('Produto: ');
  readln(vConsulta);
  vEncontrou:= false;
  for vProduto in FProdutos do
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
var vNatureza  : TNaturezaMercadoria;
    vEncontrou : Boolean;
    vPesquisa  : string;

begin
  result  := nil;
  Writeln('Informe o nome da natureza de mercadoria: ');
  readln(vPesquisa);
  vEncontrou := False;
  for vNatureza in FNaturezas do
  begin
    if vPesquisa = vNatureza.Nome then
    begin
      vEncontrou := True;
      Result     := vNatureza;
      Exit;
    end;
  end;
  if vEncontrou = False then
    raise  Exception.Create('Natureza de Mercadoria não encontrada.');
end;

function GetOrdem(): TOrdem;
var vOrdem    : TOrdem;
    vEncontrou: Boolean;
    vPesquisa : Integer;

begin
  Result  :=  nil;
  vEncontrou  := False;
  Writeln('Informe o handle da Ordem: ');
  Readln(vPesquisa);
  for vOrdem in FOrdens do
  begin
    if vPesquisa = vOrdem.Handle then
    begin
      vEncontrou  := True;
      Result      := vOrdem;
      Exit;
    end;
  end;
  if vEncontrou = False then
    raise Exception.Create('Ordem nao encontrada.');
end;

procedure BaixarTodasParcelas(prOrdem : TOrdem);
var
vParcela : TParcela;
vBaixaParcela : TBaixaParcela;
begin
  vBaixaParcela := TBaixaParcela.Create();
  try
    for vParcela in prOrdem.Parcelas do
    begin
      vBaixaParcela.AdicionarParcela(vParcela);
    end;
    vBaixaParcela.BaixarParcelas();
    FBaixas.Add(vBaixaParcela);
  except
    on E : Exception do
      Writeln('Erro: '+ E.Message);
  end;
end;


procedure MenuBaixa();
var
vTexto   : string;
vOrdem   : TOrdem;
begin
  Writeln('----------------------BAIXAS---------------------'+sLineBreak+
          '01 - Baixar todas as parcelas de uma ordem'       +sLineBreak+
          '02 - Baixar todas as parcelas de varias ordens'   +sLineBreak+
          '03 - Baixar parcela unica'                        +sLineBreak+
          '04 - Baixar varias parcelas'                      +sLineBreak+
          '-------------------------------------------------'+sLineBreak);
  Readln(vTexto);

  case vTexto of
    01: //Baixar todas as parcelas de uma ordem
    begin
      ListarOrdens();
      vOrdem := GetOrdem();
      BaixarTodasParcelas(vOrdem);

    end;

    02: //Baixar todas as parcelas de varias ordens
    begin

    end;

    03: //Baixar parcela unica
    begin

    end;

    04: //Baixar varias parcelas
    begin

    end;
  end;
end;



begin
  FormatSettings.DateSeparator:= '-';
  FormatSettings.ShortDateFormat := 'dd-mm-yyyy';
  try
    try
      FEmpresa   := TEmpresa.Create;
      FOrdens    := TList<TOrdem>.Create;
      FPessoas   := TList<TPessoa>.Create;
      FProdutos  := TList<TProduto>.Create;
      FNaturezas := tList<TNaturezaMercadoria>.Create;
      repeat
        {MENU:}
        Writeln('--------------------------------------------------------------');
        Writeln('SISTEMA DE COMPRA E VENDA');
        Writeln('--------------------------------------------------------------');
        Writeln('11   : Cadastrar Pessoa                  | 12 : Cadastrar Produto    | 13 : Cadastrar Ordem');
        Writeln('14   : Cadastrar Natureza de Mercadoria  |                           |');
        Writeln('21   : Consultar Pessoa                  | 22 : Consultar Produto    | 23 : Consultar Ordem de Compra/Venda');
        Writeln('31   : Alterar Pessoa                    | 32 : Alterar Produto      | 33 : Alterar Ordem de Compra/Venda');
        Writeln('41   : Listar Parcelas de Compra Vencidas|                           | 42 : Listar Parcelas de Venda Vencidas');
        Writeln('51   : Listar Itens da Ordem             | 52 - Encerrar Ordem       | 53 : Listar todas as ordens');
        Writeln('54   : Listar Naturezas de Mercadoria    |                           |');
        Writeln('61   : Efetuar Baixa de Parcelas         |                           |');
        Writeln('0    : Sair');
        Writeln('--------------------------------------------------------------');
        Readln(FIndice);
        case FIndice of
          10:{Informacoes iniciais da empresa}
            begin
              Writeln(FEmpresa.ToString());
            end;
          11:{Cadastrar Pessoa}
            begin
              FPessoa   :=  TPessoa.Create;
              try
                FPessoa.SolicitarInformacoes();
                FPessoas.Add(FPessoa);
              except
                on e : Exception do
                begin
                  Writeln(e.Message);
                end;
              end;
            end;
          12:{Cadastrar Produto}
            begin
              FProduto := TProduto.Create;
	            try
                FProduto.SolicitarInformacao();
                FProdutos.Add(FProduto);
              except
                on e : Exception do
                begin
                  Writeln(e.Message);
                end;
              end;
            end;
          13:{Cadastrar Ordem}
            begin
              FOrdem := TOrdem.Create();
              try
                FPessoa := GetPessoa;
                FOrdem.SolicitarInformacoes(EscolherTipoOrdem(), FPessoa, FProdutos);
                FOrdens.Add(FOrdem);
              except
                on e : Exception do
                begin
                  Writeln(e.Message);
                end;
              end;
            end;
          14:{Cadastrar Natureza de Mercadoria}
            begin
              FNaturezaMercadoria := TNaturezaMercadoria.Create;
              try
                FNaturezaMercadoria.SolicitarInformacao(FNaturezas.Count);
                FNaturezas.Add(FNaturezaMercadoria);
                Writeln('Cadastrado com sucesso!');
              except
                raise Exception.Create('Nao foi possivel criar a Natureza de Mercadoria.');
              end;
            end;
          21:{Consultar Pessoa}
            begin
              Writeln(GetPessoa().ToString());
            end;
          22:{Consultar Produto}
            begin
	            Writeln(GetProduto().ToString());
            end;
          23:{Consultar Ordem de Compra/Venda}
            begin
              GetOrdem().ToString();
            end;
          31:{Alterar Pessoa}
            begin
              GetPessoa().SolicitarInformacoes();
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
              ListarOrdens();
              Writeln(GetOrdem().ListaItens());
            end;
          52: {Encerra Ordem}
            begin
              ListarOrdens();
              GetOrdem().EncerraOrdem();
            end;
          53:{Lista todas as ordens}
            begin
              ListarOrdens();
            end;
          54:{Listar Naturezas de Mercadoria}
            begin
              ListarNaturezas();
            end;
          61:{Efetuar Baixa de Parcelas}
            begin
              //BAIXAR ORDEM, BAIXAR PARCELA ESPECÍFICA, AO COMEÇAR A BAIXA PERGUNTAR QUAL O TIPO DE ORDEM QUE QUER BAIXAR
              MenuBaixa();
            end;
        end;
      until (FIndice = 0);
    finally

    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
