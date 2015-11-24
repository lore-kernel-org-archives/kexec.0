Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <1ce2d414ff42cccf0995a3a94a1efc9211abb01b.1448403503.git.geoff@infradead.org>
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v12 03/16] arm64: Add new hcall HVC_CALL_FUNC
Date: Tue, 24 Nov 2015 22:25:33 +0000
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

Add the new hcall HVC_CALL_FUNC that allows execution of a function at EL2.
During CPU reset the CPU must be brought to the exception level it had on
entry to the kernel.  The HVC_CALL_FUNC hcall will provide the mechanism
needed for this exception level switch.

To allow the HVC_CALL_FUNC exception vector to work without a stack, which is
needed to support an hcall at CPU reset, this implementation uses register x18
to store the link register across the caller provided function.  This dictates
that the caller provided function must preserve the contents of register x18.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/virt.h | 13 +++++++++++++
 arch/arm64/kernel/hyp-stub.S  | 13 ++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index eb10368..3070096 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -45,6 +45,19 @@
 
 #define HVC_SET_VECTORS 2
 
+/*
+ * HVC_CALL_FUNC - Execute a function at EL2.
+ *
+ * @x0: Physical address of the function to be executed.
+ * @x1: Passed as the first argument to the function.
+ * @x2: Passed as the second argument to the function.
+ * @x3: Passed as the third argument to the function.
+ *
+ * The called function must preserve the contents of register x18.
+ */
+
+#define HVC_CALL_FUNC 3
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 017ab519..e8febe9 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -67,8 +67,19 @@ el1_sync:
 	b	2f
 
 1:	cmp	x18, #HVC_SET_VECTORS
-	b.ne	2f
+	b.ne	1f
 	msr	vbar_el2, x0
+	b	2f
+
+1:	cmp	x18, #HVC_CALL_FUNC
+	b.ne	2f
+	mov	x18, lr
+	mov	lr, x0
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	blr	lr
+	mov	lr, x18
 
 2:	eret
 ENDPROC(el1_sync)
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
