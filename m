Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E289EB8FAD
	for <kexec@archiver.kernel.org>; Wed,  6 Sep 2023 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=saboB2C3kg5UGUzBBDaqSnqxpSGuRNqGospYnReFh3c=; b=02r9499MWwBjew
	NHnewBUGePZSA3F5V0t3kDoYFow7iAO6bkCpN+KLoW0f7nwKA8l9LlHRES/40b9qIgjtEySeTRbgd
	Q3COaRyV3yNrPCdrhXlfr8G6Pq0wjqBlLGCFxzYCUYAozlUdG8z42LOM0ZdxUoFFUZjBziICKcWCL
	d8d5LiM7j16Rni/cFdzeltkTXNSGEKCtV7Fzv8v41O60mTkN3RlbLVQVYivuDUbxvSuhb8TUc6yh0
	099ZG4lYvHXe8xhSD0bP3yXhu3ery5o6w3WyuXboV7gyGQDpY8Vq0Gvkq6n2AqmqSWQdiw3Ehm//N
	qadGcvrkmLPMw4rpy0fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdp6U-007zLy-0p;
	Wed, 06 Sep 2023 09:45:42 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdn8H-007XFU-0V
	for kexec@lists.infradead.org;
	Wed, 06 Sep 2023 07:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985965; x=1725521965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvs+CfaaOcukCPcQ3yn99op16Cq3tmycYYGCo66m1aQ=;
  b=kwrZY6Ut+8R+95gMkpMAf2aMdCGH4KrJn+GQrVO3Xy6s4m09jDPWukG/
   RqgMRnLqvGGuVHvRkU4m+6JEsbjJTmiDTDAWSwgb2z9BCTXB07EWiWWkh
   l/0qUSJYMP5b85NjTH/dGOXz/4gvPACQeSFKGflZjfHsklCHouVya7ulc
   m0Q+F597laFR45zMMcWwzhjjp5alGiUVoK+nnbYrzFFR8WJNz2SdUDk7c
   6ghBOe9LEZivArtyB9A964u3XCU9hcZohCC/Mowve1iKmea7AtFmPq/M8
   GBHnKsbKzXy+vQYL1sbrADq0oxEDasPzOi32YbtYbIF0dquV+as2BNQE4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898456"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898456"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133789"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133789"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:20 -0700
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
Subject: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Date: Wed,  6 Sep 2023 10:39:00 +0300
Message-Id: <20230906073902.4229-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906073902.4229-1-adrian.hunter@intel.com>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_003925_207743_D42933E9 
X-CRM114-Status: GOOD (  13.64  )
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

For /proc/vmcore, which is read-only, this means a read or mmap of
unaccepted memory will return zeros.

Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 fs/proc/vmcore.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..a28da2033ce8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -118,6 +118,13 @@ static bool pfn_is_ram(unsigned long pfn)
 	return ret;
 }
 
+static bool pfn_is_unaccepted_memory(unsigned long pfn)
+{
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
+
+	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
+}
+
 static int open_vmcore(struct inode *inode, struct file *file)
 {
 	spin_lock(&vmcore_cb_lock);
@@ -150,7 +157,7 @@ ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			nr_bytes = count;
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (!pfn_is_ram(pfn)) {
+		if (!pfn_is_ram(pfn) || pfn_is_unaccepted_memory(pfn)) {
 			tmp = iov_iter_zero(nr_bytes, iter);
 		} else {
 			if (encrypted)
@@ -511,7 +518,7 @@ static int remap_oldmem_pfn_checked(struct vm_area_struct *vma,
 	pos_end = pfn + (size >> PAGE_SHIFT);
 
 	for (pos = pos_start; pos < pos_end; ++pos) {
-		if (!pfn_is_ram(pos)) {
+		if (!pfn_is_ram(pos) || pfn_is_unaccepted_memory(pos)) {
 			/*
 			 * We hit a page which is not ram. Remap the continuous
 			 * region between pos_start and pos-1 and replace
@@ -552,6 +559,7 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 			    unsigned long from, unsigned long pfn,
 			    unsigned long size, pgprot_t prot)
 {
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
 	int ret, idx;
 
 	/*
@@ -559,7 +567,8 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 	 * pages without a reason.
 	 */
 	idx = srcu_read_lock(&vmcore_cb_srcu);
-	if (!list_empty(&vmcore_cb_list))
+	if (!list_empty(&vmcore_cb_list) ||
+	    range_contains_unaccepted_memory(paddr, paddr + size))
 		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
 	else
 		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
