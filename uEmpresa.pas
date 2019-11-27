unit uEmpresa;

interface

uses SysUtils, Generics.Collections, uOrdem, uPessoa;

type
  TEmpresa = class
  private
    FNome    : string;
    FSaldo   : currency;
    FOrdens  : TList<TOrdem>;
    FPessoas : TList<TPessoa>;

  public
    property Nome    : string          read FNome    write FNome;
    property Saldo   : currency        read FSaldo   write FSaldo;
    property Ordens  : TList<TOrdem>   read FOrdens  write FOrdens;
    property Pessoas : TList<TPessoa>  read FPessoas write FPessoas;

  //CONSTRUCTOR
  constructor Create;

  //DESTRUCTOR
  destructor Destroy;override;

  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create();
begin
  FNome := '';
  FSaldo := 0.00;
  FOrdens := TList<TOrdem>.Create;
  FPessoas := TList<TPessoa>.Create;
end;

destructor TEmpresa.Destroy();
begin
  FOrdens.Free;
  FPessoas.Free;
end;
end.
