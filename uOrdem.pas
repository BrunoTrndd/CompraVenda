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
  destructor Destroy();

// PROCEDURE
  procedure SolicitarInformacoes(prTipoOrdem : TTipoOrdem; prPessoa : TPessoa; prProdutos : TList<TProduto>);
  procedure SolicitarItens(prProdutos : TList<TProduto>);
  procedure AtualizaEstoque();
  procedure EncerraOrdem();
  procedure GeraParcela(prQtdParcela : Integer; prDataVencimento : TDateTime);

// FUNCTION
  function ToString() : string;
  function ListaTipo() : string;
  function ListaItens() : string;
  function ListaParcelas():string;
  function ListaStatus(): string;



end;
var
vOrdemProduto : TOrdemProduto;
vPessoa       : TPessoa;
vParcela      : TParcela;
vHandle       : Integer;

implementation

{ TOrdem }

procedure TOrdem.AtualizaEstoque;
begin

end;

constructor TOrdem.Create;
begin
  FHandle       := 0;
  FTipoOrdem    := TTipoOrdem.Compra;  //FIXADO PARA CRIAR COMO COMPRA
  FItens        := TList<TOrdemProduto>.Create;
  FDataEmissao  := 0;
  FValorTotal   := 0;
  FStatus       := TStatus.Cadastrado;
  FPessoa       := nil;
  FDataCadastro := 0;
  FParcelas     := TList<TParcela>.Create;
end;

destructor TOrdem.Destroy();
begin
  for vOrdemProduto in Itens do
  begin
    vOrdemProduto.Destroy();
  end;
  for vParcela in Parcelas do
  begin
    vParcela.Destroy();
  end;

  Itens.Free;
  Parcelas.Free;
  FPessoa.Destroy();

end;

{
  ENCERRAORDEM
  ENCERRA A ORDEM
  PARAM : NONE
  ENCERRA A ORDEM ATUALIZANDO O ESTOQUE E GERANDO PARCELAS
}
procedure TOrdem.EncerraOrdem;
var
vQtdParcela    : Integer;
vData          : TDateTime;
vDiaVencimento : Integer;
begin
  if FStatus = TStatus.Cadastrado then
  begin
    //PEDIR QTD PARCELA
    Writeln('Quantas parcelas deseja criar na ordem?');
    Readln(vQtdParcela);

    Writeln('Qual dia sera o vencimento das parcelas?');
    Readln(vDiaVencimento);

    vData := EncodeDate(YearOf(Now()),MonthOf(Now()), vDiaVencimento);
    GeraParcela(vQtdParcela, vData);


  end;
end;


{
  GERAPARCELA
  GERA AS PARCELAS DA ORDEM
  PARAM : QUANTIDADE DE PARCELAS : INTEGER
  GERA O INTEGER PASSADO COMO PARÂMETRO EM QUANTIDADE DE PARCELA
}
procedure TOrdem.GeraParcela(prQtdParcela: Integer; prDataVencimento : TDateTime);
var
vValorTotal     : Currency;
vValorParcela   : Currency;
vIndice         : Integer;
vDataVencimento : TDateTime;

begin

  for vOrdemProduto in Itens do
  begin
    vValorTotal := vValorTotal + vOrdemProduto.Valor;
  end;

  vValorParcela := vValorTotal/prQtdParcela;
  vDataVencimento := prDataVencimento;

  for vIndice := 1 to prQtdParcela do
  begin
    if vIndice <> 1 then
    begin
      IncMonth(vDataVencimento);
    end;

    vParcela := TParcela.Create(FTipoOrdem, vValorParcela, vDataVencimento);
    FParcelas.Add(vParcela);

  end;


end;

function TOrdem.ListaItens(): string;
var
vResultado : string;
begin
  for vOrdemProduto in Itens do
  begin
    vResultado := vResultado +' / '+IntToStr(vOrdemProduto.Handle);
  end;
  Result := vResultado;
end;

function TOrdem.ListaParcelas: string;
var
vResultado : string;
begin
  for vParcela in Parcelas do
  begin
    vResultado := vResultado + ' / '+ IntToStr(vParcela.Handle);
  end;
  Result := vResultado;
end;

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
var
vNumero : Integer;
i       : Integer;
vValorTotal : Currency;
begin
  vHandle := vHandle + 1;
  FHandle := vHandle;

  FTipoOrdem := prTipoOrdem;
  FDataCadastro := Now();
  FStatus := TStatus.Cadastrado;
  FPessoa := prPessoa;

  SolicitarItens(prProdutos);

end;

procedure TOrdem.SolicitarItens(prProdutos: TList<TProduto>);
var
vProduto : TProduto;
vTexto : string;
begin
  Writeln('Quais desses produtos deseja selecionar? '+sLineBreak+' 0 - SAIR');
  for vProduto in prProdutos do
  begin
    Writeln(vProduto.Nome);
  end;
  Readln(vTexto);

  for vProduto in prProdutos do
  begin
    if(vProduto.Nome = vTexto) then
    begin
      vOrdemProduto := TOrdemProduto.Create(vProduto);
      vOrdemProduto.SolicitarInformacoes();
      FItens.Add(vOrdemProduto);
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

