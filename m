Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13CCCD6E4A
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J7s4VhYWDzfgsMhyPuOD4XJGNCr8wTQOFNPdHWvxnVw=; b=u1RGJVqMuRtD5kreqCR1gAHM4d
	EqDM1rEPdj6E6nGH/4MEMgEgzLm1TgoYgHP0teJveKoQgbmReO3jxNZxtOxD9m87WWdCL4PHXzWrj
	uG277HtvLtIeZusTp7zHOklPERbeZ1meqWMetDPrAIi6BfzUAVCNgWMe51P471CDX2K/h5VkRUbxY
	0Tm1ImwbG4yAI68MzqAHUOFlzam+Td/RbfGosxA1HnqP8hfjsF/zV8KlNJXMjuTnHSDCGNLrJB1Yc
	lem5wLy9ESspW4ojRP0czNHfg5ZalVtk4PVLYlV2ilhjCweCeexcbPF1sD/sNMpuNzKWTnHvTn7qd
	CDb/Z1VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV841-0000000GmWD-1QLL;
	Thu, 04 Jun 2026 13:24:49 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83w-0000000GmG7-3xzD;
	Thu, 04 Jun 2026 13:24:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579482; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=J7s4VhYWDzfgsMhyPuOD4XJGNCr8wTQOFNPdHWvxnVw=;
	b=twSWQmUYNcnXJLh6a2noi5+h2JCo//Bnl5qMjs/eS8m2vDIltRDIYTU4tAIvTBr47Xdv5xn6S/tZ+84PmNzmb8MvzbWbFzG2+zKe7iE6AoHesb6UL2LHbZ8rEkvVJE/uDv+y/bwRZ3OSAeoRO7SSytN1X5l5s2ruayz34ixAqOY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnau_1780579475;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnau_1780579475 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:36 +0800
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
Subject: [PATCH v3 9/9] riscv: kexec: Route normal kexec through the trampoline page table
Date: Thu,  4 Jun 2026 21:24:18 +0800
Message-Id: <20260604132418.15725-10-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_062445_321165_DE8DE7FD 
X-CRM114-Status: GOOD (  17.37  )
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

riscv_kexec_relocate (copied into control_code_buffer) uses an stvec
trick to drop the MMU and land on the PA of the next loop label.
Under VS-mode KVM cannot emulate this single-step transition and the
VCPU dies with "kvm run failed Operation not supported".

Route normal kexec through riscv_kexec_relocate_entry, the trampoline
wrapper added in the previous patch. It drops SATP with PC already on
a PA, then hands off to control_code_buffer where the relocate body
runs with SATP=0.

Drop the stvec trick from the relocate body and pass first_ind_entry
as a physical address since the body now starts with SATP=0. The
".align 2" plus filler "nop" that ensured the PA of the loop top was
4-byte aligned -- required because the legacy stvec trick wrote that
PA into stvec.BASE, whose low two bits are MODE and are discarded by
the hardware -- is no longer load-bearing and is removed as well.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/kexec_relocate.S | 26 ++++++--------------------
 arch/riscv/kernel/machine_kexec.c  | 27 +++++++++++++++++++--------
 2 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index 6c624560c9ac..7ffb83ea45fc 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -34,27 +34,13 @@ SYM_CODE_START(riscv_kexec_relocate)
 	csrw	CSR_SIP, zero
 
 	/*
-	 * When we switch SATP.MODE to "Bare" we'll only
-	 * play with physical addresses. However the first time
-	 * we try to jump somewhere, the offset on the jump
-	 * will be relative to pc which will still be on VA. To
-	 * deal with this we set stvec to the physical address at
-	 * the start of the loop below so that we jump there in
-	 * any case.
+	 * The trampoline wrapper (riscv_kexec_relocate_entry) has already
+	 * dropped the MMU and handed control to us at this PA copy of the
+	 * relocate code. From here on the entire loop runs with SATP=0 and
+	 * every address (s0, s5, source/dest pointers) is a physical one.
 	 */
-	la	s6, 1f
-	sub	s6, s6, s4
-	csrw	CSR_STVEC, s6
-
-	/*
-	 * With C-extension, here we get 42 Bytes and the next
-	 * .align directive would pad zeros here up to 44 Bytes.
-	 * So manually put a nop here to avoid zeros padding.
-	*/
-	nop
 
 	/* Process entries in a loop */
-.align 2
 1:
 	REG_L	t0, 0(s0)		/* t0 = *image->entry */
 	addi	s0, s0, RISCV_SZPTR	/* image->entry++ */
@@ -70,8 +56,8 @@ SYM_CODE_START(riscv_kexec_relocate)
 	andi	t1, t0, 0x2
 	beqz	t1, 2f
 	andi	s0, t0, ~0x2
-	csrw	CSR_SATP, zero
-	jr	s6
+	/* MMU is already off; the entry wrapper handled the transition. */
+	j	1b
 
 2:
 	/* IND_DONE entry ? -> jump to done label */
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 71688c63af65..82fcb84a03ec 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -164,9 +164,6 @@ machine_kexec_prepare(struct kimage *image)
 		memcpy(control_code_buffer, riscv_kexec_relocate,
 			riscv_kexec_relocate_size);
 
-		/* Mark the control page executable */
-		set_memory_x((unsigned long) control_code_buffer, 1);
-
 		WRITE_ONCE(riscv_kexec_relocate_entry_pa,
 			   __pa_symbol(&riscv_kexec_relocate_entry));
 	} else {
@@ -262,11 +259,15 @@ machine_kexec(struct kimage *image)
 {
 	struct kimage_arch *internal = &image->arch;
 	unsigned long jump_addr = (unsigned long) image->start;
-	unsigned long first_ind_entry = (unsigned long) &image->head;
+	/*
+	 * The relocate body runs entirely with the MMU off (the wrapper
+	 * drops SATP before jumping into control_code_buffer), so the very
+	 * first entry must be a physical address.
+	 */
+	unsigned long first_ind_entry = __pa(&image->head);
 	unsigned long this_cpu_id = __smp_processor_id();
 	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
 	unsigned long fdt_addr = internal->fdt_addr;
-	void *control_code_buffer = page_address(image->control_code_page);
 	riscv_kexec_method kexec_method = NULL;
 
 #ifdef CONFIG_SMP
@@ -274,10 +275,20 @@ machine_kexec(struct kimage *image)
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 #endif
 
-	if (image->type != KEXEC_TYPE_CRASH)
-		kexec_method = control_code_buffer;
-	else
+	if (image->type != KEXEC_TYPE_CRASH) {
+		kexec_method = (riscv_kexec_method) &riscv_kexec_relocate_entry;
+		/*
+		 * Publish the per-image control_code_buffer PA at dispatch
+		 * time rather than in machine_kexec_prepare(). machine_kexec()
+		 * only runs once the image has been fully loaded and committed
+		 * as kexec_image, so the global cannot be left pointing at a
+		 * page freed by a failed load.
+		 */
+		WRITE_ONCE(riscv_kexec_cc_buffer_pa,
+			   __pa(page_address(image->control_code_page)));
+	} else {
 		kexec_method = (riscv_kexec_method) &riscv_kexec_norelocate;
+	}
 
 	pr_notice("Will call new kernel at %08lx from hart id %lx\n",
 		  jump_addr, this_hart_id);
-- 
2.50.1


