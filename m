Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D5DC54E41
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8oeE/FoKqVTBUbPwbgP8DYVyw0B/3aiDstnkFoEkSjY=; b=vYYyMMA5JIpZHM
	9FEX9L9o2s1K5WWptA78MMerOwCAmQQTZPB2jDvDzMHUo2v3ozHtd+moDfbi2sqBQHNDZfiv+Ku/b
	MP1cM3Atdej8pxyyT5Ya3hQkg/07S6VlAYthYAWZAxVQbWv0gGXu/ZXlefMmFyjkViUrIHv8V/WHF
	W5mgULlnIcvkwWcxAo+L0RZcjhvLL4Nyxcc6DIrYvI7ecRUyhssGZLjQcGY5ILTTfwtC25FMCVXle
	scrF/mhhIcZkHvwidr+C7Lqfjcm07uprVMMBqNGvGxdWaXxMrwIW/UEY9JfvNV/NW2KbdYjIeMP87
	rhfph7bYg/5+vfUk+Vcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWf-0000000HPZI-1Ko0;
	Wed, 06 Mar 2024 10:29:29 +0000
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWX-0000000HPQE-1Rps
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 10:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720961; x=1741256961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8m938ej88oP8CU4LRmFGqeZ2eI8zznrXHFjHuzUAi80=;
  b=Ep1js1K3kjpEhlFO0FepmwwW2Y7zZXh4P+Ej147zfkQgzxl3+CWcUSO8
   T2hZ8QvrYRoIPmzGGmyay+vIrJrkAb/gdXZz8UOOAoJXtB/R5C+4FAcaV
   cjmmpJ25uOkT9A5XhVwS4WDBoTiB5WcD/+kFvJjNdutuxWYnH1meQHCQ0
   yMyqP/egkMFm732rCQ2zM+kpzCeGeIaroiSmfR+nAgN1r6wHu/lDf3Thv
   U+aPb7QpAsjgp5qA1NrJGmyQn8uDLpWS7Zxrf5HNoZ+MjYND1iC0aLEWy
   XbonafNwEtd4ikvjAezThn2kM+W+nHprnlwgJyP6zyEEpPpQQMBw0/cKg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="139869809"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="139869809"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:15 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1CCE9DD92F
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4BA70D561F
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C4DCE2030C7E0
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D32BA1A006D;
	Wed,  6 Mar 2024 18:29:07 +0800 (CST)
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
Subject: [PATCH v3 3/7] nvdimm: pmem: assign a parent resource for vmemmap region for the fsdax
Date: Wed,  6 Mar 2024 18:28:42 +0800
Message-Id: <20240306102846.1020868-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--1.564400-10.000000
X-TMASE-MatchedRID: BlFNdihulaZXk4HjwySOxykMR2LAnMRpFInyGi5rPwK4GyTmeN+AbL8F
	Hrw7frluf146W0iUu2tDc4lSgrowpWptPhjDCRug9k5nZzZVBSBULRRq00o2mZsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNU8XOMKR+RhSziRYTTEaxycNH0kK2Y6lBnFLca4Td9YkovbRRC+8RtSqnf
	dPSmIOZvdj0cn+WGO3HBgXAGNBpen5KWrl6H4maf8jyjqYHnMRFcUQf3Yp/ridO0/GUi4gFb0fO
	PzpgdcEKeJ/HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_022921_999149_7D1A6366 
X-CRM114-Status: GOOD (  12.47  )
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

When the pmem is configured as fsdax, set the vmemmap region as a child
of the namespace region so that it can be registered as a separate
resource later.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: nvdimm@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/nvdimm/pmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4e8fdcb3f1c8..b2640a3fb693 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -452,7 +452,7 @@ static int pmem_attach_disk(struct device *dev,
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	int nid = dev_to_node(dev), fua;
-	struct resource *res = &nsio->res;
+	struct resource *res = &nsio->res, *parent;
 	struct range bb_range;
 	struct nd_pfn *nd_pfn = NULL;
 	struct dax_device *dax_dev;
@@ -491,12 +491,15 @@ static int pmem_attach_disk(struct device *dev,
 		fua = 0;
 	}
 
-	if (!devm_request_mem_region(dev, res->start, resource_size(res),
-				dev_name(&ndns->dev))) {
+	parent = devm_request_mem_region(dev, res->start, resource_size(res),
+				dev_name(&ndns->dev));
+	if (!res) {
 		dev_warn(dev, "could not reserve region %pR\n", res);
 		return -EBUSY;
 	}
 
+	pgmap_parent_resource(&pmem->pgmap, parent);
+
 	disk = blk_alloc_disk(nid);
 	if (!disk)
 		return -ENOMEM;
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
