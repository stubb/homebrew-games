class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice/archive/2015-08-09-Release.tar.gz"
  version "2015-08-09"
  sha256 "49d6c3b13872b155b58b1375bc0f75cd4619a66bc5903cea21fe22c64a3f6407"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "5b891aa84f283c040c35f7c6983df37574547e52f0904065eb292eac607201e0" => :yosemite
    sha256 "8e765815083b7141646aaa5cc44291fb073588c4d64d53d4e2bcdd26c68c9458" => :mavericks
    sha256 "afd9d7b666316fd31708fdd7d2af41e7fc4d42856509aae9bdc6571a5dcb7fd9" => :mountain_lion
  end

  option "with-server", "Build `servatrice` for running game servers"

  depends_on "cmake" => :build
  depends_on "protobuf"

  if build.with? "server"
    depends_on "libgcrypt"
    depends_on "qt5" => "with-mysql"
  else
    depends_on "qt5"
  end

  fails_with :clang do
    build 503
    cause "Undefined symbols for architecture x86_64: google::protobuf"
  end

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DWITH_SERVER=ON" if build.with? "server"
      system "cmake", "..", *args
      system "make", "install"
      prefix.install Dir["release/*.app"]
    end
    doc.install Dir["doc/usermanual/*"]
  end

  test do
    (prefix/"cockatrice.app/Contents/MacOS/cockatrice").executable?
    (prefix/"oracle.app/Contents/MacOS/oracle").executable?
  end
end
