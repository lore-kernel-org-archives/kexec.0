Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 2/8] arm: kdump: implement crash_setup_regs()
Date: Wed,  5 May 2010 09:54:14 +0300
Message-Id: <7001f1995cb0638d21558d12291a3d51f24ed8c2.1273041358.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kexec@lists.infradead.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>

Implement machine specific function crash_setup_regs() which is responsible for
storing machine state when crash occured.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/include/asm/kexec.h |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index df15a0d..8ec9ef5 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -19,10 +19,26 @@
 
 #ifndef __ASSEMBLY__
 
-struct kimage;
-/* Provide a dummy definition to avoid build failures. */
+/**
+ * crash_setup_regs() - save registers for the panic kernel
+ * @newregs: registers are saved here
+ * @oldregs: registers to be saved (may be %NULL)
+ *
+ * Function copies machine registers from @oldregs to @newregs. If @oldregs is
+ * %NULL then current registers are stored there.
+ */
 static inline void crash_setup_regs(struct pt_regs *newregs,
-                                        struct pt_regs *oldregs) { }
+				    struct pt_regs *oldregs)
+{
+	if (oldregs) {
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	} else {
+		__asm__ __volatile__ ("stmia %0, {r0 - r15}"
+				      : : "r" (&newregs->ARM_r0));
+		__asm__ __volatile__ ("mrs %0, cpsr"
+				      : "=r" (newregs->ARM_cpsr));
+	}
+}
 
 #endif /* __ASSEMBLY__ */
 
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
