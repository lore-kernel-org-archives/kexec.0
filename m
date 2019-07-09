Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkuj1-0008Eo-Nc
 for kexec@lists.infradead.org; Tue, 09 Jul 2019 18:20:26 +0000
Received: by mail-qt1-x844.google.com with SMTP id l9so14352875qtu.6
 for <kexec@lists.infradead.org>; Tue, 09 Jul 2019 11:20:23 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [v2 5/5] arm64, kexec: reserve kexeckernel region
Date: Tue,  9 Jul 2019 14:20:14 -0400
Message-Id: <20190709182014.16052-6-pasha.tatashin@soleen.com>
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

kexeckernel= is used to reserve memory for normal kexec kernel for
faster reboot.

Rename reserve_crashkernel() to reserve_crash_or_kexec_kernel(), and
generalize it by adding an argument that specifies what is reserved:
"crashkernel=" for crash kernel region
"kexeckernel=" for normal kexec region

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +--
 arch/arm64/kernel/setup.c                     |  5 ++
 arch/arm64/mm/init.c                          | 83 ++++++++++++-------
 3 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0f5ce665c7f5..a18222c1fbee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -740,11 +740,11 @@
 			or memory reserved is below 4G.
 
 	kexeckernel=size[KMG][@offset[KMG]]
-			[KNL] Using kexec, Linux can reboot to a new kernel.
-			This parameter reserves the physical memory region
-			[offset, offset + size] for that kernel. If '@offset' is
-			omitted, then a suitable offset is selected
-			automatically.
+			[KNL, ARM64] Using kexec, Linux can reboot to a new
+			kernel. This parameter reserves the physical memory
+			region [offset, offset + size] for that kernel. If
+			'@offset' is omitted, then a suitable offset is
+			selected automatically.
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7e541f947b4c..9f308fa103c5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -235,6 +235,11 @@ static void __init request_standard_resources(void)
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
+
+		/* Userspace will find "Kexec kernel" region in /proc/iomem. */
+		if (kexeck_res.end && kexeck_res.start >= res->start &&
+		    kexeck_res.end <= res->end)
+			request_resource(res, &kexeck_res);
 #endif
 	}
 }
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3c795278def..dfef39f72faf 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -54,61 +54,83 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
 /*
- * reserve_crashkernel() - reserves memory for crash kernel
+ * reserve_crash_or_kexec_kernel() - reserves memory for crash kernel or
+ * for normal kexec kernel.
  *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by dump capture kernel when
- * primary kernel is crashing.
+ * This function reserves memory area given in "crashkernel=" or "kexeckenel="
+ * kernel command line parameter. The memory reserved is used by dump capture
+ * kernel when primary kernel is crashing, or to load new kexec kernel for
+ * faster reboot without relocation.
  */
-static void __init reserve_crashkernel(void)
+static void __init reserve_crash_or_kexec_kernel(char *cmd)
 {
-	unsigned long long crash_base, crash_size;
+	unsigned long long base, size;
+	struct resource *res;
+	char s[16];
 	int ret;
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
-	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
+	/* cmd must be either: "crashkernel=" or "kexeckernel=" */
+	if (!strcmp(cmd, "crashkernel=")) {
+		res = &crashk_res;
+	} else if (!strcmp(cmd, "kexeckernel=")) {
+		res = &kexeck_res;
+	} else {
+		pr_err("%s: invalid cmd %s\n", __func__, cmd);
+		return;
+	}
+
+	/* remove trailing '=' for a nicer printfs */
+	strcpy(s, cmd);
+	s[strlen(s) - 1] = '\0';
+
+	ret = parse_crash_or_kexec_kernel(boot_command_line,
+					  memblock_phys_mem_size(),
+					  &size, &base, cmd, NULL);
+	/* no specified command or invalid value specified */
+	if (ret || !size)
 		return;
 
-	crash_size = PAGE_ALIGN(crash_size);
+	size = PAGE_ALIGN(size);
 
-	if (crash_base == 0) {
+	if (base == 0) {
 		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
-				crash_size, SZ_2M);
-		if (crash_base == 0) {
-			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-				crash_size);
+		base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
+					      size, SZ_2M);
+		if (base == 0) {
+			pr_warn("cannot allocate %s (size:0x%llx)\n",
+				s, size);
 			return;
 		}
 	} else {
 		/* User specifies base address explicitly. */
-		if (!memblock_is_region_memory(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region is not memory\n");
+		if (!memblock_is_region_memory(base, size)) {
+			pr_warn("cannot reserve %s: region is not memory\n",
+				s);
 			return;
 		}
 
-		if (memblock_is_region_reserved(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
+		if (memblock_is_region_reserved(base, size)) {
+			pr_warn("cannot reserve %s: region overlaps reserved memory\n",
+				s);
 			return;
 		}
 
-		if (!IS_ALIGNED(crash_base, SZ_2M)) {
-			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
+		if (!IS_ALIGNED(base, SZ_2M)) {
+			pr_warn("cannot reserve %s: base address is not 2MB aligned\n",
+				s);
 			return;
 		}
 	}
-	memblock_reserve(crash_base, crash_size);
+	memblock_reserve(base, size);
 
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
+	pr_info("%s reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		s, base, base + size, size >> 20);
 
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
+	res->start = base;
+	res->end = base + size - 1;
 }
 #else
-static void __init reserve_crashkernel(void)
+static void __init reserve_crash_or_kexec_kernel(char *cmd)
 {
 }
 #endif /* CONFIG_KEXEC_CORE */
@@ -411,7 +433,8 @@ void __init arm64_memblock_init(void)
 	else
 		arm64_dma_phys_limit = PHYS_MASK + 1;
 
-	reserve_crashkernel();
+	reserve_crash_or_kexec_kernel("crashkernel=");
+	reserve_crash_or_kexec_kernel("kexeckernel=");
 
 	reserve_elfcorehdr();
 
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
