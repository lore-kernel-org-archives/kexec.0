Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F33C61DB2
	for <kexec@archiver.kernel.org>; Mon,  9 Jun 2025 04:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I4Vo4iybnvfMaAkzaX/UdTZO4VmKfQVchj84k7wiKjY=; b=Wj8EkP0a5rBUsg47mHsUpLQb4B
	ZUqrCofpGlhXR1d7j2nZ8e7tJWzdeFhnx+wvg9y0vpRPaT9hrivj5rWZaj3uhfO+9o1TZ1lijBOGX
	33pD75YFQDfbkEBgKKavWY1JG1UdS+Lpdxy1frq73URPKVdyqD3PiZQ5xbvfAl5ysE+SS1JVwCkWY
	egMWzM6VOGyKMXtG0j3vOXfJq0B3RqESTTEubfGk02EeqWIQEppRlzGY9VcOIqRn7Rn6WlmpcCd7m
	j0QSeG/Q4tdm2oXNOIc6TR90iA7xcLQCDSlvgEInA2lzHYl8aTuDuTM6gp30z9gnip0iWYlbcsVzb
	lrXGAttw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOTzg-00000003O8r-2bsu;
	Mon, 09 Jun 2025 04:20:20 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOTza-00000003O8V-014Z
	for kexec@lists.infradead.org;
	Mon, 09 Jun 2025 04:20:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749442814; x=1780978814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9etLQEtLvngVePGd4svI5aAp9rLIJDc4CcO8A0XNlNM=;
  b=V5H6HwJ8dJAOHvwXvgJTU2u2+MP3TXDcaQ9Kkun35/AnJ5fh3OjgnXdN
   93n1mLsabwD6gMYQsDBHSHKAytZe+2O7Z+mMmP+l0WclYTu1+aiGJj+uC
   zyQh41L9UNHjQyVS+pILQ2zTUYL5oVXgHYgKPVL8hk31v8qIgWhYBfLyK
   lbzYR/McT1petn5BfviUDK6F9uQbAXQRfiQc3dyA86lXHZc5OT1Hz/jwW
   eMXkD2zezjaal2OvBsU2oWo7izzS7pFU5u1BVlxFmFe7j2RLogP4qSQYv
   xiXto4HNs0PVRmsXYVYbx0/+UA/SjKIbEVFYCRFonk54SuBYcCpJ2I82A
   Q==;
X-CSE-ConnectionGUID: jmqwqj60SwK0Jt3g2EQYCg==
X-CSE-MsgGUID: 77YUqVd9RmyF//xDjBrf+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51387040"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="51387040"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 21:20:10 -0700
X-CSE-ConnectionGUID: wyCXIO0kTz+hbSUq8JjBZw==
X-CSE-MsgGUID: 99D2/iXtTl+PnXnJC6fdlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="151273577"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jun 2025 21:20:08 -0700
From: Zhiquan Li <zhiquan1.li@intel.com>
To: kexec@lists.infradead.org,
	k-hagio-ab@nec.com,
	yamazaki-msmt@nec.com
Cc: zhiquan1.li@intel.com
Subject: [PATCH makedumpfile] Add confidential VM unaccepted free pages support on Linux 6.16 and later
Date: Mon,  9 Jun 2025 13:02:44 +0800
Message-Id: <20250609050244.837619-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250608_212014_118677_1EE642DE 
X-CRM114-Status: GOOD (  17.92  )
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

UEFI Specification version 2.9 introduces the concept of memory
acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, requiring memory to be accepted before it can be used by the
guest.  Accepting happens via a protocol specific for the Virtual
Machine platform[1].

Before unaccepted memory is accepted by guest, any access from guest
will result in the guest failed, as well as the kexec'ed kernel.  So,
the kexec'ed kernel will skip these pages and fill in zero data for the
reader of vmcore.

However, it introduces a problem.  When exclude a page filled with zero,
a pd_zero, which sizeof(page_desc_t) is 24 bytes, will be written into
cd_header and this part is not compressed by design.  As the unaccepted
pages are exported as zero pages, which means ~1/170 of the capacity of
unaccepted memory will be added into vmcore additionally.  In fact, they
should be considered as free pages and most of the time should be
excluded.

Unaccepted memory is unusable free memory, so they are not managed by
buddy, instead, they are added to a new list zone.unaccepted_pages only
when the order is MAX_PAGE_ORDER each time conventionally.  The new
page type, PGTY_unaccepted can be used to identify whether a page is
unaccepted[2].  Therefore, add following changes to exclude them like
free pages:

1. Add NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) to identify a page is
   unaccepted, a kernel patch[3] to export the value of page type
   PAGE_UNACCEPTED_MAPCOUNT_VALUE since kernel 6.16.

2. Add a condition to exclude these unaccepted free pages.

Dumping host kernel will not be impacted by the modification, because it
cannot enable CONFIG_UNACCEPTED_MEMORY, so the page type
PAGE_UNACCEPTED_MAPCOUNT_VALUE cannot be found in vmcoreinfo and skip
the step.

Here is a vmcore size statistic of a freshly booted TD VM with different
memory sizes:

  VM.mem | Before  After
  -------+----------------
  512G   | ~4.9G   ~2.0G
  256G   | ~2.0G   ~1.1G

[1] https://lore.kernel.org/all/20230606142637.5171-1-kirill.shutemov@linux.intel.com/
[2] https://lore.kernel.org/all/20240809114854.3745464-5-kirill.shutemov@linux.intel.com/
[3] https://lore.kernel.org/all/20250405060610.860465-1-zhiquan1.li@intel.com/

Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
---
 makedumpfile.c | 14 ++++++++++++++
 makedumpfile.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 2d3b08bb5d52..97ec2f06108b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2533,6 +2533,8 @@ write_vmcoreinfo_data(void)
 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	WRITE_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE",
 		     PAGE_OFFLINE_MAPCOUNT_VALUE);
+	WRITE_NUMBER("PAGE_UNACCEPTED_MAPCOUNT_VALUE",
+			PAGE_UNACCEPTED_MAPCOUNT_VALUE);
 	WRITE_NUMBER("phys_base", phys_base);
 	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
 
@@ -2990,6 +2992,7 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PAGE_HUGETLB_MAPCOUNT_VALUE", PAGE_HUGETLB_MAPCOUNT_VALUE);
 	READ_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE", PAGE_OFFLINE_MAPCOUNT_VALUE);
 	READ_NUMBER("PAGE_SLAB_MAPCOUNT_VALUE", PAGE_SLAB_MAPCOUNT_VALUE);
+	READ_NUMBER("PAGE_UNACCEPTED_MAPCOUNT_VALUE", PAGE_UNACCEPTED_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
 
@@ -6630,6 +6633,17 @@ check_order:
 			nr_pages = 1 << private;
 			pfn_counter = &pfn_free;
 		}
+		/*
+		 * Exclude the unaccepted free pages not managed by buddy.
+		 * By convention, pages can be added to the zone.unaccepted_pages list
+		 * only when the order is MAX_ORDER_NR_PAGES.  Otherwise, the page is
+		 * accepted immediately without being on the list.
+		 */
+		else if ((info->dump_level & DL_EXCLUDE_FREE)
+			&& isUnaccepted(_mapcount)) {
+			nr_pages = 1 << (ARRAY_LENGTH(zone.free_area) - 1);
+			pfn_counter = &pfn_free;
+		}
 		/*
 		 * Exclude the non-private cache page.
 		 */
diff --git a/makedumpfile.h b/makedumpfile.h
index 944397a6f865..26940e7a3f81 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -163,6 +163,8 @@ test_bit(int nr, unsigned long addr)
 				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
 #define isAnon(mapping, flags, _mapcount) \
 	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags, _mapcount))
+#define isUnaccepted(_mapcount)	(_mapcount == (int)NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) \
+				&& (NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER))
 
 #define PTOB(X)			(((unsigned long long)(X)) << PAGESHIFT())
 #define BTOP(X)			(((unsigned long long)(X)) >> PAGESHIFT())
@@ -2257,6 +2259,7 @@ struct number_table {
 	long	PAGE_HUGETLB_MAPCOUNT_VALUE;
 	long	PAGE_OFFLINE_MAPCOUNT_VALUE;
 	long	PAGE_SLAB_MAPCOUNT_VALUE;
+	long	PAGE_UNACCEPTED_MAPCOUNT_VALUE;
 	long	SECTION_SIZE_BITS;
 	long	MAX_PHYSMEM_BITS;
 	long    HUGETLB_PAGE_DTOR;
-- 
2.25.1


