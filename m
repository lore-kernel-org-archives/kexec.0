Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <c96d0042da75c6d40c7cd8c6f09a520caf3bbbff.1448403503.git.geoff@infradead.org>
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v12 06/16] Revert "arm64: mm: remove unused
 cpu_set_idmap_tcr_t0sz function"
Date: Tue, 24 Nov 2015 22:25:33 +0000
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

This reverts commit c51e97d89e526368eb697f87cd4d391b9e19f369.

Add back the cpu_set_idmap_tcr_t0sz function needed by setup_mmu_for_reboot.
---
 arch/arm64/include/asm/mmu_context.h | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 2416578..7567030 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -70,23 +70,34 @@ static inline bool __cpu_uses_extended_idmap(void)
 		unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
 }
 
+static inline void __cpu_set_tcr_t0sz(u64 t0sz)
+{
+	unsigned long tcr;
+
+	if (__cpu_uses_extended_idmap())
+		asm volatile (
+		"	mrs	%0, tcr_el1	;"
+		"	bfi	%0, %1, %2, %3	;"
+		"	msr	tcr_el1, %0	;"
+		"	isb"
+		: "=&r" (tcr)
+		: "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
+}
+
+/*
+ * Set TCR.T0SZ to the value appropriate for activating the identity map.
+ */
+static inline void cpu_set_idmap_tcr_t0sz(void)
+{
+	__cpu_set_tcr_t0sz(idmap_t0sz);
+}
+
 /*
  * Set TCR.T0SZ to its default value (based on VA_BITS)
  */
 static inline void cpu_set_default_tcr_t0sz(void)
 {
-	unsigned long tcr;
-
-	if (!__cpu_uses_extended_idmap())
-		return;
-
-	asm volatile (
-	"	mrs	%0, tcr_el1	;"
-	"	bfi	%0, %1, %2, %3	;"
-	"	msr	tcr_el1, %0	;"
-	"	isb"
-	: "=&r" (tcr)
-	: "r"(TCR_T0SZ(VA_BITS)), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
+	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS));
 }
 
 /*
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
