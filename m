Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36DDC433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 03:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vAftuJtM23uu4hJV/BSHHm/dGRQrgYOjNqTdCOvEov0=; b=jTpbajGriN7b3P
	sfPuONCO+gbn2+UGk6gYYVR8mtTelyVxzOTYmvLcPcbPfXjsDDu+Mf8JbxfBn+S+cECiisB34grcH
	SAdTevb6ieycaD6NUP7kTV8WqePfhA711E330dzbRAhZ/0rODnn4lkwiwEKCrLEYymZU+Dw1yIKD0
	wIA1N4SqjWmVfw42H2h5cWmMAIpKQvVQ4/OpNR0yqS8b7vx5UvzOpvCl8KSYV2HlgS5370ehUy5JF
	QzKS7mr7fBGWIYRftJ00+48trrITkp2Y6xv4wDA6x2W1nqBC59PP0thKPAA++AAgLE7j/Bi3P9lf6
	U9cWlQxm4ez6nfr0tiUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLqi-009fxU-Bg; Thu, 20 Oct 2022 03:04:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLqH-009esb-JL; Thu, 20 Oct 2022 03:03:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vFcNO5xSrcisIQq082JbAuvVZIo8ZMsLsuUviBbRnH0=; b=T337pRPDmem3mPhUsJVvUGihTD
	3HJ58RLSg7vcDc0aKmwLW0kwechb+9FNxDpy1fG9pB7NX2tTPeHIey7FKJ8Z5oLgYAWHDAN69YyUM
	EcQKDpQxl5ANL4vGjOH/PY8QDJ1LitiKBKmNWnoM9iRBknBX5nIu3uDK5oiJX5iyeQDIo8TWclfa+
	LPCffM6XX3z6rUmdC8KqB9DXlsZ+58/RPNzwgm5ScQkQDI7C/ZPk88+lBFoskKySZbOsPjpcsaukZ
	4St0353yQOhXZoKeOW5MBMb2AVSRkJQFMOmY6TOnboEUwAgrZ34JL9dpEfD0GdrQROeEr4hT4/0cC
	f7bEBegw==;
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKhk-004usU-Tm; Thu, 20 Oct 2022 01:50:44 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VScs1Mo_1666230630;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VScs1Mo_1666230630)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 09:50:31 +0800
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
	lifang_xia@linux.alibaba.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V4 4/9] RISCV64: Add irq command support
Date: Thu, 20 Oct 2022 09:50:09 +0800
Message-Id: <20221020015014.46085-5-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_025042_015149_DE46462F 
X-CRM114-Status: UNSURE (   5.06  )
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
index a137232..3a290ce 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -989,6 +989,7 @@ riscv64_init(int when)
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
