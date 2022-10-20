Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D0BC433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0bM1cROcDu7tknk1vGJo2hsPfiRD31ToZpnqoTt2pUQ=; b=2xXvDeePkZg5qN
	EOn3Q4i1w3pZDFPdQ8g+geDHEkfWeRcQuVeEHHfT2Gr+F1Fn2vJBVnVlcIjFSY2I3VQKZNVjbDZVS
	soxJl2RLODEHoAt0ScsUYDxNngBhKYgk1RoEfu0ZO7mKuItDHj+Wf+/7Jp1IMGt+6mrUeDsaRcT4M
	odB0eVFrtosilXX1PUygj7tlSz3u20uqOmqn6rtVKLCtHsndnx9lFpT6NaYNA3nTXT4s6F5OE34Ob
	nbAIpaz9QrVgG6STTqn3T8RJaNN1v3SU0w5hty8geydV91dnA/1x08gKtKPDbq/A/yirmJgKEVPTh
	LULy3jNjjRZlvAVkTBSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLqD-009f9N-9b; Thu, 20 Oct 2022 03:03:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLqB-009esb-Pp; Thu, 20 Oct 2022 03:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OXiHNtshfudy4tsuZLyEWb8f0383uh3Yp17mhNsFqPs=; b=KZErqxo4hjsjyfkC+y9/uBPRkO
	rdPGBcoTQ8ehd/oRGdbhvL/h0wavP4iaEjn3w91Ru3tBRR+TNWgcqOTlA2eJwPu7qZ63yzg4N3lS7
	0o6HgJcXQ6nlfeLPXX5p9//O35uHVKOwvncb9tH1a+GkfWM+IKH3B67c6obNIdozCwlM7TNyC6m+C
	nhCAmYDhejhSmCE0GysBjequekHh6W9awXOJpLayXJ2RZGyc2LIAqw+JfNcXkcP8LEXvUbBSWxqHT
	0tgRnZ0nnJEX4havR16WQkaBEfRiX/w/r1hotdGyOrr4e0FQXrJaa3v4y0kkg2JE0y95WiktC1nCl
	Sg/bfFVg==;
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKhn-004usW-Nh; Thu, 20 Oct 2022 01:51:06 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VScs1NN_1666230632;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VScs1NN_1666230632)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 09:50:33 +0800
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
Subject: [Crash-utility][PATCH V4 6/9] RISCV64: Add 'help -r' command support
Date: Thu, 20 Oct 2022 09:50:11 +0800
Message-Id: <20221020015014.46085-7-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_025044_537616_4ACF17A2 
X-CRM114-Status: UNSURE (   6.62  )
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

Add support form printing out the registers from the dump file.

With the patch, we can get the regs,
crash> help -r
CPU 0:
epc : 00ffffffa5537400 ra : ffffffff80088620 sp : ff2000001039bb90
 gp : ffffffff810dde38 tp : ff60000002269600 t0 : ffffffff8032be5c
 t1 : 0720072007200720 t2 : 666666666666663c s0 : ff2000001039bcf0
 s1 : 0000000000000000 a0 : ff2000001039bb98 a1 : 0000000000000001
 a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000000000
 a5 : ff60000001c7d000 a6 : 000000000000003c a7 : ffffffff8035c998
 s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff2000001039bb98
 s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
 s8 : 00fffffffde45410 s9 : 0000000000000007 s10: 00aaaaaad1640700
 s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
 t5 : ff60000001218000 t6 : ff2000001039b988

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 riscv64.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/riscv64.c b/riscv64.c
index 582b44f..ddd801c 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -1320,6 +1320,44 @@ riscv64_init(int when)
 void
 riscv64_display_regs_from_elf_notes(int cpu, FILE *ofp)
 {
+	const struct machine_specific *ms = machdep->machspec;
+	struct riscv64_register *regs;
+
+	if (!ms->crash_task_regs) {
+		error(INFO, "registers not collected for cpu %d\n", cpu);
+		return;
+	}
+
+	regs = &ms->crash_task_regs[cpu];
+	if (!regs->regs[RISCV64_REGS_SP] && !regs->regs[RISCV64_REGS_EPC]) {
+		error(INFO, "registers not collected for cpu %d\n", cpu);
+		return;
+	}
+
+	/* Print riscv64 32 regs */
+	fprintf(ofp,
+		"epc : " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n"
+		" gp : " REG_FMT " tp : " REG_FMT " t0 : " REG_FMT "\n"
+		" t1 : " REG_FMT " t2 : " REG_FMT " s0 : " REG_FMT "\n"
+		" s1 : " REG_FMT " a0 : " REG_FMT " a1 : " REG_FMT "\n"
+		" a2 : " REG_FMT " a3 : " REG_FMT " a4 : " REG_FMT "\n"
+		" a5 : " REG_FMT " a6 : " REG_FMT " a7 : " REG_FMT "\n"
+		" s2 : " REG_FMT " s3 : " REG_FMT " s4 : " REG_FMT "\n"
+		" s5 : " REG_FMT " s6 : " REG_FMT " s7 : " REG_FMT "\n"
+		" s8 : " REG_FMT " s9 : " REG_FMT " s10: " REG_FMT "\n"
+		" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n"
+		" t5 : " REG_FMT " t6 : " REG_FMT "\n",
+		regs->regs[0],  regs->regs[1],  regs->regs[2],
+		regs->regs[3],  regs->regs[4],  regs->regs[5],
+		regs->regs[6],  regs->regs[7],  regs->regs[8],
+		regs->regs[9],  regs->regs[10], regs->regs[11],
+		regs->regs[12], regs->regs[13], regs->regs[14],
+		regs->regs[15], regs->regs[16], regs->regs[17],
+		regs->regs[18], regs->regs[19], regs->regs[20],
+		regs->regs[21], regs->regs[22], regs->regs[23],
+		regs->regs[24], regs->regs[25], regs->regs[26],
+		regs->regs[27], regs->regs[28], regs->regs[29],
+		regs->regs[30], regs->regs[31]);
 }
 
 #else /* !RISCV64 */
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
