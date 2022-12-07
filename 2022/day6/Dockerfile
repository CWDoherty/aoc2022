FROM ocaml/opam:latest

ADD . ./

RUN opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release
WORKDIR day6
USER root
RUN opam install core
RUN eval $(opam env) && dune build

CMD ["dune", "exec", "day6"]
