Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1axXUZ-0002m3-8R
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:23:48 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 25/32] arm: crashdump needs boot alias of crash
 kernel region
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXU1-0004jO-4q@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:23:13 +0100
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
Cc: Pratyush Anand <panand@redhat.com>

When crashdumping, we need the boot memory alias of the crash kernel
region rather than the system view.  Arrange to check for the boot
alias of the crash kernel region first, and if found, use it instead
of the main alias.

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
