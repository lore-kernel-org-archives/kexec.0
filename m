Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fkm3p-0004G2-M2
 for kexec@lists.infradead.org; Wed, 01 Aug 2018 08:00:47 +0000
Received: by mail-pg1-x544.google.com with SMTP id s7-v6so10420348pgv.3
 for <kexec@lists.infradead.org>; Wed, 01 Aug 2018 01:00:35 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v13 08/16] arm64: cpufeature: add MMFR0 helper functions
Date: Wed,  1 Aug 2018 16:58:12 +0900
Message-Id: <20180801075820.3753-9-takahiro.akashi@linaro.org>
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, prudo@linux.ibm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

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
2.18.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
