Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fd9lh-00057B-HW
 for kexec@lists.infradead.org; Wed, 11 Jul 2018 07:42:37 +0000
Received: by mail-pl0-x241.google.com with SMTP id z9-v6so8795974plo.1
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2018 00:42:22 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 07/15] arm64: cpufeature: add MMFR0 helper functions
Date: Wed, 11 Jul 2018 16:41:55 +0900
Message-Id: <20180711074203.3019-8-takahiro.akashi@linaro.org>
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

Those helper functions for MMFR0 register will be used later by kexec_file
loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1db35d..cd90b5252d6d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -486,11 +486,59 @@ static inline bool system_supports_32bit_el0(void)
 	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
 }
 
+static inline bool system_supports_4kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN4_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN4_SUPPORTED;
+}
+
+static inline bool system_supports_64kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN64_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN64_SUPPORTED;
+}
+
+static inline bool system_supports_16kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN16_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN16_SUPPORTED;
+}
+
 static inline bool system_supports_mixed_endian_el0(void)
 {
 	return id_aa64mmfr0_mixed_endian_el0(read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1));
 }
 
+static inline bool system_supports_mixed_endian(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_BIGENDEL_SHIFT);
+
+	return val == 0x1;
+}
+
 static inline bool system_supports_fpsimd(void)
 {
 	return !cpus_have_const_cap(ARM64_HAS_NO_FPSIMD);
-- 
2.17.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
