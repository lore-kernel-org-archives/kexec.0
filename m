Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758EDEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xS78TKOcQvNpbI6GwoEJjDUVHmfweNmEhbv+X+4Ir8w=; b=ypul7M8CHBlBZ6
	wXYlcvMPbvEiJM4SCqlbawmUWFsVmHsRJEmv3jdVi0zLWgrZXiESB2icWE+Ss3eQ7cmb/XNnDE6uw
	E1/TnVBtnvhns7h3VkLnosNYElz4ydzLFi2pjUGVIJYLRU0NRY31gVW44z5kdWyyNKDjuQ+1tzLa2
	R/h1PHsk0+j/OYvczBw0MkyndonMYrc9WLW718CPBhljm5SxDsxIJhFPKvG6nc5mh/WMElznWOfEu
	UuyLugv+I8/n9Wia1lbjShFGJTXPu15/IJBbWuzI1AaDseg8vsofBVND5jgQOh1VykHcCCuPTPaQE
	92/r9ztDcGYTDWn+2APA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfezE-000NCl-02;
	Mon, 11 Sep 2023 11:21:48 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfezB-000NC3-2q
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 11:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431305; x=1725967305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M9e2eeN/kfGtE3gA5n3bGk//DgEyKzp702J0NcFnLyE=;
  b=NKfOwgfGSd6WrjeU3QDdKYQhFHVc+GWTzubfzrKE2Q/PGHaATxUev7vj
   qBXZPntQ6En3mGr5uzb1O9J5e1h+uTIrq4JMvThMoE1T0U9vHE/oyTGw0
   QT92dbYgGxd/1+Zjrb79ABRUdIyHyPw60S33f5GaZwLRQHnvuh9AdY5Gf
   aUVNU0o5HlPv/7O1ArrBouGe0TB7sIdH128/9bmaaDWDfNv/SIASu42Yt
   VVN3J3ecPzsc4QRuitNMa/RyRCtZzM5D0rQyiNAf4ryDXe9TtH5Y+P+NQ
   UnAbdZOs8nK1gU17Tayk2m0CzanGy3uulgm0hlKcMqiQGT6zJuoovHiql
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358358430"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358358430"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778356406"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778356406"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.216.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:35 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>
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
Subject: [PATCH V2 2/2] proc/kcore: Do not try to access unaccepted memory
Date: Mon, 11 Sep 2023 14:21:14 +0300
Message-Id: <20230911112114.91323-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911112114.91323-1-adrian.hunter@intel.com>
References: <20230911112114.91323-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_042145_930641_222B5E98 
X-CRM114-Status: GOOD (  11.66  )
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
dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby a virtual
machine may need to accept memory before it can be used.

Do not try to access unaccepted memory because it can cause the guest to
fail.

For /proc/kcore, which is read-only and does not support mmap, this means a
read of unaccepted memory will return zeros.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 fs/proc/kcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


Changes in V2:

          Change patch subject and commit message
          Do not open code pfn_is_unaccepted_memory()


diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 23fc24d16b31..6422e569b080 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -546,7 +546,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
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
