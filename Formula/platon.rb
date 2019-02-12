class Platon < Formula
  desc "Multipurpose crystallographic tool"
  homepage "http://www.cryst.chem.uu.nl/spek/platon/"
  url "http://www.cryst.chem.uu.nl/spek/xraysoft/unix/platon.tar.gz"
  version "0"

  depends_on "gcc" # for gfortran
  depends_on :x11

  def install
    system "gunzip", "platon.f.gz", "xdrvr.c.gz"
    system "gfortran", "-o", "platon", "platon.f", "xdrvr.c",
                       "-I#{MacOS::X11.include}", "-L#{MacOS::X11.lib}", "-lX11"
    bin.install "platon"

    rm_f "platon"
    system "tar", "xfz", "platon_html.tar.gz"
    pkgshare.install "platon"
    pkgshare.install "s810c.cif"
  end

  def caveats; <<~EOS
    PLATON does not have version numbers :(
    It gives a warning during download, and will not be updated automatically.
    EOS
  end

  test do
    output = shell_output("#{bin}/platon -o test.out s810c.cif </dev/null")
    assert_match "NORMAL END of PLATON", output
  end
end
