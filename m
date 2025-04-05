Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA24C36010
	for <kexec@archiver.kernel.org>; Sat,  5 Apr 2025 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tTQ17U6sjQuFMtMrMTRX45NJVSbACjFBFS0A1p5grqY=; b=CrTeJ5WMoW0poB4S+iPkAR2AIP
	rO5DEFjjsRaOBl/QhIkpPhCQYaNXVdOphV/ceEDtUBdC5LO+ZqEqJ8o84QJkIpH0QBms34HdDFnbJ
	CCGp4uFxuy5+5SUDqEeq20DUHf8VKRz0jFh4PRk/3+iznMAgyEFs38bAixRHRX52qQUsE0gq3QHCM
	Gl6XPbZbJocU8RicQhl/4Qn455K+6w48pZNbaklaN1odn6Nt6FzjlJdvhPR3yuOzUBZy1PTv3eObX
	Nms/Qj89Mspp6KzSK9CKXxAnF8Pi+tVc2urXKSOdL1lirgHDeNq54SnzhwGNlpp/HCe44ZobtHXyR
	mqVjrt0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0w6v-0000000DVfw-31mV;
	Sat, 05 Apr 2025 05:30:29 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0w6t-0000000DVfX-0MYa
	for kexec@lists.infradead.org;
	Sat, 05 Apr 2025 05:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743831027; x=1775367027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zEsc7b6P2dS3SJaNmkZRSte+pyqL0ydAbw4F1IszLMU=;
  b=fLniUP3VT0g72lhU3fFqmK33vWNqWm5d/ES3c//gzdAPFjWZmjM8Yrnt
   jY8nTORVt4gU4lKhLFMZMUTR/P7lD2UIIscEhfywe5fJTvuaW9Q29h0Iv
   qvDvdmEnfTE47KmzF5Jkz7jOEiQ7yrOzjyogQmmW1e2Fsxlwm1/IVfF1g
   kGXWJH2sXBAAft/V0sKnicE0p+LIedywMFwovFcV5puRqF8NGu3BtzVHv
   Vguw0E/N6FNVAOHNYMCRH5kdzum8ISaAaNnzfk+agQXQ8BgLkSYdfZznM
   ggqED6WAisN14aJQTNCv0ay0wrjkq+8gbshSXhbOzB1uqCews9uVYxGpX
   g==;
X-CSE-ConnectionGUID: lll4LikvSYKqx6e4W47BnA==
X-CSE-MsgGUID: vqjZWRAoQrisTF7rNdyogg==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="55942272"
X-IronPort-AV: E=Sophos;i="6.15,190,1739865600"; 
   d="scan'208";a="55942272"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 22:30:21 -0700
X-CSE-ConnectionGUID: OyKeFk3YT56cuwkUVwSO5g==
X-CSE-MsgGUID: H9DYO3P+SwiMemLl0bBCoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,190,1739865600"; 
   d="scan'208";a="127474228"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by fmviesa007.fm.intel.com with ESMTP; 04 Apr 2025 22:30:17 -0700
From: Zhiquan Li <zhiquan1.li@intel.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	k-hagio-ab@nec.com,
	yamazaki-msmt@nec.com,
	lijiang@redhat.com,
	ltao@redhat.com,
	zhiquan1.li@intel.com
Subject: [PATCH v3] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
Date: Sat,  5 Apr 2025 14:06:10 +0800
Message-Id: <20250405060610.860465-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_223027_164421_98010916 
X-CRM114-Status: GOOD (  12.00  )
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

On Intel TDX guest, unaccepted memory is unusable free memory which is
not managed by buddy, until it's accepted by guest.  Before that, it
cannot be accessed by the first kernel as well as the kexec'ed kernel.
The kexec'ed kernel will skip these pages and fill in zero data for the
reader of vmcore.

The dump tool like makedumpfile creates a page descriptor (size 24
bytes) for each non-free page, including zero data page, but it will not
create descriptor for free pages.  If it is not able to distinguish
these unaccepted pages with zero data pages, a certain amount of space
will be wasted in proportion (~1/170).  In fact, as a special kind of
free page the unaccepted pages should be excluded, like the real free
pages.

Export the page type PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo, so
that dump tool can identify whether a page is unaccepted.

Link: https://lore.kernel.org/all/20240809114854.3745464-5-kirill.shutemov@linux.intel.com/

Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Baoquan He <bhe@redhat.com>

---
Vmcore size statistic of a freshly booted TD VM with different memory
sizes:

  VM.mem | Before  After
  -------+----------------
  512G   | ~4.9G   ~2.0G
  256G   | ~2.0G   ~1.1G

Most of changes are done by makedumpfile, but the prerequisite is kernel
needs to export an indicator to identify unaccepted pages in vmcoreinfo.

V2: https://lore.kernel.org/all/20250403030801.758687-1-zhiquan1.li@intel.com/

Changes since V2:
- Add Baoquan's Acked-by tag.
- Fix docs: "Title underline too short" warning.

V1: https://lore.kernel.org/all/20250103074941.3651765-1-zhiquan1.li@intel.com/

Changes since V1:
- Rebase to v6.14.
- Added document into admin-guide/kdump/vmcoreinfo.rst per Dave's
  suggestion.
- Add Kirill's Reviewed-by tag.
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 4 ++--
 kernel/vmcore_info.c                           | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 0f714fc945ac..8cf4614385b7 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -331,8 +331,8 @@ PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision|PG_head_mask|P
 Page attributes. These flags are used to filter various unnecessary for
 dumping pages.
 
-PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
------------------------------------------------------------------------------
+PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_unaccepted)
+-------------------------------------------------------------------------------------------------------------------------
 
 More page attributes. These flags are used to filter various unnecessary for
 dumping pages.
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 1fec61603ef3..e066d31d08f8 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -210,6 +210,10 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE);
 #define PAGE_OFFLINE_MAPCOUNT_VALUE	(PGTY_offline << 24)
 	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
+#ifdef CONFIG_UNACCEPTED_MEMORY
+#define PAGE_UNACCEPTED_MAPCOUNT_VALUE	(PGTY_unaccepted << 24)
+	VMCOREINFO_NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE);
+#endif
 
 #ifdef CONFIG_KALLSYMS
 	VMCOREINFO_SYMBOL(kallsyms_names);

base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.25.1


