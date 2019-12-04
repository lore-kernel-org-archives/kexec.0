Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icX4W-0008DJ-5v
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 16:00:23 +0000
Received: by mail-qk1-x741.google.com with SMTP id m188so370660qkc.4
 for <kexec@lists.infradead.org>; Wed, 04 Dec 2019 08:00:11 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v8 19/25] arm64: kexec: arm64_relocate_new_kernel don't use x0
 as temp
Date: Wed,  4 Dec 2019 10:59:32 -0500
Message-Id: <20191204155938.2279686-20-pasha.tatashin@soleen.com>
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de

x0 will contain the only argument to arm64_relocate_new_kernel; don't
use it as a temp. Reassigned registers to free-up x0.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/relocate_kernel.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index e9c974ea4717..41f9c95fabe8 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -32,14 +32,14 @@ ENTRY(arm64_relocate_new_kernel)
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 	/* Clear the sctlr_el2 flags. */
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
+	mrs	x2, CurrentEL
+	cmp	x2, #CurrentEL_EL2
 	b.ne	1f
-	mrs	x0, sctlr_el2
+	mrs	x2, sctlr_el2
 	ldr	x1, =SCTLR_ELx_FLAGS
-	bic	x0, x0, x1
+	bic	x2, x2, x1
 	pre_disable_mmu_workaround
-	msr	sctlr_el2, x0
+	msr	sctlr_el2, x2
 	isb
 1:	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
@@ -51,17 +51,17 @@ ENTRY(arm64_relocate_new_kernel)
 	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
 
 	/* Invalidate dest page to PoC. */
-	mov     x0, x13
-	add     x20, x0, #PAGE_SIZE
+	mov     x2, x13
+	add     x20, x2, #PAGE_SIZE
 	sub     x1, x15, #1
-	bic     x0, x0, x1
-2:	dc      ivac, x0
-	add     x0, x0, x15
-	cmp     x0, x20
+	bic     x2, x2, x1
+2:	dc      ivac, x2
+	add     x2, x2, x15
+	cmp     x2, x20
 	b.lo    2b
 	dsb     sy
 
-	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
+	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-- 
2.24.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
