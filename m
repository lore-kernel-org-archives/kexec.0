Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1446842218.24647.42.camel@infradead.org>
Subject: [PATCH] purgatory: Change default sha256 optimization to -O2
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 06 Nov 2015 12:36:58 -0800
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Scott Wood <scottwood@freescale.com>, kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Change the default purgatory sha256 code optimization from -O0 to -O2, and add a
new arch specific makefile variable $(ARCH)_PURGATORY_SHA256_CFLAGS which can
over ride this default.  Set ia64_PURGATORY_SHA256_CFLAGS to -O0 to retain the
previous optimization level for ia64.

The purgatory sha256 code needs the be built with -O0 for the  ia64
architecture.  Currently this code is built with -O0 for all architectures,
which slows down the calculations for architectures which could otherwise
use -O2.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Tested on arm64.  Seems to work OK.

 purgatory/Makefile           | 4 +---
 purgatory/arch/ia64/Makefile | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index ca0443c..328904e 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -38,9 +38,7 @@ clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY)
 
 -include $(PURGATORY_DEPS)
 
-# sha256.c needs to be compiled without optimization, else
-# purgatory fails to execute on ia64.
-purgatory/sha256.o: CFLAGS += -O0
+purgatory/sha256.o: CFLAGS += -O2 $($(ARCH)_PURGATORY_SHA256_CFLAGS)
 
 purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
 	mkdir -p $(@D)
diff --git a/purgatory/arch/ia64/Makefile b/purgatory/arch/ia64/Makefile
index 32c3d97..4a2564c 100644
--- a/purgatory/arch/ia64/Makefile
+++ b/purgatory/arch/ia64/Makefile
@@ -8,6 +8,10 @@ ia64_PURGATORY_SRCS += purgatory/arch/ia64/vga.c
 
 ia64_PURGATORY_EXTRA_CFLAGS = -ffixed-r28
 
+# sha256.c needs to be compiled without optimization, else
+# purgatory fails to execute on ia64.
+ia64_PURGATORY_SHA256_CFLAGS = -O0
+
 dist += purgatory/arch/ia64/Makefile $(ia64_PURGATORY_SRCS)	\
 	purgatory/arch/ia64/io.h purgatory/arch/ia64/purgatory-ia64.h
 
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
