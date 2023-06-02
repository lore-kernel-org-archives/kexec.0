Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA98C7EE2C
	for <kexec@archiver.kernel.org>; Fri,  2 Jun 2023 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dnr/umq+0guAZZIxELb78yqCZgcIwxtgHAYWvqHx6mU=; b=JFUiqkL4mGM4zj
	Gh1r5Aj+qykl4DpREDF8dk2Bm01Q24uLeb8gF8ejDOrzdAOzDH9tJiwRcGabZV3M84VUWjtmfy3FU
	IR2tS/0FkjcgY0gDBR3y6AxtxXZJ9SDfiYzdfSdKhzIi+9sGT1R1iaeMl9JyhZZAYvvcaiif01XF+
	rns/HpXk9yxOr18U/NUNOOMoRKwTcCrJHQVTQlD0E6my5b/elpWfAFfO02wKiRI6f+4VCkFqXB6Au
	sKWSx22r7fJ1H4f0T11va6QEKtAs9bkJ+SYOxMYcFbwHaim2jeKMXY1OGu8HtWLZ6+9sakMmlbHhw
	bACpWcMLURl1zYjNAwkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5209-006WMs-1l;
	Fri, 02 Jun 2023 10:27:21 +0000
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5203-006WIJ-2P
	for kexec@lists.infradead.org;
	Fri, 02 Jun 2023 10:27:18 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="119220283"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="119220283"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:12 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F403D4256
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BE67EBF3D4
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CC25FE4ABD;
	Fri,  2 Jun 2023 19:27:07 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: kexec@lists.infradead.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	bhe@redhat.com,
	ruansy.fnst@fujitsu.com,
	y-goto@fujitsu.com,
	yangx.jy@fujitsu.com,
	Li Zhijian <lizhijian@fujitsu.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH makedumpfile v3 2/3] makedumpfile.c: Exclude all pmem pages
Date: Fri,  2 Jun 2023 18:26:55 +0800
Message-Id: <20230602102656.131654-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--6.321800-10.000000
X-TMASE-MatchedRID: CCHfsHgEWa2BgK4uB6zi2wI0yP/uoH+D2+EDPw+8xrdJEjJjpEhCnwFV
	KntB9/BKIvrftAIhWmLy9zcRSkKatUAhvNB5B6uKzfqlpbtmcWgAPNCUrAcH+yS30GKAkBxW58T
	g0a5Ro0fiJKINn1ydSUNghIQqhUBNP7A6mmzUskCp3Btb1bH20NY3ddD/vCxPkHPVkBTu31P8bd
	qAerXT9wzx9NgblERANGy+MoqzZ01DQYe+1GQPNbrbxxduc6FPfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtH/zyL+gBqiwKmTdg1dVt31KQTaEXmx8EEvFiRzb4CfQizqc5rHUqnQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230602_032716_071011_869C0712 
X-CRM114-Status: GOOD (  11.85  )
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
idea the excatly layout of the namespace in pmem. So we exclude all of
them temporarily. And later, we will try to support including/excluding
metadata by specific parameter.

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: kexec@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 makedumpfile.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index cadc59662bef..f304f752b0ec 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -100,6 +100,7 @@ mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
+mdf_pfn_t pfn_pmem_userdata;
 mdf_pfn_t pfn_elf_excluded;
 
 mdf_pfn_t num_dumped;
@@ -6389,6 +6390,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned int order_offset, dtor_offset;
 	unsigned long flags, mapping, private = 0;
 	unsigned long compound_dtor, compound_head = 0;
+	unsigned int is_pmem;
 
 	/*
 	 * If a multi-page exclusion is pending, do it first
@@ -6443,6 +6445,13 @@ __exclude_unnecessary_pages(unsigned long mem_map,
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
 
@@ -8122,7 +8131,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9460,7 +9469,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10408,7 +10417,7 @@ print_report(void)
 	 */
 	pfn_original = info->max_mapnr - pfn_memhole;
 
-	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
+	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
 	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
 
 	REPORT_MSG("\n");
@@ -10425,6 +10434,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    pmem userdata pages     : 0x%016llx\n", pfn_pmem_userdata);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
@@ -10464,7 +10474,7 @@ print_mem_usage(void)
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
