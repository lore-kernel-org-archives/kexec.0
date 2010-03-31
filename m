Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NwtDw-0002uT-Ef
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 08:24:30 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 7/7] Let SH adn ARM use common uImage probe code
Date: Wed, 31 Mar 2010 10:24:18 +0200
Message-Id: <1270023858-26947-8-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
References: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org, Marc Andre Tanner <mat@brain-dump.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The now generic probe function is more complete than the currently used.
It seems that ARM's and SH's uImage are always uncompressed so it might
be good to check for this.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Marc Andre Tanner <mat@brain-dump.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kexec/arch/arm/Makefile           |    1 +
 kexec/arch/arm/kexec-uImage-arm.c |   15 ++-------------
 kexec/arch/sh/Makefile            |    1 +
 kexec/arch/sh/kexec-uImage-sh.c   |   15 ++-------------
 4 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 9416339..2ecdb66 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -5,6 +5,7 @@ arm_KEXEC_SRCS=  kexec/arch/arm/kexec-elf-rel-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-uImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-arm.c
+arm_KEXEC_SRCS+= kexec/kexec-uImage.c
 
 dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS)			\
 	kexec/arch/arm/kexec-arm.h					\
diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index e881fd8..4875185 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -5,24 +5,13 @@
 #include <string.h>
 #include <sys/types.h>
 #include <image.h>
+#include <kexec-uImage.h>
 #include "../../kexec.h"
 #include "kexec-arm.h"
 
 int uImage_arm_probe(const char *buf, off_t len)
 {
-	struct image_header header;
-
-	if ((uintmax_t)len < (uintmax_t)sizeof(header))
-		return -1;
-
-	memcpy(&header, buf, sizeof(header));
-
-	if (cpu_to_be32(header.ih_magic) != IH_MAGIC)
-		return -1;
-
-	/* XXX: check CRC Checksum? */
-
-	return 0;
+	return uImage_probe(buf, len, IH_ARCH_ARM);
 }
 
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
diff --git a/kexec/arch/sh/Makefile b/kexec/arch/sh/Makefile
index 9ccd008..a9f6081 100644
--- a/kexec/arch/sh/Makefile
+++ b/kexec/arch/sh/Makefile
@@ -9,6 +9,7 @@ sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-rel-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/netbsd_booter.S
 sh_KEXEC_SRCS += kexec/arch/sh/crashdump-sh.c
+sh_KEXEC_SRCS += kexec/kexec-uImage.c
 
 sh_ADD_BUFFER =
 sh_ADD_SEGMENT =
diff --git a/kexec/arch/sh/kexec-uImage-sh.c b/kexec/arch/sh/kexec-uImage-sh.c
index c2bce53..e983165 100644
--- a/kexec/arch/sh/kexec-uImage-sh.c
+++ b/kexec/arch/sh/kexec-uImage-sh.c
@@ -7,24 +7,13 @@
 #include <string.h>
 #include <sys/types.h>
 #include <image.h>
+#include <kexec-uImage.h>
 #include "../../kexec.h"
 #include "kexec-sh.h"
 
 int uImage_sh_probe(const char *buf, off_t len)
 {
-	struct image_header header;
-
-	if ((uintmax_t)len < (uintmax_t)sizeof(header))
-		return -1;
-
-	memcpy(&header, buf, sizeof(header));
-
-	if (cpu_to_be32(header.ih_magic) != IH_MAGIC)
-		return -1;
-
-	/* XXX: check CRC Checksum? */
-
-	return 0;
+	return uImage_probe(buf, len, IH_ARCH_SH);
 }
 
 int uImage_sh_load(int argc, char **argv, const char *buf, off_t len,
-- 
1.6.5.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
