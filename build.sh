SBCL=sbcl

$SBCL \
    --noinform --lose-on-corruption --end-runtime-options \
    --no-userinit --no-sysinit \
    --eval "(pushnew :paktahn-deploy *features*)" \
    --eval "(require :asdf)" \
    --eval "(push #p\"/usr/share/common-lisp/systems/\" asdf:*central-registry*)" \
    --eval "(asdf:oos 'asdf:load-op 'paktahn)" \
    --eval "(pak::build-core :forkp nil)"
