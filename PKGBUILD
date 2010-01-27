# Contributor: Brit Butler <redline6561@gmail.com>
# Contributor: Leslie P. Polzer <polzer@gnu.org>
# Maintainer: Leslie P. Polzer <polzer@gnu.org>

pkgname=paktahn
pkgver=0.8.2
libver=0.8
pkgrel=2
pkgdesc="The kick-ass package manager for Arch Linux!"
arch=('i686' 'x86_64')
depends=('pacman' 'readline' 'sudo')
makedepends=('sbcl>=1.0.32' 'cl-md5' 'cl-cffi' 'cl-alexandria-darcs' 'cl-split-sequence' 'cl-ppcre')
license=('GPL')
url="http://github.com/skypher/paktahn"
options=(!strip)
install="paktahn.install"
source=()
md5sums=()

build() {

  cd $startdir
  
  # compile
  SBCL=sbcl

  $SBCL \
       --noinform --lose-on-corruption --end-runtime-options \
       --no-userinit --no-sysinit \
       --eval "(pushnew :paktahn-deploy *features*)" \
       --eval "(require :asdf)" \
       --eval "(push #p\"/usr/share/common-lisp/systems/\" asdf:*central-registry*)" \
       --eval "(asdf:oos 'asdf:load-op 'paktahn)" \
       --eval "(pak::build-core :forkp nil)"

  # install binary
  mkdir -p $pkgdir/usr/bin
  install -m755 paktahn $pkgdir/usr/bin

  # install helper scripts
  mkdir -p $pkgdir/usr/lib/paktahn
  for helper in pkgbuild-helper.sh makepkg-helper.sh; do
    install -m755 "$helper" $pkgdir/usr/lib/paktahn
  done

  # create convenience symlink
  cd $pkgdir/usr/bin
  ln -s paktahn pak
}
