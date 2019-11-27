unit uEmpresa;

interface

uses SysUtils, Generics.Collections, uOrdem, uPessoa, uEstoque;

type
  TEmpresa = class
  private
    FNome    : string;
    FSaldo   : currency;
    FOrdens  : TList<TOrdem>;
    FPessoas : TList<TPessoa>;
    FEstoque : TList<TEstoque>;

  public
    property Nome    : string          read FNome    write FNome;
    property Saldo   : currency        read FSaldo   write FSaldo;
    property Ordens  : TList<TOrdem>   read FOrdens  write FOrdens;
    property Pessoas : TList<TPessoa>  read FPessoas write FPessoas;
    property Estoque : TList<TEstoque> read FEstoque write FEstoque;

  //CONSTRUCTOR
  constructor TEmpresa.Create;

  end;

implementation

end.
