unit uOrdem;

interface
uses uProduto,
     uParcela,
     uOrdemProduto,
     uEnums,
     uPessoa,
     SysUtils,
     DateUtils,
     Generics.Collections;

type
TOrdem = class

  private
    FHandle        : Integer;
    FTipoOrdem     : TTipoOrdem;
    FItens         : TList<TOrdemProduto>;
    FDataEmissao   : TDateTime;
    FValorTotal    : Currency;
    FStatus        : TStatus;
    FPessoa        : TPessoa;
    FDataCadastro  : TDateTime;
    FParcelas      : TList<TParcela>;
    FQtdParcelas   : Integer;

  public
    property Handle       : Integer              read FHandle       write FHandle;
    property TipoOrdem    : TTipoOrdem           read FTipoOrdem    write FTipoOrdem;
    property Itens        : TList<TOrdemProduto> read FItens        write FItens;
    property DataEmissao  : TDateTime            read FDataEmissao  write FDataEmissao;
    property ValorTotal   : Currency             read FValorTotal   write FValorTotal;
    property Status       : TStatus              read FStatus       write FStatus;
    property Pessoa       : TPessoa              read FPessoa       write FPessoa;
    property DataCadastro : TDateTime            read FDataCadastro write FDataCadastro;
    property Parcelas     : TList<TParcela>      read FParcelas     write FParcelas;
    property QtdParcelas  : Integer              read FQtdParcelas  write FQtdParcelas;


// CONSTRUCTOR
  constructor Create();

// DESTRUCTOR
  destructor Destroy();override;

// PROCEDURE
  procedure SolicitarInformacoes(prTipoOrdem : TTipoOrdem; prPessoa : TPessoa; prProdutos : TList<TProduto>);
  procedure SolicitarItens(prProdutos : TList<TProduto>);
  procedure EncerraOrdem();
  procedure GeraParcela(prQtdParcela : Integer; prDataVencimento : TDateTime);
  procedure ImprimirItens();
  procedure ImprimirParcelas();

// FUNCTION
  function ToString() : string; override;
  function ListaTipo() : string;
  function ListaItens() : string;
  function ListaParcelas():string;
  function ListaStatus(): string;



end;
var vHandle : Integer;

implementation

{ TOrdem }

//CREATE
constructor TOrdem.Create;
begin
  Inc(vHandle);
  FHandle       := vHandle;
  FTipoOrdem    := TTipoOrdem.Compra;  //FIXADO PARA CRIAR COMO COMPRA
  FItens        := TList<TOrdemProduto>.Create;
  FDataEmissao  := 0;
  FValorTotal   := 0;
  FStatus       := TStatus.Cadastrado;
  FPessoa       := nil;
  FDataCadastro := 0;
  FParcelas     := TList<TParcela>.Create;
end;
//DESTROY
destructor TOrdem.Destroy();
var vParcela      : TParcela;
    vOrdemProduto : TOrdemProduto;
begin
  for vOrdemProduto in FItens do
  begin
    vOrdemProduto.Destroy();
  end;
  for vParcela in FParcelas do
  begin
    vParcela.Destroy();
  end;

  FItens.Free;
  FParcelas.Free;
end;

procedure TOrdem.EncerraOrdem;
var vQtdParcela     : Integer;
    vData           : TDateTime;
    vDiaVencimento  : Integer;
    vOrdemProduto   : TOrdemProduto;
begin
  if FStatus = TStatus.Cadastrado then
  begin
    Writeln('Quantas parcelas deseja criar na ordem?');
    Readln(vQtdParcela);
    Writeln('Qual dia sera o vencimento das parcelas?');
    Readln(vDiaVencimento);
    vData := EncodeDate(YearOf(Now()),MonthOf(Now()), vDiaVencimento);
    GeraParcela(vQtdParcela, vData);
    FDataEmissao := Now();
    FStatus := TStatus.Encerrado;
    for vOrdemProduto in Itens do
    begin
      vOrdemProduto.AtualizaEstoque(FTipoOrdem, FStatus);
    end;
  end;
end;

procedure TOrdem.GeraParcela(prQtdParcela: Integer; prDataVencimento : TDateTime);
var vValorTotal     : Currency;
    vValorParcela   : Currency;
    vIndice         : Integer;
    vDataVencimento : TDateTime;
    vOrdemProduto   : TOrdemProduto;
    vParcela        : TParcela;
begin
  vValorTotal := 0;
  for vOrdemProduto in FItens do
  begin
    vValorTotal := vValorTotal + vOrdemProduto.ValorTotal;
  end;
  vValorParcela := vValorTotal/prQtdParcela;
  vDataVencimento := prDataVencimento;
  for vIndice := 1 to prQtdParcela do
  begin
    if vIndice <> 1 then
    begin
      vDataVencimento := IncMonth(vDataVencimento);
    end;
    vParcela := TParcela.Create(FTipoOrdem, vValorParcela, vDataVencimento);
    FParcelas.Add(vParcela);
  end;
end;

{
  IMPRIMIRITENS
  PARAM : NONE
  CHAMA O TOSTRING DE TODOS OS ITENS DA ORDEM
}
procedure TOrdem.ImprimirItens;
var vOrdemProduto : TOrdemProduto;
begin
  for vOrdemProduto in FItens do
  begin
    Writeln(vOrdemProduto.ToString());
  end;

end;
procedure TOrdem.ImprimirParcelas;
var
vParcela : TParcela;
begin
  Writeln('------------------Ordem : ' + IntToStr(FHandle) + '-----------------------');
  for vParcela in FParcelas do
  begin
    Writeln('Parcela : '+ IntToStr(vParcela.Handle) + 'Tipo : '+ ListaTipo());
  end;
  Writeln('--------------------------------------------------');
end;

{
  LISTAITENS
  PARAM: NONE
  RETORNA UMA STRING COM TODOS OS HANDLES DE ORDEMPRODUTO VINCULADO À ORDEM SEPARADAS POR BARRA '/'
}
function TOrdem.ListaItens(): string;
var vResultado    : string;
    vOrdemProduto : TOrdemProduto;
begin
  for vOrdemProduto in Itens do
  begin
    vResultado := vResultado +' / '+IntToStr(vOrdemProduto.Handle);
  end;
  Result := vResultado;
end;

{
  LISTAPARCELAS
  PARAM  : NONE
  RETURN : STRING
  RETORNA UMA STRING COM TODOS OS HANDLES DAS PARCELAS VINCULADAS A ORDEM SEPARADAS POR BARRA '/'
}
function TOrdem.ListaParcelas: string;
var vResultado  : string;
    vParcela    : TParcela;
begin
  for vParcela in FParcelas do
  begin
    vResultado := vResultado + ' / '+ IntToStr(vParcela.Handle);
  end;
  Result := vResultado;
end;

{
  LISTASTATUS
  PARAM  : NONE
  RETURN : STRING
  RETORNA O STATUS DA ORDEM COMO STRING
}
function TOrdem.ListaStatus: string;
begin
  if FStatus = TStatus.Cadastrado then
  begin
    Result := 'Cadastrado';
  end else if FStatus = TStatus.Cancelado then
  begin
    Result := 'Cancelado';
  end else if FStatus = TStatus.Encerrado then
  begin
    Result := 'Encerrado';
  end;

end;
{
  LISTATIPO
  PARAM  : NONE
  RETURN : STRING
  RETORNA O TIPO DA ORDEM COMO STRING
}
function TOrdem.ListaTipo: string;
begin
  if FTipoOrdem = TTipoOrdem.Compra then
  begin
    Result := 'Compra';
  end else
  begin
    Result := 'Venda';
  end;

end;

procedure TOrdem.SolicitarInformacoes(prTipoOrdem: TTipoOrdem; prPessoa : TPessoa; prProdutos : TList<TProduto>);
begin
  FTipoOrdem := prTipoOrdem;
  FDataCadastro := Now();
  FPessoa := prPessoa;
  SolicitarItens(prProdutos);
end;

procedure TOrdem.SolicitarItens(prProdutos: TList<TProduto>);
var vOrdemProduto : TOrdemProduto;
    vProduto      : TProduto;
    vTexto        : string;
begin
  while vTexto <> '0' do
  begin
    Writeln('Quais desses produtos deseja selecionar? ');
    Writeln('--------------------');
    for vProduto in prProdutos do
    begin
      Writeln('Nome do produto : '+vProduto.Nome);
    end;
    Writeln('SAIR - 0');
    Writeln('--------------------');
    Readln(vTexto);
    for vProduto in prProdutos do
    begin
      if(vProduto.Nome = vTexto) then
      begin
        vOrdemProduto := TOrdemProduto.Create(vProduto);
        vOrdemProduto.SolicitarInformacoes();
        vOrdemProduto.AtualizaEstoque(FTipoOrdem, FStatus);
        FItens.Add(vOrdemProduto);
        Writeln('Produto '+ vProduto.Nome + ' foi adicionado na ordem'+sLineBreak+sLineBreak);
      end;
    end;
  end;
end;

function TOrdem.ToString: string;
begin
  Result := '------------------------------------------------------------------'+sLineBreak+
            'Handle: '+IntToStr(FHandle)                                        +sLineBreak+
            'Tipo da Ordem: '+ListaTipo()                                       +sLineBreak+
            'Itens: '+ListaItens()                                              +sLineBreak+
            'Data Emissao: '+FormatDateTime('dd-mm-yyyy',FDataEmissao)          +sLineBreak+
            'Data Cadastro: '+FormatDateTime('dd-mm-yyyy',FDataCadastro)        +sLineBreak+
            'Pessoa: '+FPessoa.Nome                                             +sLineBreak+
            'Parcelas: '+ListaParcelas()                                        +sLineBreak+
            'Valor Total: '+FormatCurr('#.##0,00', FValorTotal)                 +sLineBreak+
            'Status: '+ListaStatus()                                            +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;

end;

end.

