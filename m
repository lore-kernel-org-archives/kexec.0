Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1co5gv-0003XZ-HS
 for kexec@lists.infradead.org; Wed, 15 Mar 2017 09:58:07 +0000
Received: by mail-pg0-x231.google.com with SMTP id b129so6986415pgc.2
 for <kexec@lists.infradead.org>; Wed, 15 Mar 2017 02:57:44 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v33 09/14] arm64: kdump: add VMCOREINFO's for user-space tools
Date: Wed, 15 Mar 2017 18:59:38 +0900
Message-Id: <20170315095941.25119-7-takahiro.akashi@linaro.org>
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

In addition to common VMCOREINFO's defined in
crash_save_vmcoreinfo_init(), we need to know, for crash utility,
  - kimage_voffset
  - PHYS_OFFSET
to examine the contents of a dump file (/proc/vmcore) correctly
due to the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.

  - VA_BITS
is also required for makedumpfile command.

arch_crash_save_vmcoreinfo() appends them to the dump file.
More VMCOREINFO's may be added later.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 2c1108c51d69..68b96ea13b4c 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -18,6 +18,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/memory.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 
@@ -351,3 +352,13 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
 	}
 }
 #endif /* CONFIG_HIBERNATION */
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
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
