Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D343CD6E7E
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ty4UCAjaMaaFpW8tBxA2htrUnTdUo90caPb79emu5xY=; b=e3r8ZgNQIqnTttyX8t3xrXV3Yg
	RO8u8RCDIckOik+tMTfrUQK9wjHT+KrzbtHDU9hn1aUolxqddd3IsThscsGMo2reTmvHOsKJxKfDD
	y0aRR9sXzfjIa7UaEBKMgPLJW9zUDO4hRwETnrfq3mAx+EJ+34WE1ISSK1svXSaxtBspEy5Gb2hhi
	CXltvt+zq406jKzKkU4afflln+dOWz+1anYDisk7lOZn8N2lmfgaZ3fjbi+UrBwyhlZGAMgreN9Ky
	mv9DvFdiez+fu03lBE5cmaWMd7tZRVPnAKZ/oSDzvUjSL12gIM2NOAuHj1PHQ4tTr0RtfTmOfvHUS
	BHL1sCVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83x-0000000GmKx-2bNa;
	Thu, 04 Jun 2026 13:24:45 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83s-0000000GmBE-29Lj;
	Thu, 04 Jun 2026 13:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579475; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ty4UCAjaMaaFpW8tBxA2htrUnTdUo90caPb79emu5xY=;
	b=cuLVNW+YByY/txgJulUVZNv71Nmwnvq1nq4IIzu3DLNPa/gqQjH88JKn1Ro+LxmzlqxyX8MPSeU+LqvGJPcYdpNrsG2eUo+kKrvI5qq3CpiGmwrJG/kaPY21Ig6p0B2CrDYzrLt3E+z0vNYHgiENnsKG4m5Or1cXir/W35vvqTs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnZm_1780579472;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnZm_1780579472 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:33 +0800
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
Subject: [PATCH v3 7/9] riscv: kexec: Always build the trampoline page table
Date: Thu,  4 Jun 2026 21:24:16 +0800
Message-Id: <20260604132418.15725-8-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_062440_760068_FE8C5C3C 
X-CRM114-Status: GOOD (  10.86  )
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

The trampoline page table and the kexec_tramp_satp value are
currently built only on the crash path. A follow-up patch needs
the same infrastructure for the normal kexec path.

Pull the trampoline build and the WRITE_ONCE() that publishes the
SATP value out of the crash-only else branch in
machine_kexec_prepare(). The crash path keeps recording its own
riscv_kexec_norelocate_pa; the normal path keeps its existing
control_code_buffer copy.

No functional change.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 72817bba5d3b..d82f45fb44b6 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -139,6 +139,16 @@ machine_kexec_prepare(struct kimage *image)
 		return -EINVAL;
 	}
 
+	/*
+	 * Build the trampoline page table and capture its SATP value.
+	 * The crash path consumes it today; the non-crash kexec path
+	 * will use the same setup as well.
+	 */
+	riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
+				__pa_symbol(__kexec_tramp_text_start));
+	WRITE_ONCE(kexec_tramp_satp,
+		   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
+
 	/* Copy the assembler code for relocation to the control page */
 	if (image->type != KEXEC_TYPE_CRASH) {
 		control_code_buffer = page_address(image->control_code_page);
@@ -155,19 +165,8 @@ machine_kexec_prepare(struct kimage *image)
 		/* Mark the control page executable */
 		set_memory_x((unsigned long) control_code_buffer, 1);
 	} else {
-		/*
-		 * Crash kexec uses riscv_kexec_norelocate as a trampoline.
-		 * Pre-build the trampoline page tables and capture the
-		 * trampoline SATP value plus the physical address of
-		 * riscv_kexec_norelocate so that the panic path only has
-		 * to switch satp and jump.
-		 */
-		riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
-					__pa_symbol(__kexec_tramp_text_start));
 		WRITE_ONCE(riscv_kexec_norelocate_pa,
 			   __pa_symbol(&riscv_kexec_norelocate));
-		WRITE_ONCE(kexec_tramp_satp,
-			   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
 	}
 
 	return 0;
-- 
2.50.1


