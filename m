Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6E2C36014
	for <kexec@archiver.kernel.org>; Thu,  3 Apr 2025 02:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QYV0Y3MWP3T8XP7XmwVg/W+FXJIV9Pzu3gKcBJXdzn8=; b=cdz7A1eEJ2KUO+wy747UkLOMwu
	Cwy3qpeP6Db+G9FungjEerK4OpaIFIDmNVMqgv4LMszcYKRdiGTNHjF67YpFt1UTzccoMCxGxkUoy
	trvWIL8f08czTWJTlYe+N3LBAnSMsbjykN/aou0IufSZVQnydypfYMlIF/BuavVobO1O9jMBT0yJE
	i8V72jnPWI11RyV5xkzQE/2Ih3EhK+HHqqIl3WQ3GI6KChXhxjcSAUAeUlsE+LQ23KEKpdOwVC1EB
	7QIKrgG/dPjwXQKwYkHSaeRU89pKuymvunPC0sL3tlhTBXB+s1UWFgdJtBCDoOFXnm4oDa3GBYNg/
	yubYaDpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ANT-00000007bZk-2BFl;
	Thu, 03 Apr 2025 02:32:23 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ANQ-00000007bZ5-3mAq
	for kexec@lists.infradead.org;
	Thu, 03 Apr 2025 02:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743647541; x=1775183541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xXnYZQ5jMf6nhqCdS6uW6efKNxrmzpOpJ2V1JKalSDM=;
  b=MYMHrnPmso0PIMKDfFl06FgMZLuhXP56IPkKR55Jn7k2TPziyspLEX6W
   g9l/kXzhxUDgDbl7aUYVBcqa4ApZgFwEyff/EuQv7kzHUMvL293kyxbCb
   bCQolGS8R9tGYDX89/4i1KLczaJvaopVcWLIaMQ7SPLE9PCgYS7z0tvaX
   eEZ7bjQW5OpBzDJKpALRYyOBj07k8lpORp0UcDdp0KUuUcCtOOv825S6Z
   y48UYjB1rWctM1rochOK7rC5lBd3woBs6MUe8Ciu2/aOC65sEIyn4qjQ1
   e2MR4PXSRNspL7kufCXeb2X3VF0QarcWU2UBXn0whOwNV6zht1u444uaA
   g==;
X-CSE-ConnectionGUID: xDBxemT1TduPH7XsUyE5SA==
X-CSE-MsgGUID: X9ja+6OeQy6aemuTbfxx8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44746637"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44746637"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 19:32:16 -0700
X-CSE-ConnectionGUID: uimG9/XdQdWzJwA7doj0vg==
X-CSE-MsgGUID: MMLPcXoOSV6oYTdKOJdZ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127368911"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by fmviesa010.fm.intel.com with ESMTP; 02 Apr 2025 19:32:13 -0700
From: Zhiquan Li <zhiquan1.li@intel.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v2 RESEND] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
Date: Thu,  3 Apr 2025 11:08:01 +0800
Message-Id: <20250403030801.758687-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_193221_000202_E0AD42FC 
X-CRM114-Status: GOOD (  13.48  )
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
Vmcore size statistic of a freshly booted TD VM with different memory
sizes:

  VM.mem | Before  After
  -------+----------------
  512G   | ~4.9G   ~2.0G
  256G   | ~2.0G   ~1.1G

Most of changes are done by makedumpfile, but the prerequisite is kernel
needs to export an indicator to identify unaccepted pages in vmcoreinfo.

V2 RESEND note:
- No changes on this, just rebasd to v6.14.

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

base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.25.1


