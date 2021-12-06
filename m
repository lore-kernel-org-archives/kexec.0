Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2 5/5] arm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of
 #ifdef
Date: Tue,  7 Dec 2021 00:05:14 +0800
Message-Id: <20211206160514.2000-6-jszhang@kernel.org>
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
References: <20211206160514.2000-1-jszhang@kernel.org>
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
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, Alexandre ghiti <alex@ghiti.fr>, Russell King <rmk+kernel@armlinux.org.uk>

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
and increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/setup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 284a80c0b6e1..f9a054a344c0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -973,7 +973,6 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
-#ifdef CONFIG_KEXEC
 /*
  * The crash region must be aligned to 128MB to avoid
  * zImage relocating below the reserved region.
@@ -1001,6 +1000,9 @@ static void __init reserve_crashkernel(void)
 	unsigned long long total_mem;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base);
@@ -1056,9 +1058,6 @@ static void __init reserve_crashkernel(void)
 		insert_resource(&iomem_resource, &crashk_boot_res);
 	}
 }
-#else
-static inline void reserve_crashkernel(void) {}
-#endif /* CONFIG_KEXEC */
 
 void __init hyp_mode_check(void)
 {
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
