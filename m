Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1414796807.23621.24.camel@smoke>
Subject: [PATCH V2 01/10] arm64/kvm: Fix assembler compatibility of macros
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 31 Oct 2014 16:06:47 -0700
In-Reply-To: <20141027121300.GR8768@arm.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <f57759dbc105dd3996acd959d4e3157224ff81fa.1414099246.git.geoff@infradead.org>
 <20141024092451.GA24265@leverpostej> <20141027121300.GR8768@arm.com>
Mime-Version: 1.0
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
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Some of the macros defined in kvm_arm.h are useful in assembly files, but are
not compatible with the assembler.  Change any C language integer constant
definitions using appended U, UL, or ULL to the UL() preprocessor macro.  Also,
add a preprocessor include of the asm/memory.h file which defines the UL()
macro.

Fixes build errors like these when using kvm_arm.h in assembly
source files:

  Error: unexpected characters following instruction at operand 3 -- `and x0,x1,#((1U<<25)-1)'

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Will,

As requested, this is a rebase to v3.18-rc2.

You can also pull the same from:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git kexec-v5.1

-Geoff

 arch/arm64/include/asm/kvm_arm.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 7fd3e27..8afb863 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -18,6 +18,7 @@
 #ifndef __ARM64_KVM_ARM_H__
 #define __ARM64_KVM_ARM_H__
 
+#include <asm/memory.h>
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
@@ -160,9 +161,9 @@
 #endif
 
 #define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
-#define VTTBR_BADDR_MASK  (((1LLU << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
-#define VTTBR_VMID_SHIFT  (48LLU)
-#define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
+#define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
+#define VTTBR_VMID_SHIFT  (UL(48))
+#define VTTBR_VMID_MASK	  (UL(0xFF) << VTTBR_VMID_SHIFT)
 
 /* Hyp System Trap Register */
 #define HSTR_EL2_TTEE	(1 << 16)
@@ -185,13 +186,13 @@
 
 /* Exception Syndrome Register (ESR) bits */
 #define ESR_EL2_EC_SHIFT	(26)
-#define ESR_EL2_EC		(0x3fU << ESR_EL2_EC_SHIFT)
-#define ESR_EL2_IL		(1U << 25)
+#define ESR_EL2_EC		(UL(0x3f) << ESR_EL2_EC_SHIFT)
+#define ESR_EL2_IL		(UL(1) << 25)
 #define ESR_EL2_ISS		(ESR_EL2_IL - 1)
 #define ESR_EL2_ISV_SHIFT	(24)
-#define ESR_EL2_ISV		(1U << ESR_EL2_ISV_SHIFT)
+#define ESR_EL2_ISV		(UL(1) << ESR_EL2_ISV_SHIFT)
 #define ESR_EL2_SAS_SHIFT	(22)
-#define ESR_EL2_SAS		(3U << ESR_EL2_SAS_SHIFT)
+#define ESR_EL2_SAS		(UL(3) << ESR_EL2_SAS_SHIFT)
 #define ESR_EL2_SSE		(1 << 21)
 #define ESR_EL2_SRT_SHIFT	(16)
 #define ESR_EL2_SRT_MASK	(0x1f << ESR_EL2_SRT_SHIFT)
@@ -205,16 +206,16 @@
 #define ESR_EL2_FSC_TYPE	(0x3c)
 
 #define ESR_EL2_CV_SHIFT	(24)
-#define ESR_EL2_CV		(1U << ESR_EL2_CV_SHIFT)
+#define ESR_EL2_CV		(UL(1) << ESR_EL2_CV_SHIFT)
 #define ESR_EL2_COND_SHIFT	(20)
-#define ESR_EL2_COND		(0xfU << ESR_EL2_COND_SHIFT)
+#define ESR_EL2_COND		(UL(0xf) << ESR_EL2_COND_SHIFT)
 
 
 #define FSC_FAULT	(0x04)
 #define FSC_PERM	(0x0c)
 
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
-#define HPFAR_MASK	(~0xFUL)
+#define HPFAR_MASK	(~UL(0xf))
 
 #define ESR_EL2_EC_UNKNOWN	(0x00)
 #define ESR_EL2_EC_WFI		(0x01)
-- 
1.9.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
