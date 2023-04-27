Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679C1C77B7C
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H8QKBPVyDA1IKWuMB7j8tKpK0+/KbnFjiV8i7VqVyp8=; b=nc7ty3VJDDPj38
	Qu9ZjBlfFbT8LZH7kPlA/qLoqDedg3U/HsorIKk34nft+m8OJBAcpgSyh5mQdQjoAxktnY9fYMtrK
	LPwRs4w75cJomYERHKpN+XendM164rQJCoNy448CvWUJ9oJvyCSCxeYd0amveeyc9jQS5HPLGPruz
	fsS7i99kWmGSi+RiVaWSzzZRnCYHuWq1AbJaGJxdzk+XXUZfhxGERF9Gn/SLDfS+n6hHexeRavJ9S
	ERJtrxyAZqtDQzzwNP+sgNLmHJB1HRH48DXhW4qqvcgfVLaYNfXV6HobhNo7du9eCEWBmvHoZgSbT
	tKEnW+xXYGwuu/E1gjeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pryiR-0069ao-1u;
	Thu, 27 Apr 2023 10:19:07 +0000
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pryiO-0069TJ-0w
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 10:19:06 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="116123172"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; 
   d="scan'208";a="116123172"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 19:18:59 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9ACE1EDEA6
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:18:56 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BD39ED8C0E
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:18:55 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
	by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id EC5511146B81;
	Thu, 27 Apr 2023 19:18:53 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: x86@kernel.org,
	nvdimm@lists.linux.dev,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	y-goto@fujitsu.com,
	yangx.jy@fujitsu.com,
	ruansy.fnst@fujitsu.com,
	Li Zhijian <lizhijian@fujitsu.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH v2 makedumpfile 2/3] makedumpfile.c: Exclude all pmem pages
Date: Thu, 27 Apr 2023 18:18:37 +0800
Message-Id: <20230427101838.12267-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427101838.12267-1-lizhijian@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27590.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27590.006
X-TMASE-Result: 10--5.941800-10.000000
X-TMASE-MatchedRID: cV8N6dznfzuBgK4uB6zi2wI0yP/uoH+DwTlc9CcHMZerwqxtE531VIPc
	XuILVCbaWUOTJnYsQa2lRWSx/oj7ExHdGMlurS250e7jfBjhB8f0swHSFcVJ6NWO4MK8ycTFg4T
	d/DBNkVPuCkRfzEi2wgclwOc+5StklXlA6F65Sc32TS1YFaI5/xZSD+Gbjz3IqgHTw5IkXxgJfh
	8gHD4nu42rc3rXpVKc4QeSIpZv9OkfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPDcGMULvOV2rQ7tl
	vwzkBcKWTZ/RLlgCAbttAMkwZFFNAg1EEshzuUS
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_031904_605282_AC674482 
X-CRM114-Status: GOOD (  11.26  )
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

Generally, the pmem is too large to suitable to be dumped. Further, only
the namespace of the pmem is dumpable, but actually currently we have no
idea the excatly layout of the namespace in pmem.

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 makedumpfile.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index f40368364cf3..98c3b8c7ced9 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -100,6 +100,7 @@ mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
+mdf_pfn_t pfn_pmem_userdata;
 mdf_pfn_t pfn_elf_excluded;
 
 mdf_pfn_t num_dumped;
@@ -6326,6 +6327,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned int order_offset, dtor_offset;
 	unsigned long flags, mapping, private = 0;
 	unsigned long compound_dtor, compound_head = 0;
+	unsigned int is_pmem;
 
 	/*
 	 * If a multi-page exclusion is pending, do it first
@@ -6377,6 +6379,13 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 				continue;
 		}
 
+		is_pmem = is_pmem_pt_load_range(pfn << PAGESHIFT(), (pfn + 1) << PAGESHIFT());
+		if (is_pmem) {
+			pfn_pmem_userdata++;
+			clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle);
+			continue;
+		}
+
 		index_pg = pfn % PGMM_CACHED;
 		pcache  = page_cache + (index_pg * SIZE(page));
 
@@ -8084,7 +8093,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9422,7 +9431,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10370,7 +10379,7 @@ print_report(void)
 	 */
 	pfn_original = info->max_mapnr - pfn_memhole;
 
-	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
+	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
 	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
 
 	REPORT_MSG("\n");
@@ -10387,6 +10396,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    pmem userdata pages     : 0x%016llx\n", pfn_pmem_userdata);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
@@ -10426,7 +10436,7 @@ print_mem_usage(void)
 	*/
 	pfn_original = info->max_mapnr - pfn_memhole;
 
-	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
+	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
 	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
