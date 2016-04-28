Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aviFd-0004cX-Bi
 for kexec@lists.infradead.org; Thu, 28 Apr 2016 09:28:50 +0000
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 03/12] ARM: kexec: remove 512MB restriction on kexec crashdump
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1aviEp-0000ir-7s@rmk-PC.arm.linux.org.uk>
Date: Thu, 28 Apr 2016 10:27:59 +0100
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
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Jonathan Corbet <corbet@lwn.net>, Ian Campbell <ijc+devicetree@hellion.org.uk>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, Vivek Goyal <vgoyal@redhat.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 77b54c461c52..d9317eec1eba 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -943,7 +943,6 @@ late_initcall(init_machine_late);
  * zImage relocating below the reserved region.
  */
 #define CRASH_ALIGN	(128 << 20)
-#define CRASH_ADDR_MAX	(PHYS_OFFSET + (512 << 20))
 
 static inline unsigned long long get_total_mem(void)
 {
@@ -973,9 +972,7 @@ static void __init reserve_crashkernel(void)
 		return;
 
 	if (crash_base <= 0) {
-		unsigned long long crash_max = CRASH_ADDR_MAX;
-		if (crash_max > (u32)~0)
-			crash_max = (u32)~0;
+		unsigned long long crash_max = idmap_to_phys((u32)~0);
 		crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,
 						    crash_size, CRASH_ALIGN);
 		if (!crash_base) {
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
