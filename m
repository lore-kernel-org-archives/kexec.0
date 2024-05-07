Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62EFC10F1A
	for <kexec@archiver.kernel.org>; Tue,  7 May 2024 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=v08QUPn2D1yktWOsi8bViocz3mTgiaJtjVckPOT0lyg=; b=nA35VI8DVyHdeN
	Lgmq+2g66xoiMD7BjYVBfMPaWAF3H1cF7slgx41QnFLMlDZ3aUYTSXJdFbP2COnc/RwCvxVqbjN/+
	ge+9kMV1SjnaP1llE1+3tyoCYio0WPoWNttLCAbi/oZUnibp0XZlZyEgwgsaGzag2W0lhft9/FBWv
	i0S8ly1aiWHuMXheCUxFWBtQJuLPz2IlmSVo+rOBp6lb1aTjAPfSZhLXoESzYgAJ/IOwQoVuqF78s
	rklis1QSoujJ51D6JgFhPkwdxE0qxKkcm7WPGXW2NRpoi1wBlOk1junAVlHm7Kh+mWWHvMrisKSOW
	fOQnXv1KGVSZ+iZ1Kb2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Lqo-0000000BW9l-3d0y;
	Tue, 07 May 2024 14:31:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Kk1-0000000BB9H-17XX
	for kexec@bombadil.infradead.org;
	Tue, 07 May 2024 13:20:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PnvoQVMa7ZC3l53Blv7r5V+orl9W9AIX0kTS8HyrztM=; b=psFIFybD/TiJKvwf8K4ifig4x+
	5CvbN40eR9KrhIkBW7qzor06nXh2t2hBk345/Z4nMLh4bhVNTI1fiz1mYX57LZdlgt3aCVv+GAnam
	/sEF3yTsSXxjq4sIwKRXagwfoStp2fR2Sc1KZYu6shpUYSZMzpGbXHgW/2UG3n7d0ynqWzwGnuxYq
	AujXx6glHombHgMOljidxLAebsD/hyar7881P9R7YsbQvQDOVP3qc8j983Z+phQCLETd8TWAuEdtL
	sqJKvTRDR6YHFfZvBh2y8WCYWTSE5onhx3biAsrqgk5UFlL7L944C4iorwwaFoq9S7Jcwoc3FsNXY
	yR192o3Q==;
Received: from shelob.surriel.com ([96.67.55.147])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Kjj-000000026Np-1eRh
	for kexec@lists.infradead.org;
	Tue, 07 May 2024 13:20:08 +0000
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1s4Kil-000000004Aa-0RLc;
	Tue, 07 May 2024 09:19:03 -0400
Date: Tue, 7 May 2024 09:18:58 -0400
From: Rik van Riel <riel@surriel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] fs/proc: fix softlockup in __read_vmcore
Message-ID: <20240507091858.36ff767f@imladris.surriel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_142004_241839_A567D200 
X-CRM114-Status: UNSURE (   8.97  )
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

While taking a kernel core dump with makedumpfile on a larger system,
softlockup messages often appear.

While softlockup warnings can be harmless, they can also interfere
with things like RCU freeing memory, which can be problematic when
the kdump kexec image is configured with as little memory as possible.

Avoid the softlockup, and give things like work items and RCU a
chance to do their thing during __read_vmcore by adding a cond_resched.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 fs/proc/vmcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..d06607a1f137 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -383,6 +383,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 		/* leave now if filled buffer already */
 		if (!iov_iter_count(iter))
 			return acc;
+
+		cond_resched();
 	}
 
 	list_for_each_entry(m, &vmcore_list, list) {
-- 
2.42.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
