Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BD5EB8FAF
	for <kexec@archiver.kernel.org>; Wed,  6 Sep 2023 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MkFs5HG3/t+jVSfjc91BzkLTsBonDkGBnbKS1ob1bZ8=; b=xJ8tUniCt6aN2C
	QdDQdBojqKFHGk7NegfQAF43mVKj2OgIab5oCUMTv0t4bT4BcP3gtzMiwdma7TcBfKHD4WHcAdqZj
	3SKcT1ePEdfAp7XcFwmIA6/Y1j12B41CGo7M8u7v0AYxLA4Elc5pKeqgOzSbLtCjH6YeyG7+d1BDy
	ADMdjMFk0Dx8YfzPbVwm4tW6xe4vjWNWUCCYtYhj5YpM3f7UvREllX5v9xBRFd/12irjDmteHl5GU
	Ugs0HQWBwJ4kCsjATuQQ0kTZcxMZ5hed07UZKMsyyuwn/NdtUoeKH7QrrbfGb6p5jnjQHAhL8G9rk
	9++IgQY0eE3urEVgv+qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdp6U-007zMf-3D;
	Wed, 06 Sep 2023 09:45:43 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdn8Q-007XFU-0M
	for kexec@lists.infradead.org;
	Wed, 06 Sep 2023 07:39:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985974; x=1725521974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fgNzEeiwp6pBaULO4mpRILdHhEu7rh3ebMJew1dYykw=;
  b=PnKs9o5qIPXRpbt5VN3AXHE+wHvUR7zFx4VtAIvhTT9jZs1aavCfd8WL
   35gyUSGaoBIvNCEd01Gbj9xVN34jxhaSCP7z9YXx8FpNZfHy8oD3IsWXP
   4jlY/UkFLbRyRW3ytp6rIdwaKwJPmblXUX1QdwkCl+3yg4s5K0XPnJ38l
   hl8vliZIBSLpm6A66Es9qRnl8k+jGBc6HVcMIMPCBlvoFW+S9qC88B9f3
   qRICwlVwI7Fg6LTNhtlbiKP6gnQQia0yTk3Jb2crx46xf+S7xabRCIvtL
   Ru9yd9fmeTQBuM6PN44fdGhMcLviNuF63jgnnyGtmd6XW6XpS9j/k8/k6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898486"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133806"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133806"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:29 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Date: Wed,  6 Sep 2023 10:39:02 +0300
Message-Id: <20230906073902.4229-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906073902.4229-1-adrian.hunter@intel.com>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_003934_158232_3075722D 
X-CRM114-Status: GOOD (  14.80  )
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

Support for unaccepted memory was added recently, refer commit
dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
a virtual machine may need to accept memory before it can be used.

Do not map unaccepted memory because it can cause the guest to fail.

For /dev/mem, this means a read of unaccepted memory will return zeros,
a write to unaccepted memory will be ignored, but an mmap of unaccepted
memory will return an error.

Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/char/mem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 1052b0f2d4cf..1a7c5728783c 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -147,7 +147,8 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 			goto failed;
 
 		err = -EFAULT;
-		if (allowed == 2) {
+		if (allowed == 2 ||
+		    range_contains_unaccepted_memory(p, p + sz)) {
 			/* Show zeros for restricted memory. */
 			remaining = clear_user(buf, sz);
 		} else {
@@ -226,7 +227,8 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 			return -EPERM;
 
 		/* Skip actual writing when a page is marked as restricted. */
-		if (allowed == 1) {
+		if (allowed == 1 &&
+		    !range_contains_unaccepted_memory(p, p + sz)) {
 			/*
 			 * On ia64 if a page has been mapped somewhere as
 			 * uncached, then it must also be accessed uncached
@@ -378,6 +380,9 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 						&vma->vm_page_prot))
 		return -EINVAL;
 
+	if (range_contains_unaccepted_memory(offset, offset + size))
+		return -EINVAL;
+
 	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
 						 size,
 						 vma->vm_page_prot);
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
