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

  //PROCEDIMENTOS
  procedure SolicitarInformacao();

  //FUNCTIONS
  function Tostring(): string;
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

procedure TEmpresa.SolicitarInformacao();
begin
  write('Nome: ');
  readln(FNome);

  write('Saldo inicial: ');
  readln(FSaldo);
end;

function TEmpresa.ToString;
begin
  Result := '-------------------------------Empresa----------------------------'+sLineBreak+
            'Nome : '+FNome                                                     +sLineBreak+
            'Saldo inicial: '+FormatCurr('#.#00,00',FSaldo)                     +sLineBreak+
            '------------------------------------------------------------------'+sLineBreak;
end;
end.
