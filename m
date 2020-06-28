Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v9 4/5] arm64: kdump: fix kdump broken with ZONE_DMA
 reintroduced
Date: Sun, 28 Jun 2020 16:34:57 +0800
Message-ID: <20200628083458.40066-5-chenzhou10@huawei.com>
In-Reply-To: <20200628083458.40066-1-chenzhou10@huawei.com>
References: <20200628083458.40066-1-chenzhou10@huawei.com>
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
To: tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, robh+dt@kernel.org, arnd@arndb.de, John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de, corbet@lwn.net, bhsharma@redhat.com, horms@verge.net.au
Cc: xiexiuqi@huawei.com, chenzhou10@huawei.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
broken the arm64 kdump. If the memory reserved for crash dump kernel
falled in ZONE_DMA32, the devices in crash dump kernel need to use
ZONE_DMA will alloc fail.

This patch addressed the above issue based on "reserving crashkernel
above 4G". Originally, we reserve low memory below 4G, and now just need
to adjust memory limit to arm64_dma_phys_limit in reserve_crashkernel_low
if ZONE_DMA is enabled. That is, if there are devices need to use ZONE_DMA
in crash dump kernel, it is a good choice to use parameters
"crashkernel=X crashkernel=Y,low".

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 kernel/crash_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a7580d291c37..e8ecbbc761a3 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -320,6 +320,7 @@ int __init reserve_crashkernel_low(void)
 	unsigned long long base, low_base = 0, low_size = 0;
 	unsigned long total_low_mem;
 	int ret;
+	phys_addr_t crash_max = 1ULL << 32;
 
 	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
 
@@ -352,7 +353,11 @@ int __init reserve_crashkernel_low(void)
 			return 0;
 	}
 
-	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
+#ifdef CONFIG_ARM64
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		crash_max = arm64_dma_phys_limit;
+#endif
+	low_base = memblock_find_in_range(0, crash_max, low_size, CRASH_ALIGN);
 	if (!low_base) {
 		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
 		       (unsigned long)(low_size >> 20));
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
