Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3462BCD5BC8
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4g9/cguTkXnZOmW3mc5bH5fjRguARWthM2VYsbDUHZY=; b=Cc2ScykHr9ZUxT+l9VjcJm4wmo
	ID3GGo6bo9vbKkT3p1/vPjys1Wy39AaTJc4d5CajJj2oJiJE0sYMSt5lmls45ZJatGCphkepy+/ou
	60xNLDf8RnASejouB+HPTWeGnt3yKNNJa3xC5EHaXuMs98BB4vOe977AhRkCegQaMoHYDDJxvvJyY
	qzYIswtS5KcHmIH9q3uCqx8OroR1Ag0jtYQCmUwHwE2D4zzLvh9wttg/SXmWW2N4R8gsjimJeXdYl
	JgOgxQ5U36PphEW6eHxEewVJ1u0aH3Ez/A9Op6Uxvcae0Fsx5BWiWrgDlCeE5xgNiSegGunK5az7J
	XXvAWzIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEs-00000001xeV-1cuD;
	Tue, 26 May 2026 12:50:30 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEo-00000001xcA-1yqF;
	Tue, 26 May 2026 12:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799819; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4g9/cguTkXnZOmW3mc5bH5fjRguARWthM2VYsbDUHZY=;
	b=s9D7TcgSGll+fJ0dDaN5t5dXM5TCl/eoSWxoBazRsAILL0SQf2TkDnCA4+2+LB0WFLd5m2az7pl8+9O7o6OWYs780KNKuzNUxKzHjayKvgA8/yt5M7PrTCf4onXwIT0i/sqFfGjZUP6jQGRpEEaJ4bD1PEM0NSUBP8eIbtKm0yw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNKJ_1779799816;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNKJ_1779799816 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:17 +0800
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
Subject: [PATCH v2 2/7] riscv: kexec: Place norelocate trampoline into .kexec.tramp.text
Date: Tue, 26 May 2026 20:50:04 +0800
Message-Id: <20260526125009.2404-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_055026_977366_1B6AC2CC 
X-CRM114-Status: UNSURE (   6.98  )
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

Move riscv_kexec_norelocate out of the generic .text section and into
a dedicated executable trampoline section, .kexec.tramp.text.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/asm/kexec.h     | 4 ++++
 arch/riscv/kernel/kexec_relocate.S | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index b9ee8346cc8c..6466c1f00d41 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -75,4 +75,8 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 			unsigned long cmdline_len);
 #endif
 
+#ifndef __ASSEMBLY__
+extern char __kexec_tramp_text_start[];
+#endif
+
 #endif
diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index de0a4b35d01e..af6b99f5b0fd 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -147,7 +147,7 @@ riscv_kexec_relocate_end:
 
 
 /* Used for jumping to crashkernel */
-.section ".text"
+.section ".kexec.tramp.text", "ax"
 SYM_CODE_START(riscv_kexec_norelocate)
 	/*
 	 * s0: (const) Phys address to jump to
-- 
2.50.1


