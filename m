Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2 3/5] x86/setup: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
Date: Tue,  7 Dec 2021 00:05:12 +0800
Message-Id: <20211206160514.2000-4-jszhang@kernel.org>
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
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, Alexandre ghiti <alex@ghiti.fr>

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
and increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/x86/kernel/setup.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c410be738ae7..56b738c1ca33 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -390,8 +390,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
  * --------- Crashkernel reservation ------------------------------
  */
 
-#ifdef CONFIG_KEXEC_CORE
-
 /* 16M alignment for crash kernel regions */
 #define CRASH_ALIGN		SZ_16M
 
@@ -469,6 +467,9 @@ static void __init reserve_crashkernel(void)
 	bool high = false;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
 	total_mem = memblock_phys_mem_size();
 
 	/* crashkernel=XM */
@@ -534,11 +535,6 @@ static void __init reserve_crashkernel(void)
 	crashk_res.end   = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
 }
-#else
-static void __init reserve_crashkernel(void)
-{
-}
-#endif
 
 static struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
