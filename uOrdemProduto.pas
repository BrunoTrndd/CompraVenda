unit uOrdemProduto;

interface

uses
  uProduto,
  uOrdem,
  Generics.Collections,
  SysUtils;

type
  TOrdemProduto = class
  public
    FHandle     : Integer;
    FProduto    : TProduto;
    FValor      : Currency;
    FQuantidade : Integer;

    property  Produto     : TProduto  read FProduto;
    property  Valor       : Currency  read FValor;
    property  Quantidade  : Integer   read FQuantidade;

    //CONSTRUCTOR
    constructor Create(prLista: TList<TOrdemProduto>);
    destructor Destroy;

    //PROCEDURE
    procedure SolicitarInformacoes();
    procedure AtualizarEstoque(prTipoMovimentacao, prQuantidade: Integer);

    //FUNCTION
    function ToString : string;
    function GetItem  : TProduto;
  private
  end;

implementation

{ TOrdemProduto }

procedure TOrdemProduto.AtualizarEstoque(prTipoMovimentacao,
  prQuantidade: Integer);
begin

end;

constructor TOrdemProduto.Create();
begin
  FHandle     := 0;
  FProduto    := nil;
  FValor      := 0;
  FQuantidade := 0;
end;

destructor TOrdemProduto.Destroy;
begin

end;

function TOrdemProduto.GetItem: TProduto;
begin

end;

procedure TOrdemProduto.SolicitarInformacoes;
begin
  Writeln('Informe o nome do produto:');
  FProduto  := GetItem();
  Writeln('Informe qual o valor:');
  read(FValor);
  Writeln('Informe a quantia:');
  read(FQuantidade);
  Writeln('Cadastro finalizado!');
end;

function TOrdemProduto.ToString: string;
begin
  result  :=  '----------------------- Item da Ordem -----------------------'+sLineBreak+
              'Handle     : '+IntToStr(FHandle)+
              'Produto    : '+FProduto.Nome+
              'Valor      : '+FormatCurr('R$#,##0.00',FValor)+
              'Quantidade : '+IntToStr(FQuantidade);
end;

end.
