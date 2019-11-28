Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaQM1-0007CE-Ls
 for kexec@lists.infradead.org; Thu, 28 Nov 2019 20:25:35 +0000
Received: by mail-pl1-f198.google.com with SMTP id c18so11708256plo.17
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2019 12:25:31 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
Date: Fri, 29 Nov 2019 01:55:13 +0530
Message-Id: <1574972716-25858-1-git-send-email-bhsharma@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>, bhsharma@redhat.com, x86@kernel.org, kexec@lists.infradead.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, James Morse <james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Steve Capper <steve.capper@arm.com>

vabits_actual variable on arm64 indicates the actual VA space size,
and allows a single binary to support both 48-bit and 52-bit VA
spaces.

If the ARMv8.2-LVA optional feature is present, and we are running
with a 64KB page size; then it is possible to use 52-bits of address
space for both userspace and kernel addresses. However, any kernel
binary that supports 52-bit must also be able to fall back to 48-bit
at early boot time if the hardware feature is not present.

Since TCR_EL1.T1SZ indicates the size offset of the memory region
addressed by TTBR1_EL1 (and hence can be used for determining the
vabits_actual value) it makes more sense to export the same in
vmcoreinfo rather than vabits_actual variable, as the name of the
variable can change in future kernel versions, but the architectural
constructs like TCR_EL1.T1SZ can be used better to indicate intended
specific fields to user-space.

User-space utilities like makedumpfile and crash-utility, need to
read/write this value from/to vmcoreinfo for determining if a virtual
address lies in the linear map range.

The user-space computation for determining whether an address lies in
the linear map range is the same as we have in kernel-space:

  #define __is_lm_address(addr)	(!(((u64)addr) & BIT(vabits_actual - 1)))

I have sent out user-space patches for makedumpfile and crash-utility
to add features for obtaining vabits_actual value from TCR_EL1.T1SZ (see
[0] and [1]).

Akashi reported that he was able to use this patchset and the user-space
changes to get user-space working fine with the 52-bit kernel VA
changes (see [2]).

[0]. http://lists.infradead.org/pipermail/kexec/2019-November/023966.html
[1]. http://lists.infradead.org/pipermail/kexec/2019-November/024006.html
[2]. http://lists.infradead.org/pipermail/kexec/2019-November/023992.html

Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/kernel/crash_core.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index d9fbd433cc17..d2e7aff5821e 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -215,6 +215,7 @@
 #define TCR_TxSZ(x)		(TCR_T0SZ(x) | TCR_T1SZ(x))
 #define TCR_TxSZ_WIDTH		6
 #define TCR_T0SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T0SZ_OFFSET)
+#define TCR_T1SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T1SZ_OFFSET)
 
 #define TCR_EPD0_SHIFT		7
 #define TCR_EPD0_MASK		(UL(1) << TCR_EPD0_SHIFT)
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index ca4c3e12d8c5..f78310ba65ea 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -7,6 +7,13 @@
 #include <linux/crash_core.h>
 #include <asm/memory.h>
 
+static inline u64 get_tcr_el1_t1sz(void);
+
+static inline u64 get_tcr_el1_t1sz(void)
+{
+	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
+}
+
 void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(VA_BITS);
@@ -15,5 +22,7 @@ void arch_crash_save_vmcoreinfo(void)
 						kimage_voffset);
 	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
 						PHYS_OFFSET);
+	vmcoreinfo_append_str("NUMBER(tcr_el1_t1sz)=0x%llx\n",
+						get_tcr_el1_t1sz());
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
 }
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
