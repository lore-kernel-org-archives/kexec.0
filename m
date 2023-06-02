Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E405C7EE32
	for <kexec@archiver.kernel.org>; Fri,  2 Jun 2023 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRAmRScaJz+Q471RpYPnRH3Gcr/vPIT6EcFNk1kEgdM=; b=zw6Fmt1bsJkY/a
	p7W7Uz5CiDVdGyl7Pert1r9ZnwWo8yt4mosadaJu4pVkxj1byoG819TCIUwQ+ln9ycoe2Frj7hXol
	yN0FlGpOVsxLRFxX4blSt7T3mnbhW6hqQq5898OwfFREAaBOqqds3KrvS9RSDak+mvfIy++WDbdLk
	IiIO0c60RrXGTnQAEWi4A90SkHdQVjMec9b2M6iTvAu5BM4PYsTjWP2o1nXHEF9D7PY6pXCo4GMU/
	vB0/v7faXNIeLy8yoazJX5NT8pYEBNQdvVkWoXqoaar0pRc9RlkOR6YhHhWFUECyEx1AbAucdFI49
	Qf563dvuEcZtpzB/ylKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5207-006WL4-29;
	Fri, 02 Jun 2023 10:27:19 +0000
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5202-006WHQ-1h
	for kexec@lists.infradead.org;
	Fri, 02 Jun 2023 10:27:17 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="98600090"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="98600090"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:09 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E67A3D3EB2
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3CF60E647B
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1DB03E4AAF;
	Fri,  2 Jun 2023 19:27:04 +0900 (JST)
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
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v3 1/3] nvdimm: set force_raw=1 in kdump kernel
Date: Fri,  2 Jun 2023 18:26:50 +0800
Message-Id: <20230602102656.131654-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10-0.974000-10.000000
X-TMASE-MatchedRID: t1Iw0ML99//7w6uw5pqYnoOlbll4OMtk9LMB0hXFSeg6Zx3YUNQTG+Wh
	NKYuM7eN4QRvjxz49tHS7j6TEIEt1D3TQfUpAv1sPkILbTHNp5vYUDvAr2Y/17fYIuZsOQ0sOXB
	2cqV0mCIre4xpX839SFAz81vtOOYiZ4F2TwmYmEDum6Nvy6t3NlK6+0HOVoSoWAuSz3ewb22AI+
	pLfk3sByL637QCIVpi8vc3EUpCmrV9Y/vlKk76U9splnBzc8xMTFQnI+epPIaRo95rkBSGU6PFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrW2CLRXivi3wNhkKY/nNBRst5qYpMkBetMsgyaJj+IZ28rnl
	FWxtjwA8cpbtw5mTmssX0GOwKpO0i+7bNO++4Qw50ytg9FCbQRXBt/mUREyAj/ZFF9Wfm7hNy7p
	pG0IjcFQqk0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230602_032714_854533_92B20EE7 
X-CRM114-Status: GOOD (  11.65  )
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

The virtually mapped memory map allows storing struct page objects for
persistent memory devices in pre-allocated storage on those devices.
These 'struct page objects' on devices are also known as metadata.

During libnvdimm/nd_pmem are loading, the previous metadata will
be re-constructed to fit the current running kernel. For kdump purpose,
these metadata should not be touched until the dumping is done so that
the metadata is identical.

To achieve this, we have some options
1. Don't provide libnvdimm driver in kdump kernel rootfs/initramfs
2. Disable libnvdimm driver by specific comline parameters (
   initcall_blacklist=libnvdimm_init libnvdimm.blacklist=1 rd.driver.blacklist=libnvdimm)
3. Enforce force_raw=1 for nvdimm namespace, because when force_raw=1,
   metadata will not be re-constructed again. This may also result in
   the pmem doesn't work before a few extra configurations.

Here we choose the 3rd one because the kdump application in this RFC relies
on some /sys interfaces exported by libnvdimm and nd_pmem etc.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: nvdimm@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: new patch
---
 drivers/nvdimm/namespace_devs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index c60ec0b373c5..2e59be8b9c78 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/nd.h>
+#include <linux/crash_dump.h>
 #include "nd-core.h"
 #include "pmem.h"
 #include "pfn.h"
@@ -1504,6 +1505,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 			return ERR_PTR(-ENODEV);
 	}
 
+	if (is_kdump_kernel())
+		ndns->force_raw = true;
 	return ndns;
 }
 EXPORT_SYMBOL(nvdimm_namespace_common_probe);
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
