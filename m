Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <6e96110e85e7b1167043d789e85f9c916fdf281a.1466120418.git.geoff@infradead.org>
In-Reply-To: <cover.1466120418.git.geoff@infradead.org>
References: <cover.1466120418.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v19 10/13] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
Date: Thu, 16 Jun 2016 23:48:28 +0000
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

For the current crash utility, we need to know, at least,
  - kimage_voffset
  - PHYS_OFFSET
to handle the contents of core dump file (/proc/vmcore) correctly due to
the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
This patch puts them as VMCOREINFO's into the file.

  - VA_BITS
is also added for makedumpfile command.
More VMCOREINFO's may be added later.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f270967..57a30fb 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -18,6 +18,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/memory.h>
 #include <asm/mmu_context.h>
 
 #include "cpu-reset.h"
@@ -278,3 +279,13 @@ void machine_crash_shutdown(struct pt_regs *regs)
 
 	pr_info("Starting crashdump kernel...\n");
 }
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	VMCOREINFO_NUMBER(VA_BITS);
+	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
+	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
+						kimage_voffset);
+	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
+						PHYS_OFFSET);
+}
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
