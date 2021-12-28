Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
Date: Tue, 28 Dec 2021 21:26:01 +0800
Message-ID: <20211228132612.1860-3-thunder.leizhen@huawei.com>
In-Reply-To: <20211228132612.1860-1-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John
 Donnelly <John.p.donnelly@oracle.com>

Use parse_crashkernel_high_low() to bring the parsing of
"crashkernel=X,high" and the parsing of "crashkernel=Y,low" together, they
are strongly dependent, make code logic clear and more readable.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/kernel/setup.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6a190c7f4d71b05..93d78aae1937db3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -416,18 +416,16 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 # define CRASH_ADDR_HIGH_MAX	SZ_64T
 #endif
 
-static int __init reserve_crashkernel_low(void)
+static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 #ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long long low_base = 0;
 	unsigned long low_mem_limit;
-	int ret;
 
 	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
 
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
-	if (ret) {
+	/* crashkernel=Y,low is not specified */
+	if ((long)low_size < 0) {
 		/*
 		 * two parts from kernel/dma/swiotlb.c:
 		 * -swiotlb size: user-specified with swiotlb= or default.
@@ -465,7 +463,7 @@ static int __init reserve_crashkernel_low(void)
 
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, total_mem;
+	unsigned long long crash_size, crash_base, total_mem, low_size;
 	bool high = false;
 	int ret;
 
@@ -474,10 +472,9 @@ static void __init reserve_crashkernel(void)
 	/* crashkernel=XM */
 	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
 	if (ret != 0 || crash_size <= 0) {
-		/* crashkernel=X,high */
-		ret = parse_crashkernel_high(boot_command_line, total_mem,
-					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
+		/* crashkernel=X,high and possible crashkernel=Y,low */
+		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
+		if (ret)
 			return;
 		high = true;
 	}
@@ -520,7 +517,7 @@ static void __init reserve_crashkernel(void)
 		}
 	}
 
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
+	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low(low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
