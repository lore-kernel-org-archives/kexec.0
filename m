Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b8kqO-0006oq-Pu
 for kexec@lists.infradead.org; Fri, 03 Jun 2016 08:52:41 +0000
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/8] ARM: kdump: advertise boot aliased crash kernel resource
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b8knz-0004H4-Bd@rmk-PC.armlinux.org.uk>
Date: Fri, 03 Jun 2016 09:50:11 +0100
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Advertise a resource which describes where the crash kernel is located
in the boot view of RAM.  This allows kexec-tools to have this vital
information.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d9317eec1eba..19b25ad61385 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1003,9 +1003,25 @@ static void __init reserve_crashkernel(void)
 		(unsigned long)(crash_base >> 20),
 		(unsigned long)(total_mem >> 20));
 
+	/* The crashk resource must always be located in normal mem */
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
+
+	if (arm_has_idmap_alias()) {
+		/*
+		 * If we have a special RAM alias for use at boot, we
+		 * need to advertise to kexec tools where the alias is.
+		 */
+		static struct resource crashk_boot_res = {
+			.name = "Crash kernel (boot alias)",
+			.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
+		};
+
+		crashk_boot_res.start = phys_to_idmap(crash_base);
+		crashk_boot_res.end = crashk_boot_res.start + crash_size - 1;
+		insert_resource(&iomem_resource, &crashk_boot_res);
+	}
 }
 #else
 static inline void reserve_crashkernel(void) {}
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
