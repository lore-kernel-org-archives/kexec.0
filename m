Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9572ACD5BB1
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SuvbXy8tCKoaaEmxKOJd/JDFjbPQ2Ub/UQ4G8mPM/Dg=; b=ePtL7qSOsc1KP00ETptcqW5AZw
	WTI1yWtOTLpkVSf/ODYpkdjAahFIk+OoK1kZdaCw5UmVz3CPYUkrvcEcRcfeNF1CKXCwPAHRITURs
	TF1XQRgwW2QzmBLrhuOVpfuq2p69rC0bl/WlWe+Ls5DffhxPbPYDQZi2s+D4Ie2vb1vsuRL2b8V3I
	FYFGlxNpgmrEuFCGjGPCSTclaB/72nVaeCJPZQWN0sTBlFotCIbR74ixasBjRGZZAvMAnqQD4p9Ez
	p7s40bXhnrbAv1oie1i85Kmu2blA3Ogo5JJYjHI1XVYKRrptPWBuXUJ35e0c5ZQ17D85GgY1Ef1+4
	hp70/U7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEw-00000001xiQ-2gdX;
	Tue, 26 May 2026 12:50:34 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEr-00000001xcV-08uC;
	Tue, 26 May 2026 12:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799826; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SuvbXy8tCKoaaEmxKOJd/JDFjbPQ2Ub/UQ4G8mPM/Dg=;
	b=hWbZSQWU5sy/ReyyZmEfKZw68Nyah3RfLqE4AQbRx3VaYb6a0vR2Y/RImgNfmz8nDGdg91NvOP97aP5PU4DJgLoY9yDriakDBzdl53xoPqlWRxcTXYZ/mg3T+jD25EESu3Q7s984zBOGgD79o0SOtqwoEReX+tuXDmq6tcSGN3c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNLM_1779799819;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNLM_1779799819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:20 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Nick Kossifidis <mick@ics.forth.gr>
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Lyu <richard.lyu@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v2 4/7] riscv: kexec: Switch to trampoline page table before norelocate
Date: Tue, 26 May 2026 20:50:06 +0800
Message-Id: <20260526125009.2404-5-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_055029_298558_E094EA61 
X-CRM114-Status: GOOD (  16.76  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Make riscv_kexec_norelocate a two-pass trampoline so it can
drop the kernel page tables while still executing from a
mapped address.

On the first entry, t3 is initialized to 0 by machine_kexec().
Loads the physical address of riscv_kexec_norelocate and the
trampoline SATP value, switches to the trampoline page table,
and jumps to the trampoline VA(=PA).

On the second entry, t3 contains the physical address of
riscv_kexec_norelocate, so the PC comparison matches and
execution continues under trampoline VA(=PA).

Since the trampoline page table is already active, replace the
previous stvec-based handoff with a direct jump to the target
entry (jr a2).

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/kexec_relocate.S | 32 ++++++++++++++++++----
 arch/riscv/kernel/machine_kexec.c  | 44 +++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index af6b99f5b0fd..2b9892bf04f2 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -147,13 +147,35 @@ riscv_kexec_relocate_end:
 
 
 /* Used for jumping to crashkernel */
+.extern kexec_tramp_satp
+.extern riscv_kexec_norelocate_pa
 .section ".kexec.tramp.text", "ax"
 SYM_CODE_START(riscv_kexec_norelocate)
+	/*
+	 * Two-pass entry:
+	 *   - 1st entry: t3 == 0 (initialized by machine_kexec()).
+	 *
+	 *   - 2nd entry: t3 holds the physical address of
+	 *     riscv_kexec_norelocate, so auipc matches t3 and we fall through
+	 *     to label 1 to continue execution under trampoline VA(=PA).
+	 */
+	auipc   t0, 0
+	beq     t0, t3, 1f
+
+	la      t0, riscv_kexec_norelocate_pa
+	REG_L   t3, 0(t0)
+	la      t0, kexec_tramp_satp
+	REG_L   t1, 0(t0)
+	csrw	CSR_SATP, t1
+	sfence.vma x0, x0
+
+	jr      t3
 	/*
 	 * s0: (const) Phys address to jump to
 	 * s1: (const) Phys address of the FDT image
 	 * s2: (const) The hartid of the current hart
 	 */
+1:
 	mv	s0, a1
 	mv	s1, a2
 	mv	s2, a3
@@ -199,13 +221,13 @@ SYM_CODE_START(riscv_kexec_norelocate)
 	csrw	CSR_SSCRATCH, zero
 
 	/*
-	 * Switch to physical addressing
-	 * This will also trigger a jump to CSR_STVEC
-	 * which in this case is the address of the new
-	 * kernel.
+	 * We are already executing from the trampoline VA with the trampoline
+	 * page table installed, so there is no need to rely on the old flow
+	 * of programming stvec and taking the implicit trap on SATP switch.
+	 * Jump directly to the target entry instead.
 	 */
-	csrw	CSR_STVEC, a2
 	csrw	CSR_SATP, zero
+	jr	a2
 
 SYM_CODE_END(riscv_kexec_norelocate)
 
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 9b4b495e7c15..00fdc42d650d 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -18,6 +18,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
+unsigned long kexec_tramp_satp;
+unsigned long riscv_kexec_norelocate_pa;
 static pgd_t kexec_tramp_pgd[PTRS_PER_PGD] __aligned(PAGE_SIZE);
 static p4d_t kexec_tramp_p4d[PTRS_PER_P4D] __aligned(PAGE_SIZE);
 static pud_t kexec_tramp_pud[PTRS_PER_PUD] __aligned(PAGE_SIZE);
@@ -135,11 +137,17 @@ machine_kexec_prepare(struct kimage *image)
 	} else {
 		/*
 		 * Crash kexec uses riscv_kexec_norelocate as a trampoline.
-		 * Pre-build the trampoline page tables here so the panic
-		 * path only has to switch satp and jump.
+		 * Pre-build the trampoline page tables and capture the
+		 * trampoline SATP value plus the physical address of
+		 * riscv_kexec_norelocate so that the panic path only has
+		 * to switch satp and jump.
 		 */
 		riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
 					__pa_symbol(__kexec_tramp_text_start));
+		WRITE_ONCE(riscv_kexec_norelocate_pa,
+			   __pa_symbol(&riscv_kexec_norelocate));
+		WRITE_ONCE(kexec_tramp_satp,
+			   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
 	}
 
 	return 0;
@@ -243,7 +251,35 @@ machine_kexec(struct kimage *image)
 
 	/* Jump to the relocation code */
 	pr_notice("Bye...\n");
-	kexec_method(first_ind_entry, jump_addr, fdt_addr,
-		     this_hart_id, kernel_map.va_pa_offset);
+	/*
+	 * Hand off to the trampoline. For KEXEC_TYPE_CRASH we go into
+	 * riscv_kexec_norelocate, which uses t3 as the 1st/2nd-pass
+	 * discriminator (must be 0 on first entry). A bare
+	 *   asm volatile ("li t3, 0" ::: "t3")
+	 * before the C call only declares t3 *modified*; the compiler is
+	 * free to use t3 as scratch when materialising args. Pin t3 = 0
+	 * (and the args) via local register variables and perform the
+	 * indirect jump inside the same inline asm so t3 == 0 is
+	 * guaranteed at the moment control leaves machine_kexec().
+	 */
+	{
+		register unsigned long a0_val asm("a0") = first_ind_entry;
+		register unsigned long a1_val asm("a1") = jump_addr;
+		register unsigned long a2_val asm("a2") = fdt_addr;
+		register unsigned long a3_val asm("a3") = this_hart_id;
+		register unsigned long a4_val asm("a4") = kernel_map.va_pa_offset;
+		register unsigned long t3_zero asm("t3") = 0;
+		register riscv_kexec_method m asm("t6") = kexec_method;
+
+		asm volatile (
+			"jr %[m]"
+			:
+			: "r" (a0_val), "r" (a1_val), "r" (a2_val),
+			  "r" (a3_val), "r" (a4_val),
+			  "r" (t3_zero),
+			  [m] "r" (m)
+			: "memory"
+		);
+	}
 	unreachable();
 }
-- 
2.50.1


