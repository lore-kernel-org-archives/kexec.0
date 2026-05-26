Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B146DCD5BC8
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CG77WpWSVnm3Eju7kwY3q1qRZqr7VASAGJnhObRcxEo=; b=b/2Z6YTSSekNn8z4ZpgiRF5lFA
	2mAa+LzStcJSXtp3fG9CqHaOHokyai1rvDR2sjjAeF0mI9HC76+mwZ3O9uh96gDNaJUgFucsb4lPR
	Q2MZ36aqrbOdn9H6YvVM2Vu1/QpC6iIKHSKdADaFJy+XtIsUDevHj8Dpwi6zsOz7QEEwMlIpRmth3
	A9jZHc+026TBuUoyP+3C+TrbdhYGJe58+e18NmwLjiUfbzGUUDxCgeOFNZEfWfG9KBLBhDGX5vQ+E
	pPYX+ZGnYmtm13DUSf8FFhSJW36dXqHWAVa3AWTPpN35jDkCxFnrRrcx3j7jNu4TmazKGNDnhSsHN
	Rf057fyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEx-00000001xkq-2X4T;
	Tue, 26 May 2026 12:50:35 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEs-00000001xcx-0XLS;
	Tue, 26 May 2026 12:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799827; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CG77WpWSVnm3Eju7kwY3q1qRZqr7VASAGJnhObRcxEo=;
	b=a5PUtPn8EksWgzRsQ0O4kfVN6xO5Ah3UbDuYQvM6V5Mp78NomgjN20i9Cz1EYL1mcXZobIkV4t5xk6n/hzcT3ktOilOjBTAecxMC779P4J+WknReV8A+nT5kw8VmnlZVBGzdOr5zwXBd7NPeIf3wIbkS+70itg7nzJGPpz8l3O4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNMZ_1779799822;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNMZ_1779799822 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:23 +0800
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
Subject: [PATCH v2 6/7] riscv: kexec: Add the relocate-trampoline wrapper
Date: Tue, 26 May 2026 20:50:08 +0800
Message-Id: <20260526125009.2404-7-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_055030_348500_6BAB734B 
X-CRM114-Status: GOOD (  10.26  )
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

Add riscv_kexec_relocate_entry to .kexec.tramp.text and the two
asm-visible globals (riscv_kexec_relocate_entry_pa and
riscv_kexec_cc_buffer_pa) that the wrapper consumes.

The wrapper performs the same two-step transition used by the crash
path: switch to the trampoline pgd, jump to the PA of self, then drop
the MMU with PC already on a PA. It finally jumps to the PA of
control_code_buffer.

machine_kexec_prepare() publishes the wrapper PA and the
control_code_buffer PA via WRITE_ONCE for non-crash images.
Nothing routes to the wrapper yet; the switchover happens in the
follow-up patch.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/asm/kexec.h     |  1 +
 arch/riscv/kernel/kexec_relocate.S | 37 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c  |  7 ++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index 6466c1f00d41..b75cab959e53 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -53,6 +53,7 @@ typedef void (*riscv_kexec_method)(unsigned long first_ind_entry,
 				   unsigned long va_pa_off);
 
 extern riscv_kexec_method riscv_kexec_norelocate;
+extern riscv_kexec_method riscv_kexec_relocate_entry;
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops elf_kexec_ops;
diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index 2b9892bf04f2..1baadad1b546 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -231,6 +231,43 @@ SYM_CODE_START(riscv_kexec_norelocate)
 
 SYM_CODE_END(riscv_kexec_norelocate)
 
+.extern riscv_kexec_relocate_entry_pa
+.extern riscv_kexec_cc_buffer_pa
+.section ".kexec.tramp.text", "ax"
+SYM_CODE_START(riscv_kexec_relocate_entry)
+	/*
+	 * Two-pass entry, identical in shape to riscv_kexec_norelocate:
+	 *   - 1st entry: t3 == 0 (initialized by machine_kexec()).
+	 *   - 2nd entry: t3 == PA of riscv_kexec_relocate_entry, so auipc
+	 *                matches t3 and we fall through to label 1.
+	 * Args a0..a4 are passed through unchanged to riscv_kexec_relocate.
+	 */
+	auipc	t0, 0
+	beq	t0, t3, 1f
+
+	la	t0, riscv_kexec_relocate_entry_pa
+	REG_L	t3, 0(t0)
+	la	t0, kexec_tramp_satp
+	REG_L	t1, 0(t0)
+	csrw	CSR_SATP, t1
+	sfence.vma x0, x0
+
+	jr	t3
+1:
+	/*
+	 * Now executing at the PA of this wrapper with the trampoline pgd
+	 * installed (identity-mapped). Drop the MMU; PC stays valid because
+	 * it is already a PA.
+	 */
+	csrw	CSR_SATP, zero
+	sfence.vma x0, x0
+
+	/* Jump to the PA of control_code_buffer to run the relocate body. */
+	la	t0, riscv_kexec_cc_buffer_pa
+	REG_L	t0, 0(t0)
+	jr	t0
+SYM_CODE_END(riscv_kexec_relocate_entry)
+
 .section ".rodata"
 SYM_DATA(riscv_kexec_relocate_size,
 	.long riscv_kexec_relocate_end - riscv_kexec_relocate)
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 556b76bcf96e..e3eb1e71920a 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -20,6 +20,8 @@
 
 unsigned long kexec_tramp_satp;
 unsigned long riscv_kexec_norelocate_pa;
+unsigned long riscv_kexec_relocate_entry_pa;
+unsigned long riscv_kexec_cc_buffer_pa;
 static pgd_t kexec_tramp_pgd[PTRS_PER_PGD] __aligned(PAGE_SIZE);
 static p4d_t kexec_tramp_p4d[PTRS_PER_P4D] __aligned(PAGE_SIZE);
 static pud_t kexec_tramp_pud[PTRS_PER_PUD] __aligned(PAGE_SIZE);
@@ -144,6 +146,11 @@ machine_kexec_prepare(struct kimage *image)
 
 		/* Mark the control page executable */
 		set_memory_x((unsigned long) control_code_buffer, 1);
+
+		WRITE_ONCE(riscv_kexec_relocate_entry_pa,
+			   __pa_symbol(&riscv_kexec_relocate_entry));
+		WRITE_ONCE(riscv_kexec_cc_buffer_pa,
+			   __pa(control_code_buffer));
 	} else {
 		WRITE_ONCE(riscv_kexec_norelocate_pa,
 			   __pa_symbol(&riscv_kexec_norelocate));
-- 
2.50.1


