Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D0CC0015E
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 09:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U2bzJaJHiy1mcopLmjMYufMRCs3Lckion0xm8+Kc8b0=; b=TqkV5h1edlGAvD
	Lm3+2ysXR3DfNOFji/zo/OMwOjCJg7qhQdzL8pEzmmGNWdMRG2S0cQ2BtwaJ0QDliTAvwSqodvhSR
	DTmueqqtdqr66OA86q7Ok+9cpjQmlxWYHeMpk+z4JbuPLmrdy/HcdzSstfPQjTQIGhfOAu6mX8LLI
	f3L51ne8GinyZvU3xHgnyZx0f9dKIdFGy1zwjPFpNQzknTNwuK0ZObnOVqDjNKyxbmZONTvRXMLOS
	eIMFzNMIsGV9v15CmlHqRDGP9tV4UWhvGNkK4BB0R0Uts9sbehAYNivhnCaslVXdHhJDg4sUIhGP7
	bGZoU6Rd07cMeGgQC9Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qObEg-009pPR-16;
	Wed, 26 Jul 2023 09:55:14 +0000
Received: from [14.137.139.154] (helo=frasgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qObEc-009pMv-2n;
	Wed, 26 Jul 2023 09:55:12 +0000
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9pnr6DVKz9v7cX;
	Wed, 26 Jul 2023 17:41:52 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.211.226])
	by APP1 (Coremail) with SMTP id LxC2BwBHo95C7cBk+WYTBQ--.33492S5;
	Wed, 26 Jul 2023 10:54:52 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Liao Chang <liaochang1@huawei.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Alyssa Ross <hi@alyssa.is>,
	Li Zhengyu <lizhengyu3@huawei.com>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list)
Cc: Torsten Duwe <duwe@suse.de>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz
Subject: [PATCH v2 3/3] riscv/kexec: load initrd high in available memory
Date: Wed, 26 Jul 2023 11:54:01 +0200
Message-Id: <67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBHo95C7cBk+WYTBQ--.33492S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJr13KrWrXFWfuw4kArW7XFb_yoW8Gr1Dpw
	sxCF4UGrWUuwsrC34j93Wxua48Aa95Wr1aga1DCayrJrs8XrW5Z3yqq342vF4vkr1agF9Y
	vFyY9r1S93WkA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjmFAJUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_025511_185973_0A65B4BF 
X-CRM114-Status: GOOD (  13.02  )
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

From: Torsten Duwe <duwe@suse.de>

When initrd is loaded low, the secondary kernel fails like this:

 INITRD: 0xdc581000+0x00eef000 overlaps in-use memory region

This initrd load address corresponds to the _end symbol, but the
reservation is aligned on PMD_SIZE, as explained by a comment in
setup_bootmem().

It is technically possible to align the initrd load address accordingly,
leaving a hole between the end of kernel and the initrd, but it is much
simpler to allocate the initrd top-down.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/kernel/elf_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 38390d3bdcac..c08bb5c3b385 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -281,7 +281,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		kbuf.buffer = initrd;
 		kbuf.bufsz = kbuf.memsz = initrd_len;
 		kbuf.buf_align = PAGE_SIZE;
-		kbuf.top_down = false;
+		kbuf.top_down = true;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 		ret = kexec_add_buffer(&kbuf);
 		if (ret)
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
