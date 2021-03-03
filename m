Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHFIu-000jby-2G
 for kexec@lists.infradead.org; Wed, 03 Mar 2021 00:23:52 +0000
Received: by mail-qk1-x733.google.com with SMTP id z128so22317695qkc.12
 for <kexec@lists.infradead.org>; Tue, 02 Mar 2021 16:23:40 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v12 01/17] arm64: hyp-stub: Check the size of the HYP stub's
 vectors
Date: Tue,  2 Mar 2021 19:22:14 -0500
Message-Id: <20210303002230.1083176-2-pasha.tatashin@soleen.com>
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com

From: James Morse <james.morse@arm.com>

Hibernate contains a set of temporary EL2 vectors used to 'park'
EL2 somewhere safe while all the memory is thrown in the air.
Making kexec do its relocations with the MMU on means they have to
be done at EL1, so EL2 has to be parked. This means yet another
set of vectors.

All these things do is HVC_SET_VECTORS and HVC_SOFT_RESTART, both
of which are implemented by the hyp-stub. Lets copy it instead
of re-inventing it.

To do this the hyp-stub's entrails need to be packed neatly inside
its 2K vectors.

Start by moving the final 2K alignment inside the end marker, and
add a build check that we didn't overflow 2K.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hyp-stub.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 5eccbd62fec8..572b28646005 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -41,9 +41,13 @@ SYM_CODE_START(__hyp_stub_vectors)
 	ventry	el1_irq_invalid			// IRQ 32-bit EL1
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
 	ventry	el1_error_invalid		// Error 32-bit EL1
+	.align 11
+SYM_INNER_LABEL(__hyp_stub_vectors_end, SYM_L_LOCAL)
 SYM_CODE_END(__hyp_stub_vectors)
 
-	.align 11
+# Check the __hyp_stub_vectors didn't overflow
+.org . - (__hyp_stub_vectors_end - __hyp_stub_vectors) + SZ_2K
+
 
 SYM_CODE_START_LOCAL(el1_sync)
 	cmp	x0, #HVC_SET_VECTORS
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
