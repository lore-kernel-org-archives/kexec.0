Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6BCCD5BD2
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4O/AJryMQ9T9OTSkYrEaZ42+vviQ81VgiXQiB0NE6IU=; b=SguiNUYSCE4l36pJU8CYu8lJVR
	6Ckkky6D3I3UcIAaSzw7QJL+rSFR73x9loKD8jMcBquWaLyAEYMuRTmY04CYHl+e0I7BdZshsqGCb
	hLyJ+uLWn1wjvIKcHuuhp4n4nLgEJRKADS3O159BppN4333Iy5aEu+VB2bUaVMZaT9qTs1ymc8mee
	8+91AaV3bYX1gNEIrnxYP8YFyAqc+YJvjbsr5oGnXuNnbZvopcm+0NoDGSfC4dtqci6r4MgaGOEJo
	Qgb9Ji+EbgAZ67NPVnLegfFo4v9btxxnCoW9AHv7j0lT5VQmwHnJQNBr7ylOjqp1nLSwk6EW6f/oW
	mm/40Ejg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrF8-00000001xvk-3rIc;
	Tue, 26 May 2026 12:50:46 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEt-00000001xd2-1VNZ;
	Tue, 26 May 2026 12:50:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799827; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4O/AJryMQ9T9OTSkYrEaZ42+vviQ81VgiXQiB0NE6IU=;
	b=LCO+eJ30P2dIOdgqB9zQ1OmhXDhNLvUkb2rHGm9dzBDS9MJQ4m3KNdUeeAbdhZnHfwhu6bZOTYrvBFt0jJohoOy7uurLj88I962zBPaHiHBlmM74YDSAHidpBgRk3kxxh4cpQS5jiQN8NV9rMmQ9ssg8jA32SL3vVsy+NlmiNAg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNMu_1779799824;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNMu_1779799824 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:25 +0800
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
Subject: [PATCH v2 7/7] riscv: kexec: Route normal kexec through the trampoline page table
Date: Tue, 26 May 2026 20:50:09 +0800
Message-Id: <20260526125009.2404-8-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_055031_610866_169FF731 
X-CRM114-Status: GOOD (  15.40  )
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
 arch/riscv/kernel/machine_kexec.c  | 10 +++++++---
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index 1baadad1b546..29392f457f42 100644
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
index e3eb1e71920a..99cc251f971c 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -231,11 +231,15 @@ machine_kexec(struct kimage *image)
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
@@ -244,7 +248,7 @@ machine_kexec(struct kimage *image)
 #endif
 
 	if (image->type != KEXEC_TYPE_CRASH)
-		kexec_method = control_code_buffer;
+		kexec_method = (riscv_kexec_method) &riscv_kexec_relocate_entry;
 	else
 		kexec_method = (riscv_kexec_method) &riscv_kexec_norelocate;
 
-- 
2.50.1


