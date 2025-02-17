Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA861C02198
	for <kexec@archiver.kernel.org>; Mon, 17 Feb 2025 01:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BHBjPh4iP2hs0khM2uQ8R0Q1AC6QEeLnNz4ao7U+Vq4=; b=eMHFzjxZRsAFEuJfSQf/ZktAnb
	5V5MJ4Qn/D2+F6PBFhdxaXG0z4j+ppkZ3mplt0BWJJtRKkOZtCbVVDx+mOyhYhsMa+hanvNXImcMw
	UeyEuvx690FCWwHXOOUqIGRF0ouUkxHISICguO2TBs1e2mqf8CKSo4EWriZX+odKbK8gl+2Afexvo
	uBFM8FIt45m6iJ26nnAEbc8JpIHpxDUTqtnRq9k6hNXAC2tYTc1joE2fDR88nAXx5Ug/GX0LgmnAb
	Zo+tyt+kO+sUNh66/clfL1jH3xj1EcRl7rJ0yDXIDUg6Y/RPbwd9uzrGcYNqa2EnyKgs3tRXzwTkQ
	Lbqu3NTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjqFN-00000002zZK-0C1f;
	Mon, 17 Feb 2025 01:48:33 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjqFK-00000002zYt-0SAf
	for kexec@lists.infradead.org;
	Mon, 17 Feb 2025 01:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739756910; x=1771292910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GwrQAvpI+du66jAl7ybJ2vRX2ga2dva4adjZ6Ub7XM=;
  b=nhBKNQsdi01ed4sIswzHrMUOuPWMvzYz9TIVxFesAbeOFfiubVZW5Uv9
   T9gND9P8MLZ+DO+X5XTmLdFq0wVYoANTMeNjfsT+Fc42T+0M/R+9dYdND
   oFxpOhAzqgQhPBf/kPbg0KQiAa7w4YDRj+Ym4HlfadaxXkZ0YmuCERZwI
   7GnUj/pJOoVX59AEdLLPrDtOohOqs+urZGB/V8Ok0GhNrqleN0PAYw11c
   BYAMlpGMJcSrsW1WC7ncLhZTDh7rhxFrfHNJ3DSlSDZtgWRioLJjvjW+N
   SXhYS4rvDwpbSq+4SpQZ+MtpuqXMWT+tE0qOvByxvhVru1Zrc5GpbFtKP
   w==;
X-CSE-ConnectionGUID: MZOLyWR0Q+C1DL0KdZFKHg==
X-CSE-MsgGUID: Zi0pX0BgTWmC2ZXln8PwXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51856124"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51856124"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 17:48:28 -0800
X-CSE-ConnectionGUID: ePYr3PJcSLCXvJq2ubhrkA==
X-CSE-MsgGUID: xjwPS82HT+SVi3vgaGRq/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="113932110"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by orviesa006.jf.intel.com with ESMTP; 16 Feb 2025 17:48:25 -0800
From: Zhiquan Li <zhiquan1.li@intel.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v2 RESEND] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
Date: Mon, 17 Feb 2025 10:24:35 +0800
Message-Id: <20250217022435.4056776-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_174830_190240_70F9C25F 
X-CRM114-Status: GOOD (  12.30  )
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
- No changes on this, just rebasd to v6.14-rc3.

V1: https://lore.kernel.org/all/20250103074941.3651765-1-zhiquan1.li@intel.com/

Changes since V1:
- Rebase to v6.14-rc3.
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

base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
-- 
2.25.1


