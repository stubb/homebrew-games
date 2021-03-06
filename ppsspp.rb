class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.1.1",
                                                :revision => "91e576449fd538e9a0885128b8156a32ad939222"
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    cellar :any
    sha256 "553c6b51fb48a595fa9129f743fe33fcffcf0d45e97bc6bcc1185ee34392492c" => :el_capitan
    sha256 "bdbb42254b0cd840324044a1a2f6e3d34f766646443ca6be613025f9d5c32c82" => :yosemite
    sha256 "b29c42b0f15d36b5581f8dab5ed78146d8846f84670c3e047e5837ab1aea841c" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "sdl2"
  depends_on "glew"
  depends_on "snappy"
  depends_on "ffmpeg"

  def install
    args = std_cmake_args
    # Use brewed FFmpeg rather than precompiled binaries in the repo
    args << "-DUSE_SYSTEM_FFMPEG=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      prefix.install "PPSSPPSDL.app"
      bin.write_exec_script "#{prefix}/PPSSPPSDL.app/Contents/MacOS/PPSSPPSDL"
    end
  end
end
