Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31C0E77188
	for <kexec@archiver.kernel.org>; Fri,  3 Jan 2025 07:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N+7B+Kw0GmvQ8fB2VyizNeveTL9HjP/ERiwa5enPchE=; b=w9oytVw9deCqcEEKv7QQ5d0tvP
	zODDhlyMgFzz0TDkXBqfDz6PJOcUB6EszAGgvgugUESrDvpOJJ+B4Wd0SmxDIcUsd0H5KUNdX5FHJ
	X5akNJ+qGJSvi9QUGAJeF9fnSyicvpYHqdJbq1ir30LstCWY9EMfoZM5uQ1VmN41ZZTuV2CLu25Gk
	PFaxU0Lab0MnDNMRwoLKO59chHc+gjHySOKPCot5QuJRSqC2ByChcdE7DHPrtxN8H359XtUz7z3m6
	qrbQwGoBRmPSwTW/qG258Dw3y0AcCHJAIbxL0g5ceQYHKi1wVH+lcVwTQ9ZJxqP2QIkKD3v/qw5XQ
	qLm+S6Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbru-0000000CJQZ-2MhP;
	Fri, 03 Jan 2025 07:13:14 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbrr-0000000CJQ8-221D
	for kexec@lists.infradead.org;
	Fri, 03 Jan 2025 07:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735888391; x=1767424391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q6EpZCsfYDi77uPvfLYPa4xIhDDdtR9yHwvrB9Fv5Ts=;
  b=ATmI4PngpSs40Zcw7X6BrAWDJOL34smyeHUL2q5VJpm2tccos+d9RZGf
   YiBBZ+EIZ+ORvAZSTP/i4qkr2Z/T1ZAg8G59VRnRlM1R26lfDpTEkI7uF
   RhmMz/9WAVsIZA5C2x6AiGMEdU1VhDpLaR47Z4RBOy7p0c62inJn+oVtr
   zPTk/ktcojnKHYP1QFkZkevu80P3ezAMAOtkR4iuon8F7OllfJiGGTZ6P
   aSdS589eXovn8CLnSB25QSv95xOFZtKTo/haxCMI2FLQFEIV8cVwdVgjR
   j31D/b43d/PhyrwAhKRzBgcqxgMA4qSjoFNKLCs2hEODxgMscKpZruw9S
   g==;
X-CSE-ConnectionGUID: qqvvFC1oTqaGbKxALQ+Yfw==
X-CSE-MsgGUID: tJWCoZtMRTSbgsl0Lsy8iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="39817259"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="39817259"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 23:13:10 -0800
X-CSE-ConnectionGUID: fD/XXd/qSkuIOzh6YzXNUg==
X-CSE-MsgGUID: kwP40DpjQlmb74PmXD1A6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="101798438"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by orviesa006.jf.intel.com with ESMTP; 02 Jan 2025 23:13:09 -0800
From: Zhiquan Li <zhiquan1.li@intel.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
Date: Fri,  3 Jan 2025 15:49:41 +0800
Message-Id: <20250103074941.3651765-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_231311_567127_656C1036 
X-CRM114-Status: UNSURE (   9.82  )
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
will be wasted in proportion.  In fact, as a special kind of free page
the unaccepted pages should be excluded, like the real free pages.

Export the page type PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo, so
that dump tool can identify whether a page is unaccepted.

Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
---
 kernel/vmcore_info.c | 4 ++++
 1 file changed, 4 insertions(+)

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

base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
-- 
2.25.1


