Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35EFC54E5C
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HnyIhQyOwBzsv2KARwECXPE8FFzebAHgpnJ7WoJqu/Q=; b=eHMRGgYGYFjTUj
	4ZT6OQilWOMuOFnvce1CmQdSqc+SKXZ+e01WBKjEgeaUafIUvYk3/RrBeCMW01Gcn9s5SA0Tfk7OB
	Dx2unYJ/dZCYYhaNnWloHvTdNN9f5x5qn2NvnClrhplVa0STTuc3PXN2F9dDVU+/mObRZZAd3YIOl
	7xe63vQh4DZB2NMZSEzDper+fb8iUktQJ2OLASgxHZd76l0WCxSJBjwDO3DO83q5y4bqzMCDCbKkT
	m3qABY1k0P7lcy0MRGrvfYrlcgkHxiZpqV/KCvuLIuhdwsgYjkfa6OKpVUfaJthJ6Bm782tYB85TR
	hu9ev6OAhZEJFzY+ft6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWd-0000000HPXk-0UQg;
	Wed, 06 Mar 2024 10:29:27 +0000
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWU-0000000HPPY-3SQU
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 10:29:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720958; x=1741256958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cfFr9yDzIDYGuhO0ed+4EUdT/tYXSwMTNGM6ftOGOr0=;
  b=mmQkTyy+SJypz3sBjWjc3FuNwWJc8ZVFuQBRj+Dh1lfqiPGcVQLWDk0W
   d8D481+hEMy8nteLQu44SOlvUT/1tkHVD72ukSSTjIE8ZI8BystDiShuN
   XLHWcdfY3f6e43d8Es773lj+0ep0rcYSek4qOHzVCQSnh/5E84UmPScFj
   MU5aJog+Ay/lzAd6uE1nDZmrCrfxHkjdThHKBH4UnUXvvNYKXzvR4Vlbn
   Ap/vXUg9jgIcv9+ldYuLR4Oe9nxlRkdD5C+rq9urUmoUXXSc0XMc1nbDd
   UZ2BaNu2qaxxz+Tq9nBuGLJC7nSC7UAS7XBOoiweroM+xponjxhU1DyZ4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="151690192"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="151690192"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:17 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8DAD312E239
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:13 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7D4CFFD9E6
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 199BB217374
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:12 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1E80D1A006D;
	Wed,  6 Mar 2024 18:29:11 +0800 (CST)
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
Subject: [PATCH v3 7/7] nvdimm: set force_raw=1 in kdump kernel
Date: Wed,  6 Mar 2024 18:28:46 +0800
Message-Id: <20240306102846.1020868-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10-2.938000-10.000000
X-TMASE-MatchedRID: MGSvkkc+rOj7w6uw5pqYnoOlbll4OMtk9LMB0hXFSeg6Zx3YUNQTG+Wh
	NKYuM7eN4QRvjxz49tHS7j6TEIEt1D3TQfUpAv1sPkILbTHNp5vYUDvAr2Y/17fYIuZsOQ0sOXB
	2cqV0mCIre4xpX839SBGJgBWjZYF4x7Pq8adLcfrum6Nvy6t3NlK6+0HOVoSowLkNMQzGl5B+Kr
	WCPbERP80Age9hS2jaRMoI0qlZNIJF28kU6TjvF869emDs42ddfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtqrM46JQnL8hECPUxiiiZOrOyZvt4D+xsOs3xt1PQttJyHuAILm2j36P9W6TbIoRbP/Sq
	eQCjGYXssHsZ3G5ixlOiTS2pFc4fpGuqGtYITgaGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/
	gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_022919_310542_B7D6AC70 
X-CRM114-Status: GOOD (  13.23  )
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
2. Disable libnvdimm driver by specific comline parameters:
   (initcall_blacklist=libnvdimm_init libnvdimm.blacklist=1 rd.driver.blacklist=libnvdimm)
3. Enforce force_raw=1 for nvdimm namespace, because when force_raw=1,
   metadata will not be re-constructed again. This may also result in
   the pmem doesn't work before a few extra configurations.

Here apply the 3rd option.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: nvdimm@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/nvdimm/namespace_devs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d6d558f94d6b..04f855c7f0b1 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/nd.h>
+#include <linux/crash_dump.h>
 #include "nd-core.h"
 #include "pmem.h"
 #include "pfn.h"
@@ -1513,6 +1514,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
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
