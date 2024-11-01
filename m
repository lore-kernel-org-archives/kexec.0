Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E95E6749E
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 03:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vNGXQ+yeMziZ/UIM3VDG4ZSQBGfF99rywTl0linCXY4=; b=epsPtaRCxaDfF/
	bBjOt8T0JfuOpYurTTgI0ZnG3bTowPC34ByJUtKSV2ZMY/eAP9K88Q2nOeLsRyP1g5vE9X5WrLjtV
	CCcCyPII5sVc3fdaFm0V7SzNFS6c6dslFUB7RA4sUu+GjobY1wlVfmNNaGURH2K2UahMZ6Wv+bu/D
	fp3/ZZzQKSjxyPRxFxF0NWfziluBEwQ1KxzbcHg1uGrNpzOx0rvlBiIGzuMXOKgdWfJCHWBDqr2+n
	mMu7/mmVtBnGpQzzTdoWr8GqkvhAZ+gtZ6KblEPAU+CH10jJni7uLo2dJ7VAIMtDiPfb1qSJiwAHG
	z28J/0dhMHH93q4/g2xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ie4-00000005h9h-0vnk;
	Fri, 01 Nov 2024 03:48:20 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ie1-00000005h8O-0m8u
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 03:48:19 +0000
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XfmxH6FFczpXjJ;
	Fri,  1 Nov 2024 11:46:11 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 1940C18006C;
	Fri,  1 Nov 2024 11:48:07 +0800 (CST)
Received: from huawei.com (10.44.142.84) by kwepemm600002.china.huawei.com
 (7.193.23.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Nov
 2024 11:48:06 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] fs/proc: Fix compile warning about variable 'vmcore_mmap_ops'
Date: Fri, 1 Nov 2024 11:43:49 +0800
Message-ID: <20241101034349.8915-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <f79d2587-2588-598f-f9b2-2e3548067d92@huawei.com>
References: <f79d2587-2588-598f-f9b2-2e3548067d92@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.44.142.84]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_204817_398622_4B71343A 
X-CRM114-Status: UNSURE (   9.79  )
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

When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
is defined but not used:

>> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
     458 | static const struct vm_operations_struct vmcore_mmap_ops = {

Fix this by only defining it when CONFIG_MMU is enabled.

Fixes: 9cb218131de1 ("vmcore: introduce remap_oldmem_pfn_range()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202410301936.GcE8yUos-lkp@intel.com/
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
v3: move changelogs after the '---' line
v2: use ifdef instead of __maybe_unused

 fs/proc/vmcore.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..9ed1f6902c8f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -455,10 +455,6 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
-	.fault = mmap_vmcore_fault,
-};
-
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
  * @size: size of buffer
@@ -486,6 +482,11 @@ static inline char *vmcore_alloc_buf(size_t size)
  * virtually contiguous user-space in ELF layout.
  */
 #ifdef CONFIG_MMU
+
+static const struct vm_operations_struct vmcore_mmap_ops = {
+	.fault = mmap_vmcore_fault,
+};
+
 /*
  * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
  * reported as not being ram with the zero page.
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
