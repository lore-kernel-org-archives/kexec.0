Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB89CD6E77
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGJTJ/FaZhfGglBz44gxrkrG5R80OdCp7c0qc5/blwo=; b=Bmd53ubaxUmTs0+2GcitcbA4q2
	3Ft5/yDA4IVHM9Xr0M+GrAOR8qPs2oI/LDfmCJXBNEIVGQw64ahN/Zu1nWwP6sFdQjoLrsvERc7DE
	ntaa6QDPp4VTqxQ+/e66EslJ90wvndfGU4HyDrClesZN92uIlau0Kc2Z4WZKR0AWy15vPFM4seYnl
	K+mcPmPChKkbbsIkn4TL76knry5vZFpHPyL4+cc9jad9ZdAn+Nh8x+X1OkadGmMaXt0nhEBA3hJJ4
	AhICf0TAPWw4sv+7KqGA9BoNBUXYVp88l/9IbstDuqyXFcQnZyGgorSjmlHRF+O9mjYII+6pGrfdx
	rCZbV6SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83w-0000000GmHb-0xEB;
	Thu, 04 Jun 2026 13:24:44 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83q-0000000GmBD-3FNx;
	Thu, 04 Jun 2026 13:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579474; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wGJTJ/FaZhfGglBz44gxrkrG5R80OdCp7c0qc5/blwo=;
	b=BJ0CaUFNsbnPI/84BUZ99dTZx32FpNtT5AlrdeY416kn0xUnujFouGQkGPEqs/HDAs/G1tGeDWKmA7n2tjr1rtbQkM7a/hrCA5KThxUtBJuJpDKVkDt8t3fdd1Rm30Itp6+9vUgLgvI2XIBVBksE8Wh2uNIaR/hdwTXlTV9sZRE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnXk_1780579466;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnXk_1780579466 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:27 +0800
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
Subject: [PATCH v3 3/9] riscv: Add kexec trampoline text section to vmlinux.lds.S
Date: Thu,  4 Jun 2026 21:24:12 +0800
Message-Id: <20260604132418.15725-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_062439_005185_D6DBADC4 
X-CRM114-Status: UNSURE (   7.63  )
X-CRM114-Notice: Please train this message.
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

When CONFIG_KEXEC_CORE is enabled, add a dedicated .kexec.tramp.text
area to the RISC-V kernel linker script.

Extend vmlinux.lds.S to:
  - align both the start and the end to PAGE_SIZE
  - define __kexec_tramp_text_start/__kexec_tramp_text_end
  - KEEP all .kexec.tramp.text* input sections
  - ASSERT the trampoline text fits within one page

The end-of-section page alignment guarantees that the trampoline page,
which is later identity-mapped as PAGE_KERNEL_EXEC, contains nothing but
the trampoline code and padding (no shared neighbour data).

When kexec is disabled, the whole block is excluded via #ifdef
CONFIG_KEXEC_CORE.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1f4f8496941a..bc615f7b702f 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -41,6 +41,16 @@ SECTIONS
 		ENTRY_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+#ifdef CONFIG_KEXEC_CORE
+		. = ALIGN(PAGE_SIZE);
+		__kexec_tramp_text_start = .;
+		KEEP(*(.kexec.tramp.text))
+		KEEP(*(.kexec.tramp.text.*))
+		__kexec_tramp_text_end = .;
+		ASSERT((__kexec_tramp_text_end - __kexec_tramp_text_start) <= PAGE_SIZE,
+		       ".kexec.tramp.text exceeds PAGE_SIZE");
+		. = ALIGN(PAGE_SIZE);
+#endif
 		_etext = .;
 	}
 
-- 
2.50.1


