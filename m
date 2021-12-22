Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v18 06/17] x86/setup: Update comments in reserve_crashkernel()
Date: Wed, 22 Dec 2021 21:08:09 +0800
Message-ID: <20211222130820.1754-7-thunder.leizhen@huawei.com>
In-Reply-To: <20211222130820.1754-1-thunder.leizhen@huawei.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
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

Add comments to describe which bootup parameters are processed by the
code, and make comments close to the code being commented.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/kernel/setup.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 07a58313db5c5f7..52aa925877ca787 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -485,20 +485,20 @@ static void __init reserve_crashkernel(void)
 	if (flag == CRASHKERNEL_MEM_NONE)
 		return;
 
-	/* 0 means: find the address automatically */
 	if (!crash_base) {
 		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
+		 * For the case of crashkernel=X[@offset] and offset is omitted,
+		 * try the low memory first.
 		 */
 		if (!(flag & CRASHKERNEL_MEM_HIGH))
 			crash_base = memblock_phys_alloc_range(crash_size,
 						CRASH_ALIGN, CRASH_ALIGN,
 						CRASH_ADDR_LOW_MAX);
+
+		/*
+		 * If low memory allocation failed above, or for the case of
+		 * crashkernel=X,high, try the high memory.
+		 */
 		if (!crash_base)
 			crash_base = memblock_phys_alloc_range(crash_size,
 						CRASH_ALIGN, CRASH_ALIGN,
@@ -510,6 +510,10 @@ static void __init reserve_crashkernel(void)
 	} else {
 		unsigned long long start;
 
+		/*
+		 * The case of crashkernel=X@offset and offset is specified.
+		 * Only user-specified space can be reserved.
+		 */
 		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
 						  crash_base + crash_size);
 		if (start != crash_base) {
@@ -520,6 +524,10 @@ static void __init reserve_crashkernel(void)
 
 #ifdef CONFIG_X86_64
 	if (crash_base >= (1ULL << 32)) {
+		/*
+		 * Ensure that at least 256M extra low memory is allocated for
+		 * DMA buffers and swiotlb, if low memory size is not specified.
+		 */
 		if (!(flag & CRASHKERNEL_MEM_LOW)) {
 			/*
 			 * two parts from kernel/dma/swiotlb.c:
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
