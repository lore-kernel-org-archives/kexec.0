Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B2EC00144
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 04:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lRb3pHU3NxEpu9RMFyHsEgOpPWbXM4L3DxebsKvzopo=; b=zgXLn/oUWme/7L
	O/K3p5SxM9hJG17JKfY5S/fC1XYGYFFwjF+D0FyujFF3qg+mnkVZ0n7aBE2nPl4q05tdWlrdPDwxe
	WfctrbJZHQR367CaRcipQOrVshWO0UPvIb4TWt3Ta6bfQ7gfnrKiDKTnuoGY+zmqTNiQR1fX47yw3
	RZsxLFyCj0qQvbV+GycRxieUTmtZlo1lMffsjAww5guwFv6Z5mSxwD6cJ/NLT9Vg2hbYmJKYA7+7q
	uADi2A1TpZZ3yWatg3SCrB8O7TQMUAUos9Klz9+zTuhWjmrlClNYnm3n6jm6xFsCfaJs4FEPKvTZk
	ayVs6gTiLoquGZe7kZig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN56-001j0I-He; Mon, 01 Aug 2022 04:31:04 +0000
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN4x-001isk-3M; Mon, 01 Aug 2022 04:30:57 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VL.kDbB_1659328246;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VL.kDbB_1659328246)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 12:30:47 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: crash-utility@redhat.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	hschauhan@nulltrace.org,
	huanyi.xj@alibaba-inc.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V2 3/9] RISCV64: Add 'dis' command support
Date: Mon,  1 Aug 2022 12:30:34 +0800
Message-Id: <20220801043040.2003264-4-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
References: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220731_213055_329300_EDF422E8 
X-CRM114-Status: UNSURE (   5.17  )
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

Use generic_dis_filter() function to support dis command implementation.

With this patch, we can get the disassembled code,
crash> dis __crash_kexec
0xffffffff80088580 <__crash_kexec>:     addi    sp,sp,-352
0xffffffff80088582 <__crash_kexec+2>:   sd      s0,336(sp)
0xffffffff80088584 <__crash_kexec+4>:   sd      s1,328(sp)
0xffffffff80088586 <__crash_kexec+6>:   sd      s2,320(sp)
0xffffffff80088588 <__crash_kexec+8>:   addi    s0,sp,352
0xffffffff8008858a <__crash_kexec+10>:  sd      ra,344(sp)
0xffffffff8008858c <__crash_kexec+12>:  sd      s3,312(sp)
0xffffffff8008858e <__crash_kexec+14>:  sd      s4,304(sp)
0xffffffff80088590 <__crash_kexec+16>:  auipc   s2,0x1057
0xffffffff80088594 <__crash_kexec+20>:  addi    s2,s2,-1256
0xffffffff80088598 <__crash_kexec+24>:  ld      a5,0(s2)
0xffffffff8008859c <__crash_kexec+28>:  mv      s1,a0
0xffffffff8008859e <__crash_kexec+30>:  auipc   a0,0xfff

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 riscv64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/riscv64.c b/riscv64.c
index 188a3a8..4c321bb 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -993,6 +993,7 @@ riscv64_init(int when)
 		machdep->is_task_addr = riscv64_is_task_addr;
 		machdep->get_smp_cpus = riscv64_get_smp_cpus;
 		machdep->value_to_symbol = generic_machdep_value_to_symbol;
+		machdep->dis_filter = generic_dis_filter;
 		machdep->show_interrupts = generic_show_interrupts;
 		machdep->get_irq_affinity = generic_get_irq_affinity;
 		machdep->init_kernel_pgd = NULL; /* pgd set by symbol_value("swapper_pg_dir") */
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
