Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A676E68958
	for <kexec@archiver.kernel.org>; Thu, 31 Oct 2024 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F7nqxhb1y3kIE/+qvm+vgSYZViZoBv4GH9fNTFcyXeM=; b=kO4Gn9JhyyNnjS
	0BI9jBnXp76x/tkJbPoztLDPwRWpMV07ULA9eL2woa/eugZsFp2agKfMPUqDOCWFZYD4B9ifVgYaf
	sBwPKpfOvheQBSL8ggMlVW5egL5tgrmhrfRJkqqqO7JDEXzhWgOj8QHzcXXaycJyXox5XuoR25KuY
	Ao1QGoz/T3Bded2cz3nQJ5QErmJiBAnlwwm60fQJIUdwjy+t2ah1YE408SUiJuW50sDYzonD5Apen
	j42157e6yX+H3T6YKPgvJqBSj/M+QCY6Yg6NcGfjWrM0HaNRgYFyoOv80MHGoJqHBl8Zi93of7zNE
	SI+G7eyI6fQJ2h4Y1Q+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6PfZ-00000002ojk-46LF;
	Thu, 31 Oct 2024 07:32:37 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6PfG-00000002odS-0RZ5
	for kexec@lists.infradead.org;
	Thu, 31 Oct 2024 07:32:20 +0000
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XfFyQ6hFDzySM0;
	Thu, 31 Oct 2024 15:30:22 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id EED8E1800A5;
	Thu, 31 Oct 2024 15:32:02 +0800 (CST)
Received: from huawei.com (10.44.142.84) by kwepemm600002.china.huawei.com
 (7.193.23.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Oct
 2024 15:32:02 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/proc: Fix compile warning about variable 'vmcore_mmap_ops'
Date: Thu, 31 Oct 2024 15:27:46 +0800
Message-ID: <20241031072746.12897-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [10.44.142.84]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_003218_346948_713E3443 
X-CRM114-Status: GOOD (  10.33  )
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

When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
is defined but not used:

>> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
     458 | static const struct vm_operations_struct vmcore_mmap_ops = {

Fix this by declaring it __maybe_unused.

Fixes: 9cb218131de1 ("vmcore: introduce remap_oldmem_pfn_range()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202410301936.GcE8yUos-lkp@intel.com/
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..9651f105c25b 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -455,7 +455,7 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
+static const struct vm_operations_struct __maybe_unused vmcore_mmap_ops = {
 	.fault = mmap_vmcore_fault,
 };
 
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
