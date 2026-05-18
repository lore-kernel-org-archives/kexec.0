Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3752DCD4F4A
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 06:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k9JFG8RZ1592/G5Tyz45FKbV/FGxy+05CinWRRaYhME=; b=SOtKK8SrkwMpDofgqVikPh6QIm
	y4aDAVOm/Gl6aWZdWzOVfMixiwbYa2MTJZnw71ItSpLYu7MdX0d+/2zocTzft5LZtiFdnH1goVkD0
	cQRzEPZBDpQLAISfgQPvq39TLyySpdwmALSQcI7zhGLl+Jidut7Upm0eRMI99X8dVEPNUOtoocj+6
	ZMw6KHwS82c7RWoI7perkI6UtYJhPxQNaQIicCP524aLkwpL+je4rB8p2cBUPEFPnCpLEXkzrzf/s
	rXmIcx3DjsOSytZuKlYhFlvvy5Wet9hM8reDwBzx8QEerm1YHNI+/aZ8HrSY0bX0/n4J4ldHtPfPY
	gxKDvWeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrvb-0000000EUw8-1YmT;
	Mon, 18 May 2026 06:58:15 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOrvU-0000000EUua-26Ni
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 06:58:10 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gJpXf5wByz51Srp;
	Mon, 18 May 2026 14:57:54 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 64I6vecU070596;
	Mon, 18 May 2026 14:57:41 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 18 May 2026 14:57:42 +0800 (CST)
X-Zmail-TransId: 2af96a0ab866865-ea6e5
X-Mailer: Zmail v1.0
Message-ID: <20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn>
Date: Mon, 18 May 2026 14:57:42 +0800 (CST)
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <horms@kernel.org>, <kexec@lists.infradead.org>
Cc: <luo.haiyang@zte.com.cn>, <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvM10ga2V4ZWMtdG9vbO+8mmJ1ZyBmaXggZm9yIGNyYXNoZHVtcCBsb2FkIG9uIHJpc2N2?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 64I6vecU070596
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 18 May 2026 14:57:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0AB872.002/4gJpXf5wByz51Srp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_235808_706735_CF241A6B 
X-CRM114-Status: UNSURE (   7.00  )
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
         so add bss segment to the kernel text elf.

Changes from v1:
- https://lore.kernel.org/kexec/20260513171150519t11GTC14QEEV4EgIurNHM@zte.com.cn/T/#u
- Add patch 2 and patch 3 to fix other bug

Luo Haiyang (3):
  RISC-V: fix crashdump load memory ranges
  RISCV: Fix incorrect virtual address translation in crashdump load
  RISC-V: add bss section to kernel text elf header

 kexec/arch/riscv/Makefile          |   2 +
 kexec/arch/riscv/crashdump-riscv.c | 218 +++++++++++++++++++----------
 kexec/arch/riscv/iomem.h           |   1 +
 util_lib/elf_info.c                |  41 ++++--
 util_lib/include/elf_info.h        |   1 +
 5 files changed, 181 insertions(+), 82 deletions(-)

-- 
2.27.0

