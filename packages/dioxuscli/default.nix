{ lib
, stdenv
, fetchCrate
, rustPlatform
, pkg-config
, cacert
, openssl
, darwin
, testers
, dioxus-cli
}:

rustPlatform.buildRustPackage rec {
  pname = "dioxus-cli";
  version = "0.5.0-alpha.0";

  src = fetchFromGitHub {
    inherit pname version;
    owner = "DioxusLabs";
    repo = pname;
    rev = "82ab212414dc30c508e5e751cbd3a6ef002ab315";
    hash = "";
  };

  src = ./packages/cli;

  cargoHash = "";

  nativeBuildInputs = [ pkg-config cacert ];
  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreServices
  ];

  OPENSSL_NO_VENDOR = 1;

  checkFlags = [
    # requires network access
    "--skip=server::web::proxy::test::add_proxy"
    "--skip=server::web::proxy::test::add_proxy_trailing_slash"
  ];

  # Omitted: --doc
  # Can be removed after 0.4.3 or when https://github.com/DioxusLabs/dioxus/pull/1706 is resolved
  # Matches upstream package test CI https://github.com/DioxusLabs/dioxus/blob/544ca5559654c8490ce444c3cbd85c1bfb8479da/Makefile.toml#L94-L108
  cargoTestFlags = [
    "--lib"
    "--bins"
    "--tests"
    "--examples"
  ];

  passthru.tests.version = testers.testVersion {
    package = dioxus-cli;
    command = "${meta.mainProgram} --version";
    inherit version;
  };

  meta = with lib; {
    homepage = "https://dioxuslabs.com";
    description = "CLI tool for developing, testing, and publishing Dioxus apps";
    license = with licenses; [ mit asl20 ];
    maintainers = with maintainers; [ xanderio cathalmullan ];
    mainProgram = "dx";
  };
}

