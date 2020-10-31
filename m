Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v13 5/8] arm64: kdump: introduce some macroes for crash kernel
 reservation
Date: Sat, 31 Oct 2020 15:44:34 +0800
Message-ID: <20201031074437.168008-6-chenzhou10@huawei.com>
In-Reply-To: <20201031074437.168008-1-chenzhou10@huawei.com>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
MIME-Version: 1.0
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
To: tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, John.P.donnelly@oracle.com, bhsharma@redhat.com, prabhakar.pkin@gmail.com
Cc: John Donnelly <John.p.donnelly@oracle.com>, wangkefeng.wang@huawei.com, arnd@arndb.de, linux-doc@vger.kernel.org, chenzhou10@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com, guohanjun@huawei.com, nsaenzjulienne@suse.de

Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
upper bound of high crash memory, use macroes instead.

Besides, keep consistent with x86, use CRASH_ALIGN as the lower bound
of crash kernel reservation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
---
 arch/arm64/include/asm/kexec.h     | 6 ++++++
 arch/arm64/include/asm/processor.h | 1 +
 arch/arm64/mm/init.c               | 8 ++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..402d208265a3 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -25,6 +25,12 @@
 
 #define KEXEC_ARCH KEXEC_ARCH_AARCH64
 
+/* 2M alignment for crash kernel regions */
+#define CRASH_ALIGN	SZ_2M
+
+#define CRASH_ADDR_LOW_MAX	arm64_dma32_phys_limit
+#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fce8cbecd6bc..12131655cab7 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -96,6 +96,7 @@
 #endif /* CONFIG_ARM64_FORCE_52BIT */
 
 extern phys_addr_t arm64_dma_phys_limit;
+extern phys_addr_t arm64_dma32_phys_limit;
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
 
 struct debug_info {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 095540667f0f..a07fd8e1f926 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL(memstart_addr);
  * bit addressable memory area.
  */
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
-static phys_addr_t arm64_dma32_phys_limit __ro_after_init;
+phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
 /*
@@ -85,8 +85,8 @@ static void __init reserve_crashkernel(void)
 
 	if (crash_base == 0) {
 		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
-				crash_size, SZ_2M);
+		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX,
+				crash_size, CRASH_ALIGN);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 				crash_size);
@@ -104,7 +104,7 @@ static void __init reserve_crashkernel(void)
 			return;
 		}
 
-		if (!IS_ALIGNED(crash_base, SZ_2M)) {
+		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
 			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
 			return;
 		}
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
