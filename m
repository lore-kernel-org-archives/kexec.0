Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Jisheng Zhang <jszhang@kernel.org>
Subject: [RFC PATCH 2/5] riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE)
 instead of #ifdef
Date: Fri,  3 Dec 2021 13:11:54 +0800
Message-Id: <20211203051157.2160-3-jszhang@kernel.org>
In-Reply-To: <20211203051157.2160-1-jszhang@kernel.org>
References: <20211203051157.2160-1-jszhang@kernel.org>
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
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_BLK_DEV_INITRD)", to simplify the
code and increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index aeae7d6b2fee..704e2463e976 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -755,7 +755,6 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
-#ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -772,6 +771,8 @@ static void __init reserve_crashkernel(void)
 
 	int ret = 0;
 
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
 	/*
 	 * Don't reserve a region for a crash kernel on a crash kernel
 	 * since it doesn't make much sense and we have limited memory
@@ -812,7 +813,6 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-#endif /* CONFIG_KEXEC_CORE */
 
 void __init paging_init(void)
 {
@@ -826,9 +826,7 @@ void __init misc_mem_init(void)
 	arch_numa_init();
 	sparse_init();
 	zone_sizes_init();
-#ifdef CONFIG_KEXEC_CORE
 	reserve_crashkernel();
-#endif
 	memblock_dump_all();
 }
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
