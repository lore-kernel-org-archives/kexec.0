Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE99CD343F
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 03:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M5h9ipYjtxpoLNaKdM0o4KPSdzIzH0aDpLJCuLdwzGk=; b=gp4vU3cu8LgVz1JXi9iX7xNFBk
	iAkIbYKAGA77H49ShBCp8M/HHTbNQeeDtsuQJjIMvcDhIHhebfIuwV6w+egJH0rYdYdYgtSegPxgk
	QkOyZZGOdKfkmnLrhy3X5dlUuNnsyURvS2cPSTzhLKL0t7aSsGOM88yVfeA0J4elLbOjtHHIfk0C4
	Y89CsU3CmVk/0Ry1uwRktQp98S3LE4dDz9wi8lddo2XmQWPyibc/QsEELBxzsaHM5JzwpFjvFOzu/
	JwyOYmTXLEr7ctOBpUAWrO/zIzTojWpLCLRmUMFgZPJyVtEGzcLnlU92BWpgI/BqqO+dqIJde2Ic4
	bTP+QYqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPuNu-00000006adY-2Ub0;
	Thu, 21 May 2026 03:47:46 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPuNs-00000006ad0-0pao
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 03:47:45 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gLZ9l6JdWz4yjRX;
	Thu, 21 May 2026 11:47:39 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 64L3lW9G097413;
	Thu, 21 May 2026 11:47:32 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid18;
	Thu, 21 May 2026 11:47:33 +0800 (CST)
X-Zmail-TransId: 2b086a0e8055331-52ea6
X-Mailer: Zmail v1.0
Message-ID: <202605211147336599soXOrzLshSGck0QWydIB@zte.com.cn>
Date: Thu, 21 May 2026 11:47:33 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <kexec@lists.infradead.org>, <horms@kernel.org>
Cc: <zhang.run@zte.com.cn>, <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIDAvNF0ga2V4ZWMtdG9vbO+8mmJ1ZyBmaXggZm9yIGNyYXNoZHVtcCBsb2FkIG9uIHJpc2N2?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64L3lW9G097413
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 21 May 2026 11:47:39 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0E805B.001/4gLZ9l6JdWz4yjRX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_204744_388269_F299D399 
X-CRM114-Status: UNSURE (   8.84  )
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

