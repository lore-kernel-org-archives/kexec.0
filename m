Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TCP-0004Ei-Tk
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 06:28:23 +0000
From: Sang Yan <sangyan@huawei.com>
Subject: [PATCH 2/2] arm64: Reserve memory for quick kexec
Date: Fri, 14 Aug 2020 01:52:39 -0400
Message-ID: <20200814055239.47348-2-sangyan@huawei.com>
In-Reply-To: <20200814055239.47348-1-sangyan@huawei.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
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
To: kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org, xiexiuqi@huawei.com, guohanjun@huawei.com
Cc: luanjianhai@huawei.com, zhuling8@huawei.com, luchunhua@huawei.com

Reserve memory for quick kexec on arm64
with cmdline "quickkexec=".

Signed-off-by: Sang Yan <sangyan@huawei.com>
---
 arch/arm64/kernel/setup.c |  6 ++++++
 arch/arm64/mm/init.c      | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 77c4c9bad1b8..2a5dc032d95e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -369,6 +369,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 */
 	init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
 #endif
+#ifdef CONFIG_QUICK_KEXEC
+		if (quick_kexec_res.end &&
+		    quick_kexec_res.start >= res->start &&
+		    quick_kexec_res.end <= res->end)
+			request_resource(res, &quick_kexec_res);
+#endif
 
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
 		pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 481d22c32a2e..579acb93728f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -130,6 +130,45 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_QUICK_KEXEC
+static int __init parse_quick_kexec(char *p)
+{
+	if (!p)
+		return 0;
+
+	quick_kexec_res.end = PAGE_ALIGN(memparse(p, NULL));
+
+	return 0;
+}
+early_param("quickkexec", parse_quick_kexec);
+
+static void __init reserve_quick_kexec(void)
+{
+	unsigned long long mem_start, mem_len;
+
+	mem_len = quick_kexec_res.end;
+	if (mem_len == 0)
+		return;
+
+	/* Current arm64 boot protocol requires 2MB alignment */
+	mem_start = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
+			mem_len, CRASH_ALIGN);
+	if (mem_start == 0) {
+		pr_warn("cannot allocate quick kexec mem (size:0x%llx)\n",
+			mem_len);
+		quick_kexec_res.end = 0;
+		return;
+	}
+
+	memblock_reserve(mem_start, mem_len);
+	pr_info("quick kexec mem reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		mem_start, mem_start + mem_len,	mem_len >> 20);
+
+	quick_kexec_res.start = mem_start;
+	quick_kexec_res.end = mem_start + mem_len - 1;
+}
+#endif
+
 #ifdef CONFIG_CRASH_DUMP
 static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
 		const char *uname, int depth, void *data)
@@ -399,6 +438,10 @@ void __init arm64_memblock_init(void)
 
 	reserve_crashkernel();
 
+#ifdef CONFIG_QUICK_KEXEC
+	reserve_quick_kexec();
+#endif
+
 	reserve_elfcorehdr();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
