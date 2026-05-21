Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB68CD4F3D
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 04:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hOhusuUHIHjkLLy29powL+Fi/T6j4oA0l1UIgi+Rwzw=; b=bw7jsJKV8FSWSgA1S6/LsRR3rb
	iUKYNtkpFtPcp4mPuNJr1BUunk+cmE5mAxld6xpOFd6nf/fOCtIfy+kBPsQQiyyIhHQJDcGVsJS+M
	8QuBLungoAlH9L4mLsm7M491ZkbQOB9jJO0SJIYDJq1t9vjC4S3O269Ji/haXZwTp4s3Vs0KLjrk2
	JmTvGFSmBX5CNdY/tqvW9PvT8O5QZ58ksTE0YjrqJebAQRH8reKZ4KJd/uOEAk/RppZLZ6dKgFTsn
	Q/cpAr/NCU3UdqWi0PKMnI2I8C08PV2f4DwnrDRpKM8PCNK7hXStCI61sD5E86kN4g7bvmJqhfFE6
	vdA+iT1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPugQ-00000006cQA-2pRw;
	Thu, 21 May 2026 04:06:54 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPugN-00000006cPe-2F61
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 04:06:53 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gLZbr6gQxz8Xrrd;
	Thu, 21 May 2026 12:06:48 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 64L46fnF029076;
	Thu, 21 May 2026 12:06:41 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid18;
	Thu, 21 May 2026 12:06:43 +0800 (CST)
X-Zmail-TransId: 2b066a0e84d370a-17180
X-Mailer: Zmail v1.0
Message-ID: <20260521120643491yZJMsKq2fLbFcvtV5ukN1@zte.com.cn>
Date: Thu, 21 May 2026 12:06:43 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <kexec@lists.infradead.org>, <horms@kernel.org>
Cc: <zhang.run@zte.com.cn>, <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IDAvNF0ga2V4ZWMtdG9vbO+8mmJ1ZyBmaXggZm9yIGNyYXNoZHVtcCBsb2FkIG9uIHJpc2N2?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64L46fnF029076
X-TLS: YES
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 21 May 2026 12:06:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0E84D8.000/4gLZbr6gQxz8Xrrd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_210651_736799_D2C7E6F6 
X-CRM114-Status: UNSURE (   9.59  )
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

From: Luo Haiyang <luo.haiyang@zte.com.cn>

This patchset fixes kexec-tool related to crashdump load on riscv

patch 1: crashload should use all system RAM but crash reserved memory.
patch 2: make the phys_to_virt function return the correct value.
patch 3: vmcore-dmesg accesses the address located in the bss segment,
use kernel image to creat kernel text elf header.
patch 4: due to the kernel image being additionally exported in /proc/iomem,
the kernel memory range is not correctly handled by to_be_excluded.

Changes from v3:
- sorry for the incorrect email format in the previous submission.

Changes from v2:
- use kernel image to creat kernel text elf header
- do not exclude kernel memory range
- https://lore.kernel.org/kexec/20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn/T/#md89827a089395745d3bd361889e4f3c490641732

Changes from v1:
- Add patch 2 and patch 3 to fix other bug
- https://lore.kernel.org/kexec/20260513171150519t11GTC14QEEV4EgIurNHM@zte.com.cn/T/#u

Luo Haiyang (4):
  RISC-V: fix crashdump load memory ranges
  RISCV: Fix incorrect virtual address translation in crashdump load
  RISC-V: use kernel image to creat kernel text elf header
  RISC-V: kernel image memory rang should not be excluded

 kexec/arch/riscv/Makefile          |   2 +
 kexec/arch/riscv/crashdump-riscv.c | 218 +++++++++++++++++++----------
 kexec/arch/riscv/iomem.h           |   3 +-
 kexec/arch/riscv/kexec-riscv.c     |   8 +-
 util_lib/elf_info.c                |  41 ++++--
 util_lib/include/elf_info.h        |   1 +
 6 files changed, 184 insertions(+), 89 deletions(-)

-- 
2.27.0

