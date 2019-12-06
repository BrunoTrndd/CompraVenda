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
    FOrdens             : TList<TOrdem>;
    FPessoas            : TList<TPessoa>;
    FProdutos           : TList<TProduto>;
    FNaturezas          : TList<TNaturezaMercadoria>;

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
      Writeln('Handle : ' + IntToStr(vOrdem.Handle) + ' | Tipo : ' + vOrdem.ListaTipo + ' | Status : ' + vOrdem.ListaStatus);
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

procedure ListaParcela();
var
  vOrdem : TOrdem;
  vParcela : TParcela;
begin

  for vOrdem in FOrdens do
  begin

    for vParcela in vOrdem.Parcelas do
    begin
      Writeln('Parcela :' + IntToStr(vParcela.Handle) + ', ordem: '+ IntToStr(vOrdem.Handle) + ', Tipo : ' + vOrdem.ListaTipo + ', Status da ordem : ' + vOrdem.ListaStatus());
    end;

  end;

end;


function GetParcela(prHandle : Integer = 0):TParcela;
var vTexto : string;
    vOrdem : TOrdem;
    vParcela : TParcela;
begin

  if prHandle = 0 then
  begin
    Result  :=  nil;
    Writeln('Qual o handle da parcela?');
    Readln(vTexto);
  end;

  for vOrdem in FOrdens do
  begin
    for vParcela in vOrdem.Parcelas do
    begin

      if prHandle = 0 then
      begin

        if vParcela.Handle = StrToInt(vTexto) then
        begin
          Exit(vParcela);
        end;

      end else
      begin

        if vParcela.Handle = prHandle then
        begin
          Exit(vParcela);
        end;

      end;

    end;
  end;

  Writeln('Esse handle de parcela nao existe');
end;

function GetTipoOrdemParcela(prParcela : TParcela) : TTipoOrdem;
var
vOrdem : TOrdem;
vParcela : TParcela;
begin
  for vOrdem in FOrdens do
  begin
    for vParcela in vOrdem.Parcelas do
    begin
      if vParcela = prParcela then
      begin
        Exit(vOrdem.TipoOrdem);
      end;
    end;
  end;
end;

function MontaListaParcela(prTipo : TTipoOrdem) : TList<TParcela>;
var
  vOrdem         : TOrdem;
  vParcela       : TParcela;
  vEscolha       : Integer;
  vListaParcelas : TList<TParcela>;
  vTipo          : TTipoOrdem;
  vTipoPost      : TTipoOrdem;
begin
  vListaParcelas := TList<TParcela>.Create;
  vEscolha := 1;
  while vEscolha <> 0 do
  begin
    ListaParcela();
    Writeln('Handle da parcela que deseja adicionar');
    Readln(vEscolha);

    vParcela := GetParcela(vEscolha);

    if(GetTipoOrdemParcela(vParcela) <> prTipo) then
    begin
      raise Exception.Create('Tipo da parcela diferente do que foi informado');
    end;

    vListaParcelas.Add(vParcela);

    Writeln('Deseja adicionar outra parcela? Digite em numeros (1 - SIM / 0 - NAO)');
    Readln(vEscolha);
  end;

  Result := vListaParcelas;

end;

function GetParcelasVencidas(prData: TDateTime; prTipo : TTipoOrdem) : TList<TParcela>;
var
vOrdem : TOrdem;
vParcela : TParcela;
vListaParcela : TList<TParcela>;
begin
  vListaParcela.Create();
  for vOrdem in FOrdens do
  begin
    for vParcela in vOrdem.Parcelas do
    begin
      if (vParcela.DataVencimento < prData) and (GetTipoOrdemParcela(vParcela) = prTipo) then
      begin
        vListaParcela.Add(vParcela);
      end;
    end;

  end;

  Result := vListaParcela;
end;


procedure MenuBaixa();
var vIndice        : Integer;
    vListaParcelas : TList<TParcela>;
    vEscolha       : Integer;
    vTipo          : TTipoOrdem;
    vBaixaParcela  : TBaixaParcela;
    vInclude       : TInclude;
    vData          : TDateTime;
begin
  vListaParcelas := TList<TParcela>.Create;
  vBaixaParcela := TBaixaParcela.Create;
  Writeln('----------------------BAIXAS---------------------'+sLineBreak+
          '01 - Baixar parcelas individuais'                 +sLineBreak+
          '02 - Baixar parcelas vencidas ordem de compra'    +sLineBreak+
          '03 - Baixar parcelas vencidas ordem de venda'     +sLineBreak+
          '-------------------------------------------------'+sLineBreak);
  Readln(vIndice);
  try
    case vIndice of
      01: //Baixar parcelas individuais
      begin
        ListaParcela();
        Writeln('Qual o tipo de ordem que deseja baixar? (1 - Compra/ 2 - Venda)');
        Readln(vEscolha);
        if vEscolha = 1 then
        begin
          vTipo := TTipoOrdem.Compra;
        end else
          vTipo := TTipoOrdem.Venda;

        vBaixaParcela.Parcelas := MontaListaParcela(vTipo);

        vBaixaParcela.BaixarParcelas(procedure (prValorTotal:Currency)
                                      begin
                                        if vTipo = TTipoOrdem.Venda then
                                        begin
                                          FEmpresa.Saldo := FEmpresa.Saldo + prValorTotal;
                                        end else
                                        begin
                                          FEmpresa.Saldo := FEmpresa.Saldo - prValorTotal;
                                        end;
                                      end );


      end;

      02: //Baixar parcelas vencidas ordem de compra
      begin
        vData := vInclude.GetDate('Qual a data que deseja ter de posicao?');
        vTipo := TTipoOrdem.Compra;

        vBaixaParcela.Parcelas := GetParcelasVencidas(vData, vTipo);
        vBaixaParcela.BaixarParcelas(procedure (prValorTotal:Currency)
                                      begin
                                        if vTipo = TTipoOrdem.Venda then
                                        begin
                                          FEmpresa.Saldo := FEmpresa.Saldo + prValorTotal;
                                        end else
                                        begin
                                          FEmpresa.Saldo := FEmpresa.Saldo - prValorTotal;
                                        end;
                                      end );


      end;

      03: //Baixar parcelas vencidas ordem de venda
      begin
        vData := vInclude.GetDate('Qual a data que deseja ter de posicao?');
        vTipo := TTipoOrdem.Venda;

        vBaixaParcela.Parcelas := GetParcelasVencidas(vData, vTipo);
        vBaixaParcela.BaixarParcelas(procedure (prValorTotal:Currency)
                                      begin
                                        if vTipo = TTipoOrdem.Venda then
                                        begin
                                          FEmpresa.Saldo := FEmpresa.Saldo + prValorTotal;
                                        end else
                                        begin
                                          FEmpresa.Saldo := FEmpresa.Saldo - prValorTotal;
                                        end;
                                      end );
                                      Writeln('Saldo da empresa: R$'+FormatCurr('#,##0.00', FEmpresa.Saldo));

      end;


    end;
  except
    raise Exception.Create('Ocorreu um erro no menu de baixa');
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
        FIndice :=  0;
        try
          {MENU:}
          Writeln('---------------------------------------------------------------------------------------------------------------------------------------');
          Writeln('-------------------------------------------------------SISTEMA DE COMPRA E VENDA-------------------------------------------------------');
          Writeln('---------------------------------------------------------------------------------------------------------------------------------------');
          Writeln('1    : Informacoes da empresa            |                                        |                                                    ');
          Writeln('11   : Cadastrar Pessoa                  | 21 : Cadastrar Produto                 | 31 : Cadastrar Ordem                               ');
          Writeln('12   : Consultar Pessoa                  | 22 : Cadastrar Natureza de Mercadoria  | 32 : Consultar Ordem de Compra/Venda               ');
          Writeln('13   : Alterar Pessoa                    | 23 : Consultar Produto                 | 33 : Alterar Ordem de Compra/Venda                 ');
          Writeln('                                         | 24 : Alterar Produto                   | 34 : Listar Parcelas de Compra Vencidas            ');
          Writeln('                                         | 25 : Listar todas Naturezas            | 35 : Listar Parcelas de Venda Vencidas             ');
          Writeln('                                                                                  | 36 : Listar Itens da Ordem                         ');
          Writeln('                                                                                  | 37 : Encerrar Ordem                                ');
          Writeln('                                                                                  | 38 : Listar todas as ordens                        ');
          Writeln('                                                                                  | 39 : Efetuar Baixa de Parcelas                     ');
          Writeln('                                                                                  | 40 : Cancelar Ordem                                ');
          Writeln('                                                                                  | 41 : Excluir Ordem                                 ');
          Writeln('0    : Sair                                                                                                                            ');
          Writeln('---------------------------------------------------------------------------------------------------------------------------------------');
          Readln(FIndice);

          case FIndice of
             1:{Informacoes iniciais da empresa}
              begin
                Writeln(FEmpresa.ToString());
              end;
            11:{Cadastrar Pessoa}
              begin
                FPessoa := nil;
                try
                  FPessoa   :=  TPessoa.Create;
                  FPessoa.SolicitarInformacoes();
                  FPessoas.Add(FPessoa);
                except
                  FPessoa.Free;
                  Exception.RaiseOuterException(EArgumentOutOfRangeException.Create('Nao foi possivel cadastrar a pessoa.'));
                end;
              end;
            12:{Consultar Pessoa}
              begin
                Writeln(GetPessoa().ToString());
              end;
            13:{Alterar Pessoa}
              begin
                GetPessoa().SolicitarInformacoes();
              end;
            21:{Cadastrar Produto}
              begin
                FProduto := nil;
                try
                  FProduto := TProduto.Create();
                  FProduto.SolicitarInformacao((GetNatureza()));
                  FProdutos.Add(FProduto);
                except
                  FProduto.Free;
                  Exception.RaiseOuterException(EArgumentOutOfRangeException.Create('Nao foi possivel cadastrar o produto.'));
                end;
              end;
            22:{Cadastrar Natureza de Mercadoria}
              begin
                FNaturezaMercadoria := nil;
                try
                  FNaturezaMercadoria := TNaturezaMercadoria.Create;
                  FNaturezaMercadoria.SolicitarInformacao(FNaturezas.Count);
                  FNaturezas.Add(FNaturezaMercadoria);
                  Writeln('Cadastrado com sucesso!');
                except
                  FNaturezaMercadoria.Free;
                  Exception.RaiseOuterException(EArgumentOutOfRangeException.Create('Nao foi possivel criar a Natureza de Mercadoria.'));
                end;
              end;
            23:{Consultar Produto}
              begin
                Writeln(GetProduto().ToString());
              end;
            24:{Alterar Produto}
              begin
                GetProduto().SolicitarInformacao(GetNatureza());
              end;
            25:{Listar Naturezas de Mercadoria}
              begin
                ListarNaturezas();
              end;
            31:{Cadastrar Ordem}
              begin
                FOrdem := nil;
                try
                  FOrdem := TOrdem.Create();
                  FPessoa := GetPessoa;
                  FOrdem.SolicitarInformacoes(EscolherTipoOrdem(), FPessoa, FProdutos);
                  FOrdens.Add(FOrdem);
                except
                  FOrdem.Free;
                  Exception.RaiseOuterException(EArgumentOutOfRangeException.Create('Nao foi possivel cadastrar a ordem'));
                end;
              end;
            32:{Consultar Ordem de Compra/Venda}
              begin
                GetOrdem().ToString();
              end;
            33:{Alterar Ordem de Compra/Venda}
              begin

              end;
            34:{Listar Parcelas de Compra Vencidas}
              begin

              end;
            35:{Listar Parcelas de Venda Vencidas}
              begin

              end;
            36:{Listar Itens da Ordem}
              begin
                ListarOrdens();
                Writeln(GetOrdem().ListaItens());
              end;
            37: {Encerra Ordem}
              begin
                ListarOrdens();
                GetOrdem().EncerraOrdem();
              end;
            38:{Lista todas as ordens}
              begin
                ListarOrdens();
              end;
            39:{Efetuar Baixa de Parcelas}
              begin
                MenuBaixa();
              end;
            40:{Cancelar Ordem}
              begin
                GetOrdem().CancelarOrdem();
              end;
            41:{Excluir Ordem}
              begin
                FOrdem := GetOrdem();
                FOrdem.ExcluirOrdem();
                FOrdens.Remove(FOrdem);
                FOrdem.Free;
              end;
          end;
        except
          on E: Exception do
          begin
            Writeln(E.ClassName, ': ', E.Message);
          end;
        end;
      until (FIndice = 0);
    finally
      for FNaturezaMercadoria in FNaturezas do
      begin
        FNaturezaMercadoria.Free;
      end;
      for FOrdem in FOrdens do
      begin
        FOrdem.Free;
      end;
      for FPessoa in FPessoas do
      begin
        FPessoa.Free;
      end;
      for FProduto in FProdutos do
      begin
        FProduto.Free;
      end;
      FOrdens.Free;
      FPessoas.Free;
      FProdutos.Free;
      FNaturezas.Free;
      FEmpresa.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
