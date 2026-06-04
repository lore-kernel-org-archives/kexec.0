Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35419CD6E76
	for <kexec@archiver.kernel.org>; Thu,  4 Jun 2026 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnfOs1moHlmKQb6ZUmVUxruUKOqYR4tMlxRWD85j61U=; b=pzTo7HNfL4kLJZ5lWxFIT+tz/e
	KQNHuRKzlD7RpQwJ8sgU2UTWeXGnxVUy+hRyVXxUzaY/8/BmT1u9RxqYUid+ZQJy9Cxg3frAL9NP0
	mGhZJgTuYDkKytAJNpQF7b0CRcqKBzQg0zaiCrNV84Mbx4ZG2EHKAx1AwPYrqqWtocWwfN2Kg/Pc3
	GpBTO9RvjRqAQR2fWQxvMmlcv43OfLl9FaRoGO1au3sXj/F6smklD6JLHTqgqxLzwlRKyovd1gerq
	0/QrZrMrksG1UH7sXCyZhrK6jr7mysDJZ14V21el0WNm4IZUj/QLFpxZ76yh5oiRimBZi+7Vwx8ae
	3Yfs5Ukw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83t-0000000GmE9-2ACL;
	Thu, 04 Jun 2026 13:24:41 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV83n-0000000GmAe-170N;
	Thu, 04 Jun 2026 13:24:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579468; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hnfOs1moHlmKQb6ZUmVUxruUKOqYR4tMlxRWD85j61U=;
	b=ac2IZqhg1BOO+0PS3TFqpaskgR0v4BA/ngc8TgWSq/HvnsBfQl/kAf0gNuitAmrrCe4cYU+SBuF8bU12Gvr1C3wxu+VGgl08ju7u8l2he+Jejo1ghqIqMY/TtVuTLN7P/5vO4vS6Xxy5MQ+gvFeViPhr8rxAM7ETbfzsim3JEmY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnXP_1780579465;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnXP_1780579465 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:26 +0800
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
Subject: [PATCH v3 2/9] riscv: kexec: Bound FDT search by source buffer size, not destination
Date: Thu,  4 Jun 2026 21:24:11 +0800
Message-Id: <20260604132418.15725-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_062438_001118_C3392CA2 
X-CRM114-Status: GOOD (  11.42  )
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

The FDT search loop in machine_kexec_prepare() reads sizeof(fdt) bytes
from segment[i].buf to identify the device tree, but it gates the read
on segment[i].memsz, which is the destination size in the next kernel.
kexec allows bufsz < memsz (the loaded image is zero-padded at the
destination), so a caller can craft a segment with bufsz=10 and
memsz=1MB:

	if (image->segment[i].memsz <= sizeof(fdt))   /* 1MB > 40, OK */
		continue;
	memcpy(&fdt, image->segment[i].buf, sizeof(fdt));  /* reads 40
							      from a 10-byte
							      kbuf */

For kexec_file_load (image->file_mode), the read walks 30 bytes past
the kernel-allocated kbuf. In the worst case the trailing bytes fall
in an unmapped guard page and the read faults the kernel; in the
common case the read returns garbage which fdt_check_header() rejects
and the loop continues. The plain kexec_load path is shielded by
copy_from_user(), which validates the read against the user mapping.

Replace the memsz check with the bufsz check, which is the right
bound for the read site.

Fixes: fba8a8674f68 ("RISC-V: Add kexec support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index ea6794c9f4c2..e6e179cffc44 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -38,7 +38,7 @@ machine_kexec_prepare(struct kimage *image)
 
 	/* Find the Flattened Device Tree and save its physical address */
 	for (i = 0; i < image->nr_segments; i++) {
-		if (image->segment[i].memsz <= sizeof(fdt))
+		if (image->segment[i].bufsz < sizeof(fdt))
 			continue;
 
 		if (image->file_mode)
-- 
2.50.1


