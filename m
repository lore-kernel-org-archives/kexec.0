Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9806FEB8FB6
	for <kexec@archiver.kernel.org>; Wed,  6 Sep 2023 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=urNtlUqNOzDZbAB/KEkJikXvs3R6D/CeuRlvWtV6v2U=; b=qB8MalPocbUaUZ
	RRPY38fud0XuCTdj4+q+C3CSTmwlG2PS2Y7rji+/n3FQFfrFTGd+EftYyz/HGLGGxPy7rNuClTTvw
	UedRLFMGcrgtkF0lFTcYpm7IRKgYyvxGsOKSszh78xBRsQ6n2Qn5lBvQ66T0zf5GL5GEVkczBmyw/
	XtDSGR8SY3zEKnyXtKcXcjvaH1HCOBoByQ3T57KBb4sv741ckiiVA3IEMTihbXlZQxao7Vi+KsQNN
	JLFoSDpWa0mvDk4FP5pCELakrAVDLVa/hoXKAllxgsijH77zpjhP6eZLWN6KboCZFsFBdW9TilJu8
	bRCWFzAfGK3qt23uCdyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdn8N-007XKM-2f;
	Wed, 06 Sep 2023 07:39:31 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdn8L-007XFU-1l
	for kexec@lists.infradead.org;
	Wed, 06 Sep 2023 07:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985969; x=1725521969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCFPnesd773Gv+sIsXwxuNHU7U7Bs8P2FxvU4qByuSM=;
  b=g0CHtJZhrNgF7OKEUSNtmuSGYuZH5Ox8IysJ9Th981FngrpLjy4fYyVP
   T9MODacwYflplKZDKyC1V7fRTuH15PlSF4Nww2qDk+aVgYXED/dP7QYD6
   m8RMO2trK0vGnhpXr+5V3tp1PRQxHQILUEkTn8T6flhP6fHTimIG50spk
   on2kJeK+dsTwQApZaH5H2QmL+mP11qtH/yKdwVgfLZNasbS955YU4B9A8
   3X8pYaCp6+LNHVEn44uzkgkuf8QDctwrLLJBJ3Sqt/CcLVLiDExlO8EyL
   fSyRSFXcLpFD6dm1rS9KuLd3x8KMtOUUtDm83PCYBKxc9YsFQ3bLg2Kpq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898470"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898470"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133794"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133794"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:24 -0700
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
Subject: [PATCH 2/3] proc/kcore: Do not map unaccepted memory
Date: Wed,  6 Sep 2023 10:39:01 +0300
Message-Id: <20230906073902.4229-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906073902.4229-1-adrian.hunter@intel.com>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_003929_591932_192AC136 
X-CRM114-Status: GOOD (  13.24  )
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

For /proc/kcore, which is read-only and does not support mmap, this means a
read of unaccepted memory will return zeros.

Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 fs/proc/kcore.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 23fc24d16b31..a3091c5ed871 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -76,6 +76,13 @@ static int pfn_is_ram(unsigned long pfn)
 		return 1;
 }
 
+static bool pfn_is_unaccepted_memory(unsigned long pfn)
+{
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
+
+	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
+}
+
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
 void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
 		       int type)
@@ -546,7 +553,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			 * and explicitly excluded physical ranges.
 			 */
 			if (!page || PageOffline(page) ||
-			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
+			    is_page_hwpoison(page) || !pfn_is_ram(pfn) ||
+			    pfn_is_unaccepted_memory(pfn)) {
 				if (iov_iter_zero(tsz, iter) != tsz) {
 					ret = -EFAULT;
 					goto out;
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
