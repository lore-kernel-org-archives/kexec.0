Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
 reserve_crashkernel[_low]()
Date: Mon, 7 Sep 2020 21:47:39 +0800
Message-ID: <20200907134745.25732-4-chenzhou10@huawei.com>
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
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
To: catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com, bhsharma@redhat.com
Cc: wangkefeng.wang@huawei.com, arnd@arndb.de, linux-doc@vger.kernel.org, chenzhou10@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, nsaenzjulienne@suse.de, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

To make the functions reserve_crashkernel[_low]() as generic,
replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/kernel/setup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d7fd90c52dae..71a6a6e7ca5b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
 	unsigned long total_low_mem;
 	int ret;
 
-	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
+	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
 
 	/* crashkernel=Y,low */
 	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
@@ -451,7 +451,7 @@ static int __init reserve_crashkernel_low(void)
 			return 0;
 	}
 
-	low_base = memblock_find_in_range(CRASH_ALIGN, 1ULL << 32, low_size, CRASH_ALIGN);
+	low_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
 	if (!low_base) {
 		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
 		       (unsigned long)(low_size >> 20));
@@ -504,8 +504,9 @@ static void __init reserve_crashkernel(void)
 	if (!crash_base) {
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
+		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
+		 * also allocates 256M extra low memory for DMA buffers
+		 * and swiotlb.
 		 * But the extra memory is not required for all machines.
 		 * So try low memory first and fall back to high memory
 		 * unless "crashkernel=size[KMG],high" is specified.
@@ -539,7 +540,7 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
+	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
 		memblock_free(crash_base, crash_size);
 		return;
 	}
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
