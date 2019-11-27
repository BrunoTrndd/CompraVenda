unit uProduto;

interface

uses SysUtils, Generics.Collections;

type
  TProduto = class
  private
    FNome               : string;
    FValorUnit          : currency;
    FTipoProduto        : string; //TTipoProduto
    FEmpresa            : TEmpresa;
    FValorCompra        : currency;
    FValorVenda         : currency;
    FSaldoVenda         : integer;
    FSaldoDisponivel    : integer;
    FNaturezaMercadoria : TNaturezaMercadoria;

  public
    property Nome               : string read FNome write FNome;
    property ValorUnit          : currency read FValorUnit write FValorUnit;
    property TipoProduto        : string read FTipoProduto write FTipoProduto;
    property Empresa            : TEmpresa read FEmpresa write FEmpresa;
    property ValorCompra        : currency read FValorCompra write FValorCompra;
    property ValorVenda         : currency read FValorVenda write FValorVenda;
    property SaldoDisponivel    : integer read FSaldoDisponivel write FSaldoDisponivel;
    property SaldoVenda         : integer read FSaldoVenda write FSaldoVenda;
    property NaturezaMercadoria : TNaturezaMercadoria read FNaturezaMercadoria write FNaturezaMercadoria;

  //CONSTRUCTORS
  constructor Create();
  destructor  destroy;override;

  //PROCEDURES
  procedure SolicitarInformacao();
  procedure ToString();

  //FUNCTIONS

  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  FNome               := '';
  FValorUnit          := 0.00;
  FTipoProduto        := ''; //TTipoProduto
  FEmpresa            := nil;
  FValorCompra        := 0.00;
  FValorVenda         := 0.00;
  FSaldoVenda         := 0;
  FSaldoDisponivel    := 0;
  FNaturezaMercadoria := nil;
end;

destructor TProduto.Destroy;
begin

end;

procedure TProduto.SolicitarInformacao;
begin
  write('Nome do produto: ');
  readln(FNome);

  write('Valor unitário: ');
  readln(FValorUnit);

  write('Produto: ');
end;

end.
