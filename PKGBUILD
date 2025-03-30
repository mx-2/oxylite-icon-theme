pkgname=oxylite-icon-theme
pkgver=1.1.5
pkgrel=1
pkgdesc="A skeuomorphic SVG icon theme"
arch=(any)
options=(!emptydirs)
url=""
branch=master
source=("git+https://github.com/mx-2/oxylite-icon-theme.git#branch=$branch")
sha256sums=("SKIP")

package() {
    cd oxylite-icon-theme
    PREFIX=${pkgdir} make install
}
