Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC1DC43334
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hXx9YJ4jYDGyKKxOM/lPax9B7Vis0HtS+VM+gG9f++g=; b=1pRdG5+Oc3t8Y1
	loK7h0jgTDnyUR3D7QyFc6BZvyTwDj5fIXX+Giq8OOSOmw2/ApEqu1gpaRko0wkQwxGj45/m0RDlx
	Syvl3DDIUXJ+5IYqRz97v+X7J3tsr0tVE7xdq5RCCMhSgXLvTotBPCNQXGUy69P753Ldhzw8mnTPv
	ouecMGDMNZt8opjKxwOQaEgMcMwAbfBDGCfR14uGrA0P1oJ4ALSoWc2HyNkj5/wpgyhLo4AbvXiGV
	dHsLPqyaw/zcEqwvv/9OwGmTQWxhe8CIoZAJ8Eow4uB/xyT2rO35/yQyrISVHPcVOic7ebhHf9UZl
	e6IG/c785EeOVgnzp1Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8KZ1-0084Gk-Rf; Mon, 04 Jul 2022 11:48:27 +0000
Received: from out199-3.us.a.mail.aliyun.com ([47.90.199.3])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8KSY-007vVZ-L9
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 11:41:49 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VILSmoj_1656934895;
Received: from localhost(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VILSmoj_1656934895)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 19:41:38 +0800
From: Kaihao Bai <carlo.bai@linux.alibaba.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	carlo.bai@linux.alibaba.com
Subject: [PATCH 0/2] kexec: accumulate and release the size of crashkernel
Date: Mon,  4 Jul 2022 19:41:33 +0800
Message-Id: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_044147_010609_4D121D04 
X-CRM114-Status: UNSURE (   7.90  )
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

Currently x86 and arm64 support to reserve low memory range for
crashkernel. When crashkernel=Y,low is defined, the main kernel would
reserve another memblock (instead of crashkernel=X,high, which stored
in crashk_res) for crashkernel and store it in crashk_low_res.

The implementations of get_crash_size and crash_shrink_size do not
consider the extra reserved memory range if it exists. Thus, firstly
accumulate this range on the size of crashkernel and export the size 
by /sys/kernel/kexec_crash_size.

If getting the input of /sys/kernel/kexec_crash_size, both reserved ranges
might be released if the new size is smaller than current size. The order
of release is (crashk_res -> crashk_low_res). Only if the new size defined
by the user is smaller than the size of low memory range, continue to 
release the reserved low memory range after completely releasing the high 
memory range.

Kaihao Bai (2):
  kexec: accumulate kexec_crash_size if crashk_low_res defined
  kexec: release reserved memory ranges to RAM if crashk_low_res defined

 kernel/kexec_core.c | 77 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 19 deletions(-)

-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
