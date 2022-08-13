Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A10C3F6B0
	for <kexec@archiver.kernel.org>; Sat, 13 Aug 2022 03:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K2OTC6cLhFSbyxGj94kZc90A6fcMT8C2JF2mG7RjeBI=; b=lobxDEu/6ItyV2
	kkNTejpF+rdUrpzlTHQOqo25yYjQDrhvtu1h1ALrxx4+ei3Vei5yngo4GLd1cHarG7LOTz56DUMr5
	iHKHn43jAl+WGf3c5tt+Tpao+QCbm6bg8wTWU7PQj/ANUwFBpGEwpzO1+ue0JmMoBISQM9V7y1bKs
	AVXaNTJLcwbzyLHCUVV7/kBu527Xr+vHIhd++CVmyEY7APdt0VlFHVaaGcae5/5B9T/65rd1O5M+P
	jdZipqFUcSbGEIhZjGEIS8oC5QRp9qoxU4UjYyjo/Jl1eYKJrNcvSCb2l2L2iIOhxvzsQk5Gwhxrk
	z1bxQph7S+iXDRTyUONw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMhfA-003wEK-HI; Sat, 13 Aug 2022 03:18:12 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMhf2-003w1u-Ip; Sat, 13 Aug 2022 03:18:08 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VM4qiD4_1660360679;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VM4qiD4_1660360679)
          by smtp.aliyun-inc.com;
          Sat, 13 Aug 2022 11:18:00 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: crash-utility@redhat.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com,
	lijiang@redhat.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	hschauhan@nulltrace.org,
	huanyi.xj@alibaba-inc.com,
	lifang_xia@linux.alibaba.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V3 4/9] RISCV64: Add 'irq' command support
Date: Sat, 13 Aug 2022 11:17:48 +0800
Message-Id: <20220813031753.3097720-5-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com>
References: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_201804_808731_40AA63F0 
X-CRM114-Status: UNSURE (   4.45  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

With the patch, we can get the irq info,
crash> irq
 IRQ   IRQ_DESC/_DATA      IRQACTION      NAME
 0       (unused)          (unused)
 1   ff60000001329600  ff60000001d17180  "101000.rtc"
 2   ff60000001329800  ff60000001d17680  "ttyS0"
 3   ff60000001329a00  ff60000001c33c00  "virtio0"
 4   ff60000001329c00  ff60000001c33f80  "virtio1"
 5   ff6000000120f400  ff60000001216000  "riscv-timer"

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 riscv64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/riscv64.c b/riscv64.c
index e1d9055..11145d1 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -995,6 +995,7 @@ riscv64_init(int when)
 		machdep->get_smp_cpus = riscv64_get_smp_cpus;
 		machdep->value_to_symbol = generic_machdep_value_to_symbol;
 		machdep->dis_filter = generic_dis_filter;
+		machdep->dump_irq = generic_dump_irq;
 		machdep->show_interrupts = generic_show_interrupts;
 		machdep->get_irq_affinity = generic_get_irq_affinity;
 		machdep->init_kernel_pgd = NULL; /* pgd set by symbol_value("swapper_pg_dir") */
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
