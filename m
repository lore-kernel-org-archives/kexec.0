Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aviFs-0004p6-Bx
 for kexec@lists.infradead.org; Thu, 28 Apr 2016 09:29:05 +0000
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 04/12] ARM: provide arm_has_idmap_alias() helper
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1aviEu-0000ix-C1@rmk-PC.arm.linux.org.uk>
Date: Thu, 28 Apr 2016 10:28:04 +0100
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

Provide a helper to indicate whether we need to perform special handling
for boot identity mapping aliases or not.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/memory.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ca208335fde6..31c07a2cc100 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -295,6 +295,11 @@ extern long long arch_phys_to_idmap_offset;
  * of physical memory for idmap purposes.  Most cases should leave these
  * untouched.  Note: this can only return addresses less than 4GiB.
  */
+static inline bool arm_has_idmap_alias(void)
+{
+	return IS_ENABLED(CONFIG_MMU) && arch_phys_to_idmap_offset != 0;
+}
+
 #define IDMAP_INVALID_ADDR ((u32)~0)
 
 static inline unsigned long phys_to_idmap(phys_addr_t addr)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
