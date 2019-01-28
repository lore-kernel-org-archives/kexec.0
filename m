Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDyp-00025L-9b
 for kexec@lists.infradead.org; Mon, 28 Jan 2019 20:58:08 +0000
Received: by mail-pl1-f193.google.com with SMTP id a14so8264299plm.12
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2019 12:58:07 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 1/2] arm64: Expose address bits (physical/virtual) via cpuinfo
Date: Tue, 29 Jan 2019 02:27:55 +0530
Message-Id: <1548709076-22317-2-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, steve.capper@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, ard.biesheuvel@linaro.org, will.deacon@arm.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org, suzuki.poulose@arm.com

With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
supports these extensions can support upto 52-bit virtual and 52-bit
physical addresses respectively.

Since at the moment we enable the support of these extensions via CONFIG
flags, e.g.
 - LPA via CONFIG_ARM64_PA_BITS_52, and
 - LVA via CONFIG_ARM64_FORCE_52BIT

The easiest way a user can determine the physical/virtual
addresses supported on the hardware, is via the '/proc/cpuinfo'
interface.

This patches enables the same.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/include/asm/cpufeature.h | 59 ++++++++++++++++++++++++-------------
 arch/arm64/include/asm/sysreg.h     | 19 ++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  4 ++-
 3 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index dfcfba725d72..2f1270ddc277 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -522,6 +522,45 @@ static inline bool system_supports_32bit_el0(void)
 	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
 }
 
+static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
+{
+	switch (parange) {
+	case ID_AA64MMFR0_PARANGE_32: return PARANGE_32;
+	case ID_AA64MMFR0_PARANGE_36: return PARANGE_36;
+	case ID_AA64MMFR0_PARANGE_40: return PARANGE_40;
+	case ID_AA64MMFR0_PARANGE_44: return PARANGE_44;
+	case ID_AA64MMFR0_PARANGE_48: return PARANGE_48;
+	case ID_AA64MMFR0_PARANGE_52: return PARANGE_52;
+	/*
+	 * A future PE could use a value unknown to the kernel.
+	 * However, by the "D10.1.4 Principles of the ID scheme
+	 * for fields in ID registers", ARM DDI 0487C.a, any new
+	 * value is guaranteed to be higher than what we know already.
+	 * As a safe limit, we return the limit supported by the kernel.
+	 */
+	default: return CONFIG_ARM64_PA_BITS;
+	}
+}
+
+static inline u32 id_aa64mmfr0_pa_range_bits(void)
+{
+	u64 mmfr0;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	return id_aa64mmfr0_parange_to_phys_shift(mmfr0 & 0x7);
+}
+
+static inline u32 id_aa64mmfr2_va_range_bits(void)
+{
+	u64 mmfr2;
+	u32 val;
+
+	mmfr2 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr2,
+						ID_AA64MMFR2_LVA_SHIFT);
+	return ((val == ID_AA64MMFR2_VARANGE_52) ? VARANGE_52 : VARANGE_48);
+}
+
 static inline bool system_supports_4kb_granule(void)
 {
 	u64 mmfr0;
@@ -636,26 +675,6 @@ static inline void arm64_set_ssbd_mitigation(bool state) {}
 
 extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 
-static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
-{
-	switch (parange) {
-	case 0: return 32;
-	case 1: return 36;
-	case 2: return 40;
-	case 3: return 42;
-	case 4: return 44;
-	case 5: return 48;
-	case 6: return 52;
-	/*
-	 * A future PE could use a value unknown to the kernel.
-	 * However, by the "D10.1.4 Principles of the ID scheme
-	 * for fields in ID registers", ARM DDI 0487C.a, any new
-	 * value is guaranteed to be higher than what we know already.
-	 * As a safe limit, we return the limit supported by the kernel.
-	 */
-	default: return CONFIG_ARM64_PA_BITS;
-	}
-}
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 72dc4c011014..70910b14b2f3 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -617,9 +617,22 @@
 #define ID_AA64MMFR0_TGRAN64_SUPPORTED	0x0
 #define ID_AA64MMFR0_TGRAN16_NI		0x0
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
+#define ID_AA64MMFR0_PARANGE_32		0x0
+#define ID_AA64MMFR0_PARANGE_36		0x1
+#define ID_AA64MMFR0_PARANGE_40		0x2
+#define ID_AA64MMFR0_PARANGE_42		0x3
+#define ID_AA64MMFR0_PARANGE_44		0x4
 #define ID_AA64MMFR0_PARANGE_48		0x5
 #define ID_AA64MMFR0_PARANGE_52		0x6
 
+#define PARANGE_32			32
+#define PARANGE_36			36
+#define PARANGE_40			40
+#define PARANGE_42			42
+#define PARANGE_44			44
+#define PARANGE_48			48
+#define PARANGE_52			52
+
 #ifdef CONFIG_ARM64_PA_BITS_52
 #define ID_AA64MMFR0_PARANGE_MAX	ID_AA64MMFR0_PARANGE_52
 #else
@@ -646,6 +659,12 @@
 #define ID_AA64MMFR2_UAO_SHIFT		4
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
+#define ID_AA64MMFR2_VARANGE_48		0x0
+#define ID_AA64MMFR2_VARANGE_52		0x1
+
+#define VARANGE_48			48
+#define VARANGE_52			52
+
 /* id_aa64dfr0 */
 #define ID_AA64DFR0_PMSVER_SHIFT	32
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index ca0685f33900..66583ac3be19 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -177,7 +177,9 @@ static int c_show(struct seq_file *m, void *v)
 		seq_printf(m, "CPU architecture: 8\n");
 		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
 		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
-		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
+		seq_printf(m, "CPU revision\t: %d\n", MIDR_REVISION(midr));
+		seq_printf(m, "address sizes\t: %d bits physical, %d bits virtual\n\n",
+				id_aa64mmfr0_pa_range_bits(), id_aa64mmfr2_va_range_bits());
 	}
 
 	return 0;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
