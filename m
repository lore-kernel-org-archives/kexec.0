Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v18 03/17] x86/setup: Adjust the range of codes separated by
 CONFIG_X86_64
Date: Wed, 22 Dec 2021 21:08:06 +0800
Message-ID: <20211222130820.1754-4-thunder.leizhen@huawei.com>
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

Currently, only X86_64 requires that at least 256M low memory be reserved.
X86_32 does not have this requirement. So move all the code related to
reserve_crashkernel_low() into macro CONFIG_X86_64.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/kernel/setup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index acf2f2eedfe3415..d9080bfa131a654 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -392,9 +392,9 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 #ifdef CONFIG_KEXEC_CORE
 
+#ifdef CONFIG_X86_64
 static int __init reserve_crashkernel_low(void)
 {
-#ifdef CONFIG_X86_64
 	unsigned long long base, low_base = 0, low_size = 0;
 	unsigned long low_mem_limit;
 	int ret;
@@ -434,9 +434,10 @@ static int __init reserve_crashkernel_low(void)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
-#endif
+
 	return 0;
 }
+#endif
 
 static void __init reserve_crashkernel(void)
 {
@@ -490,10 +491,12 @@ static void __init reserve_crashkernel(void)
 		}
 	}
 
+#ifdef CONFIG_X86_64
 	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
+#endif
 
 	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
 		(unsigned long)(crash_size >> 20),
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
