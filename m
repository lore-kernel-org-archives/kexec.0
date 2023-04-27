Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5220CC77B7C
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 10:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mHzHI/PfRbXYg5gCmiIDNhNKA+qSSxpI0MYxyDQMhCU=; b=Vo5zDnrcrzNIHq
	oN4lMN87yV0onmjLpZuJpzvW9Q3vJbAlCaHdqWia91HN01or7+bkDscZX2HLgGS7YJK4U5GXZaCAP
	xzDbWdep9dTM6/dU8IatPVJSEG4NKiioQKJ4nVdmdMVZ2fJy5OuwAgIHUFSVEsTSRsKdDWweOFiee
	4VGfPYB2ntvBR7msGbKCdM0Jy2nNKahhpu9W0lm/2TX30vWz/2AmpiQtvKemdwA7E29hZudb69DWV
	PrJGD9ZDL+y/x6784lvRp6Oa1AeaBd0H239ZCFFkCg5w3qflsFsBhZh9oBsUqaJVtNeoOIwwaGGW5
	qOd6IqK0V7jGufvJe39w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pryiM-0069V8-27;
	Thu, 27 Apr 2023 10:19:02 +0000
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pryiI-0069Ny-2U
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 10:19:00 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="103296166"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; 
   d="scan'208";a="103296166"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 19:18:54 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 569A9EDE41
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:18:52 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 96FEFD8C08
	for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 19:18:51 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
	by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9369C114147F;
	Thu, 27 Apr 2023 19:18:49 +0900 (JST)
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
Subject: [RFC PATCH v2 kexec-tools] kexec: Add and mark pmem region into PT_LOADs
Date: Thu, 27 Apr 2023 18:18:35 +0800
Message-Id: <20230427101838.12267-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427101838.12267-1-lizhijian@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27590.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27590.006
X-TMASE-Result: 10--6.121700-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cNSuJfEWZSQfBmCYUYerLHrwTlc9CcHMZerwqxtE531VIpb
	wG9fIuITIqMWro5FhUiisum7bT5AftDFhoVadDNxfUkgDiuGxn/jmgMQ17h56yS30GKAkBxWCu1
	ja6drUTmG9aEScwNGm4Ay6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuUiwP+xLbq3AxYM
	d1N0VknfHRdUVXE7DT6INmePPYNPFgO21BQaodlQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_031859_076610_14130267 
X-CRM114-Status: UNSURE (   9.90  )
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

It does:
1. Add pmem region into PT_LOADs of vmcore
2. Mark pmem region's p_flags as PF_DEV

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
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
