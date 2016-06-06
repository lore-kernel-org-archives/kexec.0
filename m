Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1b9y1J-0001Xf-T5
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:08:58 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 24/32] arm: add support for platforms with boot
 memory aliases
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xtP-0003tk-HN@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:00:47 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

The kexec API deals with boot-view addresses, rather than normal system
view addresses.  This causes problems for platforms such as Keystone 2,
where the boot view is substantially different from the normal system
view.

This is because Keystone 2 boots from a memory alias in the lower 4GiB,
before switching to a high alias at 32GiB.

We handle this in a generic way by introducing boot alias resources in
/proc/iomem:

80000000-dfffffff : System RAM (boot alias)
  9f800000-9fffffff : Crash kernel (boot alias)
800000000-85fffffff : System RAM
  800008000-800790e37 : Kernel code
  8007ec000-8008b856f : Kernel data
  81f800000-81fffffff : Crash kernel

To allow kexec to load a kernel, we need to add the boot alias of RAM
to the memory ranges returned by get_memory_ranges().  Parse the
system RAM boot alias into the memory ranges.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/iomem.h     | 2 ++
 kexec/arch/arm/kexec-arm.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/iomem.h b/kexec/arch/arm/iomem.h
index 81c593d..85f958e 100644
--- a/kexec/arch/arm/iomem.h
+++ b/kexec/arch/arm/iomem.h
@@ -2,6 +2,8 @@
 #define IOMEM_H
 
 #define SYSTEM_RAM		"System RAM\n"
+#define SYSTEM_RAM_BOOT		"System RAM (boot alias)\n"
 #define CRASH_KERNEL		"Crash kernel\n"
+#define CRASH_KERNEL_BOOT	"Crash kernel (boot alias)\n"
 
 #endif
diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index eeb27b4..2194b7c 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -18,6 +18,7 @@
 #include "kexec-arm.h"
 #include <arch/options.h>
 #include "../../fs2dt.h"
+#include "iomem.h"
 
 #define MAX_MEMORY_RANGES 64
 #define MAX_LINE 160
@@ -52,7 +53,8 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 			continue;
 		str = line + consumed;
 
-		if (memcmp(str, "System RAM\n", 11) == 0) {
+		if (memcmp(str, SYSTEM_RAM_BOOT, strlen(SYSTEM_RAM_BOOT)) == 0 ||
+		    memcmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0) {
 			type = RANGE_RAM;
 		}
 		else if (memcmp(str, "reserved\n", 9) == 0) {
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
