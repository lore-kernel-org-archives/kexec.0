Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F2EC7EE37
	for <kexec@archiver.kernel.org>; Fri,  2 Jun 2023 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aQ755G0yeh+fNniJdrxFLxGqqNfNN6K7oVUclEtE4uw=; b=oPuUu49KaLBGlk
	eYZdj+2zRYpcm3OeLh1xWA8BeP3Hd+L3yK6iDDELqcvhxuSW4qEvawus/PWX2744OmIuEIUQyuGB2
	6Oi4WVqR3Oae+5N8mk3tSSY4C0zFF50ZQP06CIzYVWZGG834SpRsB+bQR+9u5jMy122VgM7iAomd0
	wHO+zV2wAtCUqLDCoDWJxVQzTQ3CwQVnWZKH5/lfxuvEUmAXsyO/wy1Y2dT2YXkF/Apkz2WDMTp93
	laUD+r6PyMoXbBJWXq97U8Xbg938k1PMufOCJFReZ5D80kei0Y2ZGk3TdR774UbiLZB0z/+c6llV0
	LQ6Kni+MRqFmHmRWJEVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5209-006WMd-0A;
	Fri, 02 Jun 2023 10:27:21 +0000
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5203-006WHv-0z
	for kexec@lists.infradead.org;
	Fri, 02 Jun 2023 10:27:18 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="107288428"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="107288428"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:10 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 332FDD3EB7
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:07 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7DD14C4A15
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A65F4E4AA6;
	Fri,  2 Jun 2023 19:27:05 +0900 (JST)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [RFC PATCH v3 3/3] kernel/kexec_file: Mark pmem region with new flag PF_DEV
Date: Fri,  2 Jun 2023 18:26:52 +0800
Message-Id: <20230602102656.131654-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--6.493600-10.000000
X-TMASE-MatchedRID: 9KRLfRi0EIdXk4HjwySOxx1kSRHxj+Z5W+HVwTKSJIbfghYDxv+lXYyt
	cTfY0Fk5Fcbst+g5Co4SHwgOjzzIf6GGOyqBK41vEXjPIvKd74BMkOX0UoduubgbJOZ434BsXMi
	+6Pt1uebPz9CYF+mMT7BRAkACNnr7lwV2iaAfSWcURSScn+QSXhhJCIHRlO51+gtHj7OwNO0kL2
	NLniq3NW48jxF4hJknuYLQT0SIw8Y4aBTofN3FK6vjRgCarhn/
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230602_032715_608502_BADBAD3F 
X-CRM114-Status: GOOD (  10.32  )
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

For pmem, metadata is specific to the namespace rather than the entire
pmem region. Therefore, ranges that have not yet created a namespace or
are unusable due to alignment reasons will not be associated with metadata.

When an application attempts to access regions that do not have
corresponding metadata, it will encounter an access error. With this flag,
the dumping applications are able to know this access error, and then
take special actions correspondingly.

This is kexec_file_load() specific, for the traditional kexec_load(),
kexec-tools will have a similar change.

CC: Eric Biederman <ebiederm@xmission.com>
CC: Baoquan He <bhe@redhat.com>
CC: kexec@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 kernel/kexec_file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..0d5b516b96ee 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,6 +29,8 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#define PF_DEV (1 << 4)
+
 #ifdef CONFIG_KEXEC_SIG
 static bool sig_enforce = IS_ENABLED(CONFIG_KEXEC_SIG_FORCE);
 
@@ -1221,6 +1223,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
+static bool is_pmem_range(u64 start, u64 size)
+{
+	return REGION_INTERSECTS == region_intersects(start, size,
+			IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY);
+}
+
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
@@ -1302,6 +1310,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 
 		phdr->p_type = PT_LOAD;
 		phdr->p_flags = PF_R|PF_W|PF_X;
+		if (is_pmem_range(mstart, mend - mstart))
+			phdr->p_flags |= PF_DEV;
 		phdr->p_offset  = mstart;
 
 		phdr->p_paddr = mstart;
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
