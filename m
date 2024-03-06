Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6F2C54E49
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r+mcYM4M/JYD/JjzByuZ5ugpcHkCzSW43iUiDhMEdmM=; b=WvYtFp8VNuLolH
	CME9KM944a51vX2Q5qVeZF0UCSuhbXuNi9c+Q0YVe9KQklKqMTP1JwoIMrI1bS4dlYvB3vZg+SUsm
	M443QBHPKGZXD42d+I4tqMODL9hvpAb0Z/z1M/WzNzGS23/89Feoz2pZbmxIa9fsJEQF7rw2A795t
	OpeoC7uophP0UWZwIwcKT/3hWjhASslK9BIqVmS+EKQ9e3Dwq/GqRa66lBiQIc0b9TTY7b7OtOKRX
	lISAcWeN4uVbf+JlOrzB7olckmox9f+Cmo/zpyOwPH0YxKt39m/1BeK5CEqMNGHrg1D5oVKnxcPYx
	UNEyyXgDyHMOHz0SRjkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWZ-0000000HPVd-2AJj;
	Wed, 06 Mar 2024 10:29:23 +0000
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWT-0000000HPPq-16d7
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 10:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720957; x=1741256957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPTXg1j60dmCKgrUxhmFd4z9be0Rjp54MJE3FLxdEQM=;
  b=jTAHaUAH9rnVNvN6bK/Ut5Y7JHrMwcGPNKWqQE+0TgcZ4OYVBSFlmyol
   wEVvtPBvcJLx1BXJiWmpPm3oJcie7dOgocYcY42W1fRtxAsvyNEL6EWIr
   2vdzfsMF6nuTD1FXOj2wf2TT31fxo3ZuSRERYjS/x1sxZG442fj84vPMD
   Rz9JNOXhcqUCjcWIx+jYFDCYAsYmDvwZAdU+zbRGiWCDm4s4GQJd0M2VB
   VXhD3A918Evhrwb2fkz6FEDzKiEUBwohf+UCkXeGTfFF8v9ZN81Tv/9Ha
   Rrp2mfYwUPcrEzPizNgIf0ZQB2GfdKvkURP6XECnRQynUJwIPmV9+qLWh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="153205389"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="153205389"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:13 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3F5DADD935
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7706ABF3CA
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id F1DC321735C
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 08E3D1A006A;
	Wed,  6 Mar 2024 18:29:06 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 2/7] mm: memremap: add pgmap_parent_resource() helper
Date: Wed,  6 Mar 2024 18:28:41 +0800
Message-Id: <20240306102846.1020868-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10-1.178600-10.000000
X-TMASE-MatchedRID: a4Q7dosAlP6Po+6vQMop+ikMR2LAnMRpCZa9cSpBObnAuQ0xDMaXkH4q
	tYI9sRE/7qN2AY1LBYfX/4cXJB77G82IoAvAG8Cytw+xHnsmQjMRKrbwgeEU4psoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNePDdA+sPJoJpIWVq2FPrVRC8PbPp9VJvAwE3szHrU0AtN2HcZBPqwdFSR
	N53IQttjRtl6ZG50f040PXgYNLw2sECcFYp/ZlI4xrU96OxkmsFcUQf3Yp/ridO0/GUi4gFb0fO
	PzpgdcEKeJ/HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_022917_757036_617F2A8C 
X-CRM114-Status: GOOD (  10.63  )
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

It's a helper to set the parent resource for the altmap of a given pgmap

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: linux-mm@kvack.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/linux/memremap.h | 1 +
 mm/memremap.c            | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index ca1f12353008..1e8b25352f7c 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -193,6 +193,7 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
 void zone_device_page_init(struct page *page);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
+void pgmap_parent_resource(struct dev_pagemap *pgmap, struct resource *res);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
diff --git a/mm/memremap.c b/mm/memremap.c
index 78047157b0ee..0bbf163d4817 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -390,6 +390,13 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 }
 EXPORT_SYMBOL_GPL(memremap_pages);
 
+void pgmap_parent_resource(struct dev_pagemap *pgmap, struct resource *res)
+{
+	if (pgmap && res)
+		pgmap->altmap.parent = res;
+}
+EXPORT_SYMBOL_GPL(pgmap_parent_resource);
+
 /**
  * devm_memremap_pages - remap and provide memmap backing for the given resource
  * @dev: hosting device for @res
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
