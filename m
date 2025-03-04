Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2188C282C6
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 02:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fmPqlGxmDJHy31AFSFilpMNdtPSkwI2cym3RF5aspYA=; b=qpAtXx42gJZDvkGiEzCErI1V4+
	UM+hSTUabw6fN2YF2lUBl89VVIJyEpigCfsCeRP1rXTFrNpi6iSp24ISiB4yifECRWIztifOlDbay
	wa/IeuBEV8h7kPMX34tLhoBQ48SJHJOrMuBpZVx5vTp9NCCBkcbR3B6ilheWwTIk588taLIoNkHhM
	M14guIgS9Cdu3QRkuJCP3NNufUe66NzRsft58ha14RdJPMN+ID/ZJY8meqwbcKln7g92jBtiZtaU8
	0Z+GO1byOBH2eSFCoVVhg0KPZuu40fFBv4itzRZjvR9Y92SKQwHcgKc0tAw/Zq+QLNzCOB2fD+/d8
	Wv7YwPqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpI27-00000002u7Z-03wo;
	Tue, 04 Mar 2025 02:29:23 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpHyv-00000002teI-0XPT
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 02:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741055165; x=1772591165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xTuOfrIUzYJfE4dXLNmbIGwP4eOxJEuJfLBSjb6Lb0M=;
  b=gBAYtxGtWZezt0lDGqzpIDdMIa54u8V4iZR1RNyHW7m35Ut1FqUdkGD1
   opv9EnjeT5DsOf/iS8xqmzOPJd6umUL9xUA3jex/x6hZVuuTpYzRH6le6
   nIaaDbG2X+THtCZ2OO/fFtB+4wjmCZXr9V3rkkziFzUlPx41pSVY2RWtm
   yYw3Fu0Y7WXgjs6/5VXnpxnxTyjLPhL4X/bHmDpDec3momdALFddTJ3e9
   NnJeUfsx29fvJRQrIOtrIOF8PEp7dIfW1216gHW6D/vgeprdXQhGxrSnC
   ZUTKGTki93EyUIRHy+v+hlBZYEunuLgTzCYwpl1JgdvKfKewlt5+euZI5
   w==;
X-CSE-ConnectionGUID: ijXiONsBS6qUe0Ik8lgqMw==
X-CSE-MsgGUID: XlIa9SIwSI6GCXm9m/Puxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53358188"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53358188"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:25:59 -0800
X-CSE-ConnectionGUID: riYarjPuQb6rzkaZ1DGrtA==
X-CSE-MsgGUID: fVi2j3fWQ42aAnsrEsdXkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118083185"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by orviesa010.jf.intel.com with ESMTP; 03 Mar 2025 18:25:57 -0800
From: Zhiquan Li <zhiquan1.li@intel.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v2 RESEND] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
Date: Tue,  4 Mar 2025 11:02:03 +0800
Message-Id: <20250304030203.1684256-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_182605_179337_E9026DE2 
X-CRM114-Status: GOOD (  12.72  )
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

---
V2 RESEND note:
- No changes on this, just rebasd to v6.14-rc5.

V1: https://lore.kernel.org/all/20250103074941.3651765-1-zhiquan1.li@intel.com/

Changes since V1:
- Rebase to v6.14-rc5.
- Added document into admin-guide/kdump/vmcoreinfo.rst per Dave's
  suggestion.
- Add Kirill's Reviewed-by tag.
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 2 +-
 kernel/vmcore_info.c                           | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 0f714fc945ac..3b47916f1856 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -331,7 +331,7 @@ PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision|PG_head_mask|P
 Page attributes. These flags are used to filter various unnecessary for
 dumping pages.
 
-PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
+PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_unaccepted)
 -----------------------------------------------------------------------------
 
 More page attributes. These flags are used to filter various unnecessary for
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

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.25.1


