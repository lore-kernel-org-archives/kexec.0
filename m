Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B69CC7EE23
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zqjQ5yqVxPyqO4ttqbPGlOMhfYh+IsnUzOLc0luNAU8=; b=P3nnYa+oGJ5w8f
	YuHgsUMW1oaqkeCaCQyvlC4Y4t1cnly64B6Hg/YBz9y30Po8aIjWhDi/8NkstY3mDW7oxJTc0/hM2
	XPRjsIG6g4WlDSOvFPRbAQA5l2KgaqvJ2Cv/EHJtVasZj5Q+awTgihGcJOHiF98djbqZXGp125fH+
	TsClKwjmvVd47Dv+bPqEcq7aTkMRZWBFwSzcXvTWpo3zHPPSAzX3yi+Si53VUwmeJy/sVjCoi7Won
	wKCGUWiw/LbQpi2UBRhpWnSFJsTJafefR6rqmba9+nyvFUf7zMoqZZjjvcX2dlJCeTmVU8YK4dbRB
	zUpdbnp/Ixy6M5zKV+ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pryiJ-0069S9-2x;
	Thu, 27 Apr 2023 10:18:59 +0000
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pryiF-0069Ko-2k
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 10:18:57 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="114561783"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; 
   d="scan'208";a="114561783"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 19:18:51 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9FF60D3EBA
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:18:47 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E582BD969C
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:18:46 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
	by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id AE45F114626A;
	Thu, 27 Apr 2023 19:18:44 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: x86@kernel.org,
	nvdimm@lists.linux.dev,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	y-goto@fujitsu.com,
	yangx.jy@fujitsu.com,
	ruansy.fnst@fujitsu.com,
	Li Zhijian <lizhijian@fujitsu.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 2/3] drivers/nvdimm: export memmap of namespace to vmcoreinfo
Date: Thu, 27 Apr 2023 18:18:33 +0800
Message-Id: <20230427101838.12267-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427101838.12267-1-lizhijian@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27590.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27590.006
X-TMASE-Result: 10--5.296600-10.000000
X-TMASE-MatchedRID: mJ3yV3MWQwmUkDPUhpX2vh1kSRHxj+Z5A81piVnI+HU1SqhT+J6xsUbg
	XczvLJKOjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRfiKzBf4Yf9iOVGny5q72hp4Q+L3BXIWuyL5
	QmWOgMfBI7ocMJBgR6/WV3EhAhFD6Sry0z8DqbhLNgrlT5Ajc7n0tCKdnhB589yM15V5aWpj6C0
	ePs7A07Xi4XEoPXecxVvpTJmXb4dua6fR6Q+5OxeYzpCWDqqUZ3tGV3hp+Y+4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_031856_164735_CDDC403C 
X-CRM114-Status: UNSURE (   9.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Each namespace has its own memmap, it will be udpated when
namespace initializing/creating, updating, and deleting.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/nvdimm/namespace_devs.c | 2 ++
 drivers/nvdimm/pfn_devs.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index c60ec0b373c5..096203e6203f 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/nd.h>
+#include <linux/crash_core.h>
 #include "nd-core.h"
 #include "pmem.h"
 #include "pfn.h"
@@ -853,6 +854,7 @@ static ssize_t size_store(struct device *dev,
 	if (rc == 0 && val == 0 && is_namespace_pmem(dev)) {
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
+		devm_memmap_vmcore_delete(to_ndns(dev));
 		kfree(nspm->uuid);
 		nspm->uuid = NULL;
 	}
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index af7d9301520c..80076996b2da 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/crash_core.h>
 #include "nd-core.h"
 #include "pfn.h"
 #include "nd.h"
@@ -716,6 +717,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 	} else
 		return -ENXIO;
 
+	devm_memmap_vmcore_update(ndns, altmap->base_pfn, PHYS_PFN(offset),
+				  nd_pfn->mode == PFN_MODE_PMEM);
 	return 0;
 }
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
