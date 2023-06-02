Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7055BC7EE39
	for <kexec@archiver.kernel.org>; Fri,  2 Jun 2023 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZNFaJ3TualYzvqwT/p8ucg2zcgXPLzs4im7CI/jmYeM=; b=Vj/4iCKaqroFTC
	+eCxOSsuto1VUYQ2gqxjEf5bimgeyHM6q5D601w7QXOjKB669dxnnR3+HOewDeVDp9CQLEaRsyoNL
	lU4zvRrsnkJf2zNYH/VRR5uhCS8FreyDlwDnMrvA6fpU9bDKw7Rc65Bb4Ld/31vCsVgSnPE/EWI9a
	Ls3/C6iOF3yJjwV3ocOL2371HjzqSHCZGYYLU1e1nLEHS5ce7aXiK914eQDYYnyRHtGh81BenC5TV
	RO5rQBvWplU+7jAY+oeYj7QWXHg+DXKskUM7+q/M7IbzxO8llSWyYfOjUqEw54CxlAudf7If/Inud
	Zqj0un5E/RIge7y551Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q520B-006WNu-1S;
	Fri, 02 Jun 2023 10:27:23 +0000
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5204-006WIA-0B
	for kexec@lists.infradead.org;
	Fri, 02 Jun 2023 10:27:20 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="98690280"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="98690280"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:10 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E4A3DDC60
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:08 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 381CDD88D0
	for <kexec@lists.infradead.org>; Fri,  2 Jun 2023 19:27:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 43003E4AAF;
	Fri,  2 Jun 2023 19:27:06 +0900 (JST)
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
Subject: [RFC PATCH kexec-tools v3 1/1] kexec: Add and mark pmem region into PT_LOADs
Date: Fri,  2 Jun 2023 18:26:53 +0800
Message-Id: <20230602102656.131654-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--7.038100-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2tSuJfEWZSQfA0QY5VnQyANm0H2L3kjQgpOmq2IYpeEBtfG
	u/3wXym7PHFWBoH6D4ycFX6mBx5z38fdkIlEiI2kRcGHEV0WBxCycrvYxo9Kp742hLbi424DvwU
	evDt+uW5/XjpbSJS7a86BcTqviA1zfbpIB/11M574Zi3x/9WFO9DEMPvvoocvo/gdx29vvKfIU7
	MLOn2QZlafBRDsN6GPgFK2nmPCAnkfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPC2A5+imUXo05G7e
	yF+PNMDxJCK7NkLnfyBYhxJ1cjIzsdLFNEgDIsW
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230602_032716_364007_BB9522A4 
X-CRM114-Status: GOOD (  13.77  )
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

It does:
1. Add pmem region into PT_LOADs of vmcore so that pmem region is
   dumpable
Only the region described by PT_LOADs of /proc/vmcore are dumpable/readble
by dumping applications. Previously, on x86/x86_64 only system ram resources
will be injected into PT_LOADs.
So in order to make the entire pmem resource is dumpable/readable, we need
to add pmem region into the PT_LOADs of /proc/vmcore.

2. Mark pmem region's p_flags as PF_DEV so that we are able to ignore
   the specific pages
For pmem, metadata is specific to the namespace rather than the entire
pmem region. Therefore, ranges that have not yet created a namespace or
are unusable due to alignment reasons will not be associated with metadata.

When an application attempts to access regions that do not have
corresponding metadata, it will encounter an access error. With this flag,
the dumping applications are able to know this access error, and then
take special actions correspondingly.

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: kexec@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 kexec/crashdump-elf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index b8bb686a17ca..ab257e825187 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -25,6 +25,8 @@ do {									\
 } while(0)
 #endif
 
+#define PF_DEV (1 << 4)
+
 /* Prepares the crash memory headers and stores in supplied buffer. */
 int FUNC(struct kexec_info *info,
 	 struct crash_elf_info *elf_info,
@@ -199,7 +201,7 @@ int FUNC(struct kexec_info *info,
 	 * A seprate program header for Backup Region*/
 	for (i = 0; i < ranges; i++, range++) {
 		unsigned long long mstart, mend;
-		if (range->type != RANGE_RAM)
+		if (range->type != RANGE_RAM && range->type != RANGE_PMEM)
 			continue;
 		mstart = range->start;
 		mend = range->end;
@@ -209,6 +211,8 @@ int FUNC(struct kexec_info *info,
 		bufp += sizeof(PHDR);
 		phdr->p_type	= PT_LOAD;
 		phdr->p_flags	= PF_R|PF_W|PF_X;
+		if (range->type == RANGE_PMEM)
+			phdr->p_flags |= PF_DEV;
 		phdr->p_offset	= mstart;
 
 		if (mstart == info->backup_src_start
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
