Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705B9C27C53
	for <kexec@archiver.kernel.org>; Mon, 17 Jun 2024 03:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2RuQSbYFt7cKP6ZJaEcTRgftqEOI1bZfsEqNkF9ojgo=; b=jr6we7uipXaCGq
	N5sb/CFO7FowpED3jlpOfsWZsN7uTdVB+k4lFwId5As9kQ+3Fi1GEkOBV5ToWefFUaHFaCltpOPLL
	I6sG0TFkk/21m1ybKKREeUcaUJjTdUyX3CU2evGEtV7JFS+/oX8O66MSkpODm9fR+6S8HcHSFdoAG
	R5jNsWa48HL74YX488oAcmlyfIe/PcGNeX8G1gd0Lddsw/N9/WK8JhfwE5CT8SwdsKl3KmDpgec3X
	j4hnI0+x5vHDf2Y8rVacEBAyMG+DXRaD2huWKQAd6jVJ/tjil/sWH0Z4qZiBMLQDiElR/l1oiOfv8
	uO+q/WjatswfWYVUdq7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ2m9-00000008yaV-0rxX;
	Mon, 17 Jun 2024 03:11:21 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ2m1-00000008yWd-2j5O
	for kexec@lists.infradead.org;
	Mon, 17 Jun 2024 03:11:16 +0000
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W2ZYQ2mtBz3560M;
	Mon, 17 Jun 2024 11:07:06 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id E488D1400D6;
	Mon, 17 Jun 2024 11:10:57 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 11:10:57 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ardb@kernel.org>, <bhe@redhat.com>, <dyoung@redhat.com>,
	<chenhaixiang3@huawei.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<yeweihua4@huawei.com>, <kexec@lists.infradead.org>, <x86@kernel.org>
Subject: [RFC PATCH] x86: efi: Reserve all boot services regions to avoid memory reservation conflicts
Date: Mon, 17 Jun 2024 19:11:53 +0800
Message-ID: <20240617111153.1945652-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.74]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240616_201114_043109_EC626AE8 
X-CRM114-Status: GOOD (  12.98  )
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

We encountered a conflict between kdump crashkernel reserved memory and
bgrt reserved image_address memory:

  # cat /proc/iomem
  ...
  2d4fd058-60efefff : System RAM
    2d4fd058-58ffffff : System RAM
      49000000-58ffffff : Crash kernel
        53cbd000-53ccffff : Reserved <== Rrserved by bgrt
  ...

This resulted in the kexec tool generating incorrect e820 tables and the
kdump kernel failed to boot. After analysis, the reason for the memory
reservation conflict is that the mem_attr_table memory falls into an
EFI_BOOT_SERVICES_DATA region, and efi_memattr_init() reserved some of
the memory in this region, efi_reserve_boot_services() not fully
reserving this memory region. The bgrt image_address memory happens to
be in this region as well, thus the memory for bgrt image_address fails
to be reserved in advance. Full details are in [1].

To resolve conflicts, we may need to reserve all EFI_BOOT_SERVICES_DATA
memory in efi_reserve_boot_services(), even if there is an overlap with
other reserved areas.

[1] https://lore.kernel.org/all/ZfjshNK7Nbdz1de3@MiWiFi-R3L-srv/T/#me0e8a206833d1e6caf962b9e2c0c204bf966c769

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/platform/efi/quirks.c | 35 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..02863f0305db 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -337,10 +337,26 @@ void __init efi_reserve_boot_services(void)
 		    md->type != EFI_BOOT_SERVICES_DATA)
 			continue;
 
+		/*
+		 * Checks if the current region has been partially or fully
+		 * reserved by someone else.
+		 */
 		already_reserved = memblock_is_region_reserved(start, size);
 
 		/*
-		 * Because the following memblock_reserve() is paired
+		 * If someone else has already reserved part of the EFI Boot
+		 * Data region (e.g. efi_memattr_init()), we should also
+		 * reserve the remaining part. This is because some efi drivers
+		 * rely on reserving EFI Boot Data here in advance, such as
+		 * bgrt (see efi_bgrt_init()), otherwise the memory reserved
+		 * by bgrt via efi_mem_reserve() will conflict with the memory
+		 * reserved by others via memblock_reserve(). So here
+		 * unconditionally reserve the whole EFI Boot Data region.
+		 */
+		memblock_reserve(start, size);
+
+		/*
+		 * Because the above memblock_reserve() is paired
 		 * with memblock_free_late() for this region in
 		 * efi_free_boot_services(), we must be extremely
 		 * careful not to reserve, and subsequently free,
@@ -352,18 +368,13 @@ void __init efi_reserve_boot_services(void)
 		 * freed is page zero (first 4Kb of memory), which may
 		 * contain boot services code/data but is marked
 		 * E820_TYPE_RESERVED by trim_bios_range().
+		 *
+		 * If we are the first to reserve the region, no
+		 * one else cares about it. We own it and can
+		 * free it later.
 		 */
-		if (!already_reserved) {
-			memblock_reserve(start, size);
-
-			/*
-			 * If we are the first to reserve the region, no
-			 * one else cares about it. We own it and can
-			 * free it later.
-			 */
-			if (can_free_region(start, size))
-				continue;
-		}
+		if (!already_reserved && can_free_region(start, size))
+			continue;
 
 		/*
 		 * We don't own the region. We must not free it.
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
