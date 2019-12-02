unit uOrdemProduto;

interface

uses SysUtils, uProduto, uEnums;

type
  TOrdemProduto = class

  private
    FHandle     : Integer;
    FProduto    : TProduto;
    FValor      : Currency;
    FQuantidade : Integer;

  public
    property Handle      : Integer   read FHandle      write FHandle;
    property Produto     : TProduto  read FProduto     write FProduto;
    property Valor       : Currency  read FValor       write FValor;
    property Quantidade  : Integer   read FQuantidade  write FQuantidade;

    //CONSTRUCTOR
    constructor Create(prProduto : TProduto);

    //DESTRUCTOR
    destructor Destroy();

    //PROCEDURE
    procedure SolicitarInformacoes();
    procedure AtualizaEstoque(prTipoMovimentacao: TTipoOrdem; prStatusOrdem: TStatus);

    //FUNCTION
    function ToString : string;

  end;

var
vHandle : Integer;
implementation

{ TOrdemProduto }

procedure TOrdemProduto.AtualizaEstoque(prTipoMovimentacao: TTipoOrdem;
                                        prStatusOrdem: TStatus);
begin
  FProduto.AtualizaEstoque(FQuantidade, prTipoMovimentacao, prStatusOrdem);
end;

constructor TOrdemProduto.Create(prProduto : TProduto);
begin
  vHandle     := vHandle + 1;
  FHandle     := vHandle;
  FProduto    := prProduto;
  FValor      := 0;
  FQuantidade := 0;
end;

destructor TOrdemProduto.Destroy();
begin
  inherited;
end;

procedure TOrdemProduto.SolicitarInformacoes();
begin
  Writeln('Informe qual o valor:');
  read(FValor);
  Writeln('Informe a quantia:');
  read(FQuantidade);
  Writeln('Cadastro finalizado!');
end;

function TOrdemProduto.ToString(): string;
begin
  result  :=  '----------------------- Item da Ordem -----------------------'+sLineBreak+
              'Handle     : '+IntToStr(FHandle)                              +sLineBreak+
              'Produto    : '+FProduto.Nome                                  +sLineBreak+
              'Valor      : '+FormatCurr('R$#,##0.00',FValor)                +sLineBreak+
              'Quantidade : '+IntToStr(FQuantidade)                          +sLineBreak+
              '-------------------------------------------------------------'+sLineBreak;
end;

end.
