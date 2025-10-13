Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D17CCD187
	for <kexec@archiver.kernel.org>; Mon, 13 Oct 2025 02:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zoAUUn3bBmorrWCF+Kq+jcKJMJh3OyLAIbSpHP6CdMA=; b=Tf4VWBYzoHq1cBaydFw4XcReuA
	CkiDCzi+sbsU+zZ6R0tmk6FNeVSE29ziypfVIb5o/QMqO/qjUFd8+p3mbuC0iXYhm15V6bwAEVGRI
	Pog+AlbZyULseSTy5mzYqEVo5sCXutHBCDeLAr5k4BrxlJQyALYMVM4HSD9GRzGiHTPzYR4etRgdw
	KBHQUNk45PA+SsYR2+uuPimfuK8tSlEMf4iZE9nocBqQFFFGFzic2PHLziJ0corf3stBSpf40uBbf
	GG0hLPmgOjxz53J4B0V/TwDi+lCh3C8BxXmipxXXioZ6jgEizYyPivuwtyAlxeuPJfNJ4TT3cFfLN
	Wnw7prEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v889P-0000000C6Qo-1mLD;
	Mon, 13 Oct 2025 02:19:03 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v889M-0000000C6Q5-0DAG
	for kexec@lists.infradead.org;
	Mon, 13 Oct 2025 02:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760321935; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zoAUUn3bBmorrWCF+Kq+jcKJMJh3OyLAIbSpHP6CdMA=;
	b=oP0jsrMhurLGUfFoZD+Gi0voonR5jzLmt2LR6gkV7sOFLf2WDNcAYZG97vSc+tyG0iudWQsX3X4IgvBilWuFmAQqPIXuFLDmG+l2b3eAliyboGb2nsHwyoakjDfuud9Uti10s2haR917rNR2yKQXvCYyr2xW172JZCyvJWI1r+A=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WpzmIqu_1760321916 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 10:18:52 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: graf@amazon.com
Cc: rppt@kernel.org,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] liveupdate: kho: remove unneeded semicolon
Date: Mon, 13 Oct 2025 10:18:36 +0800
Message-ID: <20251013021836.944898-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_191900_243113_74D42F35 
X-CRM114-Status: UNSURE (   6.42  )
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

No functional modification involved.

./kernel/liveupdate/kexec_handover.c:1155:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26158
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5da21f1510cc..c87d00c40c82 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1152,7 +1152,7 @@ static int __kho_finalize(void)
 		err |= fdt_begin_node(root, fdt->name);
 		err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
 		err |= fdt_end_node(root);
-	};
+	}
 	mutex_unlock(&kho_out.fdts_lock);
 
 	err |= fdt_end_node(root);
-- 
2.43.5


