unit uOrdem;

interface
uses uProduto,
     uParcela,
     uOrdemProduto,
     uEnums,
     uPessoa,
     SysUtils,
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

implementation

{ TOrdem }

constructor TOrdem.Create;
begin
  FHandle       := 0;
  FTipoOrdem    := TTipoOrdem.Compra;  //FIXADO PARA CRIAR COMO COMPRA
  FItens        := TList<TOrdemProduto>.Create;
  FDataEmissao  := 0;
  FValorTotal   := 0;
  FStatus       := TStatus.Cadastrado;
  FPessoa       := TPessoa.Create;
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
