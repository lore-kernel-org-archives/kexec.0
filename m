Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84BFCD5BD0
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RmDJAqGKM/ksShAqBTWgLgvF5EBn9yG49TTpjD3uJ+Y=; b=wJg5X11C6vyUik4YD0KVHOMHtc
	9Q1fG8bq73bwIE73zXZbraivFeoYQJan9Csgr7rfEcG8iqysViB7mcU/Jx9LzS96XWHDgAShX6L9Z
	uLQh9wfugR9C9/vdTv0hXs/Q4HEB6fbuADGv4mv+tDgVD2ksZKdmH4w3F7pTcihoiOJNKG0jEM9m7
	ilr9TCztsBXFI1BNT30Y5NdzYJuLDH48WM8G15CNc+zag6lhYPBUsS4xgAMU3nKMa+ni/zFJN+MUw
	LkldsqaJzBkVv+koz6BQ5ufeKFu1/aPpGtBZgDuPWJCCVdlu5xpp7BYX7OVgVEaFc41DUCofN4CFB
	IWOhFx2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrFA-00000001xyB-1hVs;
	Tue, 26 May 2026 12:50:48 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEw-00000001xfe-2aD8;
	Tue, 26 May 2026 12:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799831; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RmDJAqGKM/ksShAqBTWgLgvF5EBn9yG49TTpjD3uJ+Y=;
	b=dKK6B1RDu+2d8sU5TLuJAL+N8LDRj2/tOMMDkQo8iaPuuZ5+wUfa3tu/VHRZKi0TvjsXaGgFnq70uk81vwNQwlAnw/uPuNtN64l92qdvJDSh8RJPeG+6p58NBBCfPegP3zYiXdgh7kbudJ/CTs2DicURgZIOm7N0KgauhUJ1e0Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNLy_1779799821;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNLy_1779799821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:22 +0800
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
Subject: [PATCH v2 5/7] riscv: kexec: Always build the trampoline page table
Date: Tue, 26 May 2026 20:50:07 +0800
Message-Id: <20260526125009.2404-6-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_055034_862857_109A3CE0 
X-CRM114-Status: GOOD (  11.39  )
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
index 00fdc42d650d..556b76bcf96e 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -119,6 +119,16 @@ machine_kexec_prepare(struct kimage *image)
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
@@ -135,19 +145,8 @@ machine_kexec_prepare(struct kimage *image)
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


