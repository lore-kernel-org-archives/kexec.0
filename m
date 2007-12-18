Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7m-0008E6-1n
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:32 +0000
MIME-Version: 1.0
Subject: [PATCH 5/8] Add gamecube to config.h defines
Message-Id: <1197967675.858281.846953540174.5.gpush@pokey>
In-Reply-To: <1197967675.854275.930419561848.0.gpush@pokey>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 18 Dec 2007 17:47:55 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

.. instead of messing with CFLAGS.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 configure.ac                   |    6 ++++--
 kexec/arch/ppc/kexec-elf-ppc.c |    4 +++-
 kexec/arch/ppc/kexec-ppc.c     |    4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index d036ba1..8574bc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -70,8 +70,10 @@ fi;
 AC_ARG_WITH([objdir], AC_HELP_STRING([--with-objdir=<dir>],[select directory for object files]),
 	[ OBJDIR="$withval" ], [ OBJDIR="$OBJDIR" ])
 
-AC_ARG_WITH([gamecube], AC_HELP_STRING([--with-gamecube],[enable gamecube support]),
-	[ EXTRA_CFLAGS="$EXTRA_CFLAGS -DCONFIG_GAMECUBE=1" ])
+AC_ARG_WITH([gamecube],
+		AC_HELP_STRING([--with-gamecube],[enable gamecube support]),
+		AC_DEFINE(WITH_GAMECUBE, 1,
+			[Define to include gamecube support]))
 
 AC_ARG_WITH([zlib], AC_HELP_STRING([--without-zlib],[disable zlib support]),
 	[ with_zlib="$withval"], [ with_zlib=yes ] )
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 241c803..571349d 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -25,6 +25,8 @@
 #include "kexec-ppc.h"
 #include <arch/options.h>
 
+#include "config.h"
+
 static const int probe_debug = 0;
 
 #define MAX_COMMAND_LINE   256
@@ -135,7 +137,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	unsigned char *setup_start;
 	uint32_t setup_size;
 	int result;
-#ifdef CONFIG_GAMECUBE
+#ifdef WITH_GAMECUBE
 	int target_is_gamecube = 1;
 #else
 	int target_is_gamecube = 0;
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index df05212..9a88f9c 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -18,6 +18,8 @@
 #include "kexec-ppc.h"
 #include <arch/options.h>
 
+#include "config.h"
+
 #define MAX_MEMORY_RANGES  64
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
@@ -26,7 +28,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 					unsigned long kexec_flags)
 {
 	int memory_ranges = 0;
-#ifdef CONFIG_GAMECUBE
+#ifdef WITH_GAMECUBE
 	/* RAM - lowmem used by DOLs - framebuffer */
 	memory_range[memory_ranges].start = 0x00003000;
 	memory_range[memory_ranges].end = 0x0174bfff;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
