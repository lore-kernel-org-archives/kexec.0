Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F496C54E41
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KCzi/v1wTBdLrVoWogYUxwR6oggUDFwbT/sRBYEzlc8=; b=JleKVFVUAmXB+h
	26jKcOqxSgKu+ZLLS6ta1CCGOP8t3WijVm4utJ4FQfhIKFNMgTpvN3qP5L0cKABIOD3P4tgYvXMnS
	bmphcaEGlNFrZlIPFqK89H6hZz6smR5mERhBsh4L4Ig0v35S3YzqWBTBE+q8JOYNgMcMBTpRjnvw6
	oIpOYOCa3Eq17loM1hDU9MCYXL7P/lP8baCUJ6KSpxv+L/YSgcm2XXcafczaQknTM8C6FeX5pUunV
	h2XkJJF1MpAb9F3Xw8GkiII3B+GuLK76aMgTwcI0S4Gh0TfnzSY3RmvYNFN6/D94ECtUP7DDRLxJz
	yqRTSmoMKFvXVHwd5MBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWc-0000000HPXQ-0UjK;
	Wed, 06 Mar 2024 10:29:26 +0000
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWU-0000000HPQE-1wjy
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 10:29:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720958; x=1741256958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZY/OmJnWGlv4sXJ9ctR7zLIBkL6jlFxWOynKDfrnCI=;
  b=MaUFz+V3byT/1nyW6ZeLDezOvUsaQ+MgKwr8fbEsbKcWIGWKxqAzIrbi
   Ee0zhbMzqiqef9EUEm5iF87mWCdAIXjfwJGqphHNTq2twogn8QP6gQdYa
   ClCGcEJ/9r2nIYKXH89l1NnQpRzEgahkX9xXzN/+tE0i4HN+Q8m6JM4L5
   GgZ9s+vWaL2LgirVTP3fO/qWmpZ6MHFfAl5um2oQTp56kCWlhQKAQpHUI
   9ln5ncHCzItTl21z7EPbDPYjPvqmvamMkBe52G7cXEOFNxBXjNDVw5p29
   2L5I5bj74r3A3bkRt4rN+TF0TmmCkTrQWJf/Q41qvW81I6SPzqLmTSDqM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="139869806"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="139869806"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:14 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DCB9212E242
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1F499BF3CA
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 96EE620097BE1
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A5E001A006A;
	Wed,  6 Mar 2024 18:29:08 +0800 (CST)
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
Subject: [PATCH v3 4/7] dax: pmem: assign a parent resource for vmemmap region for the devdax
Date: Wed,  6 Mar 2024 18:28:43 +0800
Message-Id: <20240306102846.1020868-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--5.083400-10.000000
X-TMASE-MatchedRID: Q3OJUoK6MKVXk4HjwySOxykMR2LAnMRpFInyGi5rPwK4GyTmeN+AbD13
	GoPFA1HFIvrftAIhWmLy9zcRSkKatS9AD6DbcToHEVuC0eNRYvKZIt4iAQN6P6oDeu6wu7bqj26
	lKB/EzKHoHOpl9ZcDR4Ay6p60ZV62fJ5/bZ6npdg7AFczfjr/7Cf8pL7Z+mamZiZ008tHBX0M7U
	m3uTFNcAFzvFI3lI92rZlDJo+ExYU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_022918_998423_C03729F1 
X-CRM114-Status: GOOD (  12.57  )
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

When the pmem is configured as devdax, set the vmemmap region as a child
of the namespace region so that it can be registered as a separate
resource later.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: nvdimm@lists.linux.dev
CC: linux-cxl@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/dax/pmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index f3c6c67b8412..6ffeb81e6c7c 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -21,6 +21,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	struct nd_dax *nd_dax = to_nd_dax(dev);
 	struct nd_pfn *nd_pfn = &nd_dax->nd_pfn;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
+	struct resource *parent;
 
 	ndns = nvdimm_namespace_common_probe(dev);
 	if (IS_ERR(ndns))
@@ -39,8 +40,9 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	pfn_sb = nd_pfn->pfn_sb;
 	offset = le64_to_cpu(pfn_sb->dataoff);
 	nsio = to_nd_namespace_io(&ndns->dev);
-	if (!devm_request_mem_region(dev, nsio->res.start, offset,
-				dev_name(&ndns->dev))) {
+	parent = devm_request_mem_region(dev, nsio->res.start, offset,
+				dev_name(&ndns->dev));
+	if (!parent) {
 		dev_warn(dev, "could not reserve metadata\n");
 		return ERR_PTR(-EBUSY);
 	}
@@ -66,6 +68,8 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.memmap_on_memory = false,
 	};
 
+	pgmap_parent_resource(&pgmap, parent);
+
 	return devm_create_dev_dax(&data);
 }
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
