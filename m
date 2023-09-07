Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE60EE14DB
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 10:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jzj1CbuQXragHLevCCsfkImvarytNitrCLqIpogquww=; b=s1enGXV6ZbDJrj
	KutExIisqoSz5fZ+k6zt55IjJGQJE6SYyIuQAloKeYLgBu/oFF3Vk5job21GLglxoT6+rz6wXYeFx
	eCEBGdn50WXsdVHNy4Mt70eoIikhP+4QKbYR+R9ChNXpAi/XerOgV9BAnIP77x0XCsQNW4IoPyIUH
	SbySPAaHVrslMcOOe7Leanv66qC2a0XyZoZlxVybTEdrzWmg5zSauieE9YJMHT+Kte/5cbhKJH1AY
	F2uPUNAqlw7Nx3+vr98LeAN7c2KvopoNjEDKpNY5Bas2CUVMpOy5y0j8wEE7QX33Gp4PvkO1QHt8s
	FHqnic7mbph35vmy/V4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeCOD-00BnD5-00;
	Thu, 07 Sep 2023 10:37:33 +0000
Received: from bg2.exmail.qq.com ([114.132.197.227])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeCOB-00BnCO-0Z
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 10:37:32 +0000
X-QQ-mid: bizesmtp65t1694082953tnb83x25
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Sep 2023 18:35:50 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: q+EIYT+FhZpQ+916O8pAYyEzlwsQa/Onn3kiOSLXUvNiqMYEPL/HIV0nG6FfI
	C4ewIwysIg7f1Iyu4EzHXxsyLY7/LLc54JgRj4MXyY09gzvD1A79GIjA9nLuJeiPzeElH3S
	Nwkv4UYy8sajO8QlAfV7MWBKEtOAIHW49F8Qg2gmFoHa3QN/REEbnaRXGPnW3yGMYaNyZeB
	WnB/XlFPZr+mDjEDUXq+5SqIw5jnFMP8dnDkigc7Pfxjilk8CVppUcdfgDYEj9m1bc3B4YQ
	zcA8o6Uh9jNBazMxciYr5ohr00aib8BH2w73VClMXdEbhdS6rPUM2UpVx1exduZNJ0MBGOg
	EOzEWH4wNTdKQhtgNHrAbYjF8o1Zk5GsFVvypD+VEiF1bQouUAR93wOp6djiQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15155103582765983556
From: Song Shuai <songshuaishuai@tinylab.org>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	lihuafei1@huawei.com,
	songshuaishuai@tinylab.org,
	petr.tesarik.ext@huawei.com,
	duwe@suse.de,
	ribalda@chromium.org,
	akpm@linux-foundation.org,
	keescook@chromium.org,
	hi@alyssa.is,
	heiko@sntech.de,
	lizhengyu3@huawei.com,
	alexghiti@rivosinc.com,
	schwab@suse.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH V1 2/3] riscv: kexec: Align the kexeced kernel entry
Date: Thu,  7 Sep 2023 18:33:03 +0800
Message-Id: <20230907103304.590739-3-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230907103304.590739-1-songshuaishuai@tinylab.org>
References: <20230907103304.590739-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_033731_545451_9C0275EB 
X-CRM114-Status: UNSURE (   9.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The current riscv boot protocol requires 2MB alignment for RV64
and 4MB alignment for RV32.

In KEXEC_FILE path, the elf_find_pbase() function should align
the kexeced kernel entry according to the requirement, otherwise
the kexeced kernel would silently BUG at the setup_vm().

Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/kernel/elf_kexec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 38390d3bdcac..bc7a00ff5c8b 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -98,7 +98,13 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	kbuf.image = image;
 	kbuf.buf_min = lowest_paddr;
 	kbuf.buf_max = ULONG_MAX;
-	kbuf.buf_align = PAGE_SIZE;
+
+	/*
+	 * Current riscv boot protocol requires 2MB alignment for
+	 * RV64 and 4MB alignment for RV32
+	 *
+	 */
+	kbuf.buf_align = PMD_SIZE;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
 	kbuf.top_down = false;
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
