Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9y2l-0005p1-1G
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:10:30 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 25/32] arm: crashdump needs boot alias of crash
 kernel region
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xtU-0003tq-Np@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:00:52 +0100
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

When crashdumping, we need the boot memory alias of the crash kernel
region rather than the system view.  Arrange to check for the boot
alias of the crash kernel region first, and if found, use it instead
of the main alias.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 4755f06..fdd2910 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -20,6 +20,7 @@
 #include "kexec-arm.h"
 #include "../../fs2dt.h"
 #include "crashdump-arm.h"
+#include "iomem.h"
 
 #define BOOT_PARAMS_SIZE 1536
 
@@ -446,7 +447,8 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		 * We put the dump capture kernel at the start of crashkernel
 		 * reserved memory.
 		 */
-		if (parse_iomem_single("Crash kernel\n", &start, &end)) {
+		if (parse_iomem_single(CRASH_KERNEL_BOOT, &start, &end) &&
+		    parse_iomem_single(CRASH_KERNEL, &start, &end)) {
 			/*
 			 * No crash kernel memory reserved. We cannot do more
 			 * but just bail out.
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
