Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH0R-00Ck8h-GA
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:26:29 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 7/7] github: initial workflow
Date: Fri,  2 Apr 2021 12:17:37 +0200
Message-Id: <20210402101737.1886-8-horms@verge.net.au>
In-Reply-To: <20210402101737.1886-1-horms@verge.net.au>
References: <20210402101737.1886-1-horms@verge.net.au>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Initial github workflow which builds kexec on a range of architectures.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 .github/workflows/build.yml | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 .github/workflows/build.yml

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
new file mode 100644
index 0000000..df35703
--- /dev/null
+++ b/.github/workflows/build.yml
@@ -0,0 +1,72 @@
+name: Build
+
+on: push
+
+jobs:
+  build:
+    name: Build
+    runs-on: ubuntu-20.04
+    strategy:
+      matrix:
+        arch:
+        - arm
+        - arm64
+        - hppa
+        - i686
+        - m68k
+        - mips
+        - mipsel
+        - powerpc
+        - powerpc64
+        - powerpc64le
+        - sh4
+        - s390x
+        - x86_64-x32
+        include:
+          - arch: x86_64
+          - arch: x86_64
+            libxen: libxen
+    steps:
+    - name: Checkout
+      uses: actions/checkout@v2
+
+    - name: Set Environment
+      env:
+        LIBXEN: ${{ matrix.libxen }}
+        ARCH: ${{ matrix.arch }}
+      run: |
+        case $LIBXEN in
+          libxen) EXTRA_PKGS+=" libxen-dev" ;;
+        esac
+
+        case $ARCH in
+          arm)         GNU_ARCH="arm-linux-gnueabi" ;;
+          arm64)       GNU_ARCH="aarch64-linux-gnu" ;;
+          x86_64)      ;;
+          x86_64-x32)  GNU_ARCH="x86_64-linux-gnux32"
+                       CROSS_COMPILER_PKG="gcc-x86-64-linux-gnux32" ;;
+          *)           GNU_ARCH="$ARCH-linux-gnu" ;;
+        esac
+
+        if [ -n "$GNU_ARCH" ]; then
+          if [ -z "$CROSS_COMPILER_PKG" ]; then
+            CROSS_COMPILER_PKG="gcc-$GNU_ARCH"
+          fi
+          EXTRA_PKGS+=" $CROSS_COMPILER_PKG"
+          CONFIG_FLAGS+=" --host=$GNU_ARCH"
+        fi
+
+        echo "EXTRA_PKGS=$EXTRA_PKGS" >> $GITHUB_ENV
+        echo "CONFIG_FLAGS=$CONFIG_FLAGS" >> $GITHUB_ENV
+
+    - name: Install Dependencies
+      if: env.EXTRA_PKGS != ''
+      run: sudo apt-get -q=2 install ${{ env.EXTRA_PKGS }}
+
+    - name: Build
+      run: |
+        ./bootstrap
+        ./configure ${{ env.CONFIG_FLAGS }}
+        make -j"$(nproc)" distcheck \
+          DISTCHECK_CONFIGURE_FLAGS="${{ env.CONFIG_FLAGS }}"
+
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
